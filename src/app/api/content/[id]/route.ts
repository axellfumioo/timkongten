import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { logActivity } from "@/app/lib/logActivity";
import { authOptions } from "@/app/lib/authOptions";
import { cacheHelper } from "@/lib/redis";

/**
 * GET content by ID
 */
export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  // Query langsung dari Supabase
  const { data, error } = await supabase
    .from("content")
    .select("*")
    .eq("id", id)
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 404 });
  }

  return NextResponse.json(data);
}

/**
 * DELETE content by ID
 */
export async function DELETE(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

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

  // Delete content
  const { error: deleteError } = await supabase
    .from("content")
    .delete()
    .eq("id", id);

  if (deleteError) {
    return NextResponse.json({ error: deleteError.message }, { status: 500 });
  }

  // Invalidate cache
  await cacheHelper.invalidatePattern('content:*');
  await cacheHelper.invalidatePattern('evidence:*');
  await cacheHelper.invalidate('stats');

  // Log aktivitas async
  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "content",
    activity_name: "Content Removed",
    activity_message: `Removed content titled "${contentData.content_title}" scheduled for ${contentData.content_date}`,
  }).catch(() => {});

  return NextResponse.json({ message: "Deleted successfully" });
}

/**
 * PUT (update) content by ID
 */
export async function PUT(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

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

  if (!content_date) {
    return NextResponse.json(
      { error: "content_date is required" },
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

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    // Invalidate cache
    await cacheHelper.invalidatePattern('content:*');
    await cacheHelper.invalidate('stats');

    await logActivity({
      user_name: user.name,
      user_email: user.email,
      activity_type: "content",
      activity_name: "Content Updated",
      activity_message: `Updated content titled "${content_title}"`,
    });

    return NextResponse.json(data);
  } catch (err) {
    console.error("PUT content error:", err);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
