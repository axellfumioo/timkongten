export const dynamic = 'force-dynamic';

import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { logActivity } from "@/app/lib/logActivity";
import { authOptions } from "@/app/lib/authOptions";
import { cacheHelper } from "@/lib/redis";
import { query } from "@/app/lib/postgres";

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

  // Query langsung dari database
  const result = await query("SELECT * FROM content WHERE id = $1 LIMIT 1", [
    id,
  ]);
  const data = result.rows[0];

  if (!data) {
    return NextResponse.json({ error: "Content not found" }, { status: 404 });
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
  const contentResult = await query<{
    content_title: string;
    content_date: string;
  }>("SELECT content_title, content_date FROM content WHERE id = $1 LIMIT 1", [
    id,
  ]);

  const contentData = contentResult.rows[0];
  if (!contentData) {
    return NextResponse.json(
      { error: "Content not found before deletion" },
      { status: 404 }
    );
  }

  // Delete content
  const deleteResult = await query("DELETE FROM content WHERE id = $1", [id]);
  if (deleteResult.rowCount === 0) {
    return NextResponse.json({ error: "Content not found" }, { status: 404 });
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
    const result = await query(
      "UPDATE content SET content_category = $1, content_type = $2, content_title = $3, content_caption = $4, content_feedback = $5, content_date = $6 WHERE id = $7 RETURNING *",
      [
        content_category,
        content_type,
        content_title,
        content_caption,
        content_feedback,
        content_date,
        id,
      ]
    );

    if (result.rowCount === 0) {
      return NextResponse.json({ error: "Content not found" }, { status: 404 });
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

    return NextResponse.json(result.rows);
  } catch (err) {
    console.error("PUT content error:", err);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
