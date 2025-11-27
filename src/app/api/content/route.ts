import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import { authOptions } from "@/app/lib/authOptions";
import { cacheHelper } from "@/lib/redis";

import { randomUUID } from "crypto";

// GET: Ambil semua content
export async function GET(req: Request) {
  const totalStart = Date.now();

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);
  const date = searchParams.get("date") || "";
  const limit = Math.min(parseInt(searchParams.get("limit") || "50"), 100);

  // Cache key berdasarkan parameter
  const cacheKey = `content:${date || 'all'}:${limit}`;

  try {
    // Gunakan cache helper
    const dbStart = Date.now();
    const data = await cacheHelper.getOrSet(
      cacheKey,
      async () => {
        const { data: dbData, error } = await supabase.rpc("get_content", {
          filter_date: date || null,
          row_limit: limit,
        });

        if (error) {
          throw new Error(error.message);
        }

        return dbData || [];
      },
      300 // Cache 5 menit
    );

    const dbTime = Date.now() - dbStart;
    const totalTime = Date.now() - totalStart;
    
    console.log(
      `DB query: ${dbTime}ms, Total GET: ${totalTime}ms, Rows: ${data.length}`
    );

    return NextResponse.json({
      data,
      debug: {
        dbTime,
        totalTime,
        limit,
        dateFilter: date || "none",
      },
    });
  } catch (error: any) {
    console.error("Database error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
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

  const content_id = randomUUID();

  // Insert content dulu, tunggu hasilnya
  const { data: contentData, error: contentError } = await supabase
    .from("content")
    .insert([
      {
        id: content_id,
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

  // Insert evidence setelah content berhasil
  const { data: evidenceData, error: evidenceError } = await supabase
    .from("evidence")
    .insert([
      {
        evidence_title: `Membuat ide konten`,
        evidence_description: `Membuat Calendar Of Content pada tanggal "${content_date}" dengan judul "${content_title}"`,
        evidence_date: content_date,
        content_id: content_id,
        evidence_job: `COC-${content_date}`,
        evidence_status: "accepted",
        user_email: user.email,
      },
    ])
    .select();

  if (evidenceError) {
    console.error(`Insert evidence failed: ${evidenceError.message}`);
    return NextResponse.json(
      { content: contentData, evidenceError: evidenceError.message },
      { status: 500 }
    );
  }

  // Invalidate cache setelah insert
  await cacheHelper.invalidatePattern('content:*');
  await cacheHelper.invalidatePattern('evidence:*');
  await cacheHelper.invalidate('stats');

  // Logging async
  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "content",
    activity_name: "Content Create",
    activity_message: `Created new content titled "${content_title}" scheduled for ${content_date}`,
  }).catch((err) => {
    console.error("Async logging failed:", err);
  });

  return NextResponse.json(
    {
      content: contentData,
      evidence: evidenceData,
    },
    { status: 201 }
  );
}
