import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { logActivity } from "@/app/lib/logActivity";
import Redis from "ioredis";
import { authOptions } from "@/app/lib/authOptions";

const redis = new Redis(process.env.REDIS_URL!);
const CACHE_PREFIX = "content:";
const CACHE_EXPIRE_SECONDS = 600; // 5 menit

function getCacheKeyByMonth(dateStr: string) {
  if (!dateStr) throw new Error("Date is required for cache key");
  const parts = dateStr.split("-");
  if (parts.length < 2) throw new Error("Invalid date format");
  const month = parts[1].padStart(2, "0");
  if (!/^\d{2}$/.test(month)) throw new Error("Invalid month format");
  if (parseInt(month) < 1 || parseInt(month) > 12)
    throw new Error("Month out of range");
  return `${CACHE_PREFIX}${month}`;
}

/**
 * GET content by ID
 */
export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params; // ✅ must await in Next.js 15

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  // Ambil content_date dari DB
  const { data: contentData, error: fetchError } = await supabase
    .from("content")
    .select("content_date")
    .eq("id", id)
    .single();

  if (fetchError || !contentData)
    return NextResponse.json({ error: "Content not found" }, { status: 404 });

  let cacheKey;
  try {
    cacheKey = getCacheKeyByMonth(contentData.content_date);
  } catch {
    return NextResponse.json(
      { error: "Invalid content_date format" },
      { status: 400 }
    );
  }

  // Cek cache
  const cached = await redis.get(cacheKey);
  if (cached) {
    const cachedData = JSON.parse(cached);
    const item = cachedData.find((c: any) => c.id === id);
    if (item) return NextResponse.json(item);
  }

  // Query langsung kalo gak ada di cache
  const { data, error } = await supabase
    .from("content")
    .select("*")
    .eq("id", id)
    .single();

  if (error)
    return NextResponse.json({ error: error.message }, { status: 404 });

  // Update cache bulan
  let monthCache: any[] = cached ? JSON.parse(cached) : [];
  const idx = monthCache.findIndex((c) => c.id === id);
  if (idx !== -1) monthCache[idx] = data;
  else monthCache.push(data);

  await redis.set(
    cacheKey,
    JSON.stringify(monthCache),
    "EX",
    CACHE_EXPIRE_SECONDS
  );

  return NextResponse.json(data);
}

/**
 * DELETE content by ID
 */
export async function DELETE(
  req: NextRequest,
  context: { params: Record<string, string> }
) {
  const id = context.params.id;

  // Auth check
  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  // Ambil dulu content_title dan content_date sebelum delete
  const { data: contentData, error: fetchError } = await supabase
    .from("content")
    .select("content_title, content_date")
    .eq("id", id)
    .single();

  if (fetchError || !contentData) {
    return NextResponse.json(
      { error: "Content not found before deletion" },
      { status: 404 }
    );
  }

  let cacheKey: string;
  try {
    cacheKey = getCacheKeyByMonth(contentData.content_date);
  } catch {
    return NextResponse.json(
      { error: "Invalid content_date format" },
      { status: 400 }
    );
  }

  // Delete content
  const { error: deleteError } = await supabase
    .from("content")
    .delete()
    .eq("id", id);

  if (deleteError) {
    return NextResponse.json({ error: deleteError.message }, { status: 500 });
  }

  // Log aktivitas async (jangan tunggu)
  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "content",
    activity_name: "Content Removed",
    activity_message: `Removed content titled "${contentData.content_title}" scheduled for ${contentData.content_date}`,
  }).catch(() => {});

  // Invalidasi cache bulan
  try {
    await redis.del(cacheKey);
    console.log("Deleted cache key:", cacheKey);
  } catch (cacheError) {
    console.error("Cache invalidation error:", cacheError);
  }

  return NextResponse.json({ message: "Deleted successfully" });
}

/**
 * PUT (update) content by ID
 */
export async function PUT(
  req: NextRequest,
  context: { params: Record<string, string> }
) {
  const id = context.params.id;

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const body = await req.json();
  const {
    content_category,
    content_type,
    content_title,
    content_caption,
    content_feedback,
    content_date,
  } = body;

  if (!content_date) {
    return NextResponse.json(
      { error: "content_date is required" },
      { status: 400 }
    );
  }

  let cacheKey;
  try {
    cacheKey = getCacheKeyByMonth(content_date);
  } catch {
    return NextResponse.json(
      { error: "Invalid content_date format" },
      { status: 400 }
    );
  }

  try {
    const { data, error } = await supabase
      .from("content")
      .update({
        content_category,
        content_type,
        content_title,
        content_caption,
        content_feedback,
        content_date,
      })
      .eq("id", id)
      .select();

    if (error)
      return NextResponse.json({ error: error.message }, { status: 500 });

    await logActivity({
      user_name: user.name,
      user_email: user.email,
      activity_type: "content",
      activity_name: "Content Updated",
      activity_message: `Updated content titled "${content_title}"`,
    });

    // Invalidasi cache bulan updated content
    try {
      await redis.del(cacheKey);
    } catch (cacheError) {
      console.error("Cache invalidation error:", cacheError);
    }

    return NextResponse.json(data);
  } catch (err) {
    console.error("PUT content error:", err);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
