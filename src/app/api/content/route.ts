import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import redis from "@/app/lib/redis";
import { authOptions } from "@/app/lib/authOptions";

const CACHE_TTL = 60 * 5; // 5 menit biar gak basi tapi juga gak stale terlalu lama

// GET: Ambil semua content
export async function GET(req: Request) {
  const totalStart = Date.now();

  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);
  const date = searchParams.get("date"); // YYYY-MM-DD
  const limit = parseInt(searchParams.get("limit") || "50"); // default 50 rows

  const cacheKey = `content:${user.email}:${date || "all"}:limit:${limit}`;

  // ===== Redis GET =====
  let cached;
  try {
    cached = await redis.get(cacheKey);
    if (cached) {
      console.log(`Redis hit for ${cacheKey}`);
      return NextResponse.json(JSON.parse(cached));
    }
  } catch (err) {
    console.error("Redis GET failed:", err);
  }

  // ===== Supabase Query =====
  let query = supabase
    .from("content")
    // ambil field penting aja
    .select("id, content_title, content_date, content_category, created_at")
    .order("created_at", { ascending: false })
    .limit(limit);

  if (date) {
    query = query
      .gte("content_date", `${date}T00:00:00`)
      .lte("content_date", `${date}T23:59:59`);
  }

  const dbStart = Date.now();
  const { data, error } = await query;
  const dbTime = Date.now() - dbStart;

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  // ===== Redis SETEX =====
  try {
    await redis.setex(cacheKey, CACHE_TTL, JSON.stringify(data));
  } catch (err) {
    console.error("Redis SETEX failed:", err);
  }

  const totalTime = Date.now() - totalStart;
  console.log(`DB query: ${dbTime}ms, Total GET: ${totalTime}ms`);

  return NextResponse.json(data);
}

export async function POST(req: NextRequest) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const {
    content_category,
    content_type,
    content_title,
    content_caption,
    content_feedback,
    content_date,
  } = body;

  const { data: contentData, error: contentError } = await supabase
    .from("content")
    .insert([
      {
        user_email: user.email,
        user_name: user.name,
        content_category,
        content_type,
        content_title,
        content_caption,
        content_feedback,
        content_date,
      },
    ])
    .select();

  if (contentError) {
    return NextResponse.json({ error: contentError.message }, { status: 500 });
  }

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "content",
    activity_name: "Content Create",
    activity_message: `Created new content titled "${content_title}" scheduled for ${content_date}`,
  });

  const { data: evidenceData, error: evidenceError } = await supabase
    .from("evidence")
    .insert([
      {
        evidence_title: `Membuat konten`,
        evidence_description: `Ditugaskan untuk membuat konten "${content_title}"`,
        evidence_date: content_date,
        evidence_job: `COC-${content_date}`,
        evidence_status: "needaction",
        user_email: user.email,
      },
    ])
    .select();

  if (evidenceError) {
    console.error(`Insert evidence failed: ${evidenceError.message}`);
    return NextResponse.json(
      {
        content: contentData,
        evidenceError: evidenceError.message,
      },
      { status: 500 }
    );
  }

  // invalidate redis cache
  try {
    // invalidate bulanan evidence
    const month = new Date(content_date).toISOString().slice(5, 7);
    await redis.del(`evidence:${user.email}:${month}`);

    // invalidate content per user (semua key yang match user.email)
    const keys = await redis.keys(`content:${user.email}:*`);
    if (keys.length > 0) {
      await redis.del(keys);
    }

    console.log(`Redis invalidated for user ${user.email}`);
  } catch (err) {
    console.error("Redis invalidate failed:", err);
  }

  return NextResponse.json(
    {
      content: contentData,
      evidence: evidenceData,
    },
    { status: 201 }
  );
}
