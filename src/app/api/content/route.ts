export const dynamic = 'force-dynamic';

import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import { authOptions } from "@/app/lib/authOptions";
import { cacheHelper } from "@/lib/redis";
import { query, withTransaction } from "@/app/lib/postgres";

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
        let sql = "SELECT *, TO_CHAR(content_date, 'YYYY-MM-DD') AS formatted_date FROM content";
        const params: any[] = [];
        if (date) {
           sql += " WHERE content_date = $1";
           params.push(date);
           sql += " ORDER BY created_at DESC LIMIT $2";
           params.push(limit);
        } else {
           sql += " ORDER BY created_at DESC LIMIT $1";
           params.push(limit);
        }
        const result = await query(sql, params);

        const rows = (result.rows || []).map((row: any) => {
          row.content_date = row.formatted_date;
          delete row.formatted_date;
          return row;
        });

        return rows;
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

  let contentData = [] as any[];
  let evidenceData = [] as any[];

  try {
    const result = await withTransaction(async (client) => {
      const contentResult = await client.query(
        "INSERT INTO content (id, user_email, user_name, content_category, content_type, content_title, content_caption, content_feedback, content_date) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING *",
        [
          content_id,
          user.email,
          user.name,
          content_category,
          content_type,
          content_title,
          content_caption,
          content_feedback,
          content_date,
        ]
      );

      const evidenceResult = await client.query(
        "INSERT INTO evidence (evidence_title, evidence_description, evidence_date, content_id, evidence_job, evidence_status, user_email) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *",
        [
          "Membuat ide konten",
          `Membuat Calendar Of Content pada tanggal "${content_date}" dengan judul "${content_title}"`,
          content_date,
          content_id,
          `COC-${content_date}`,
          "accepted",
          user.email,
        ]
      );

      return {
        content: contentResult.rows,
        evidence: evidenceResult.rows,
      };
    });

    contentData = result.content;
    evidenceData = result.evidence;
  } catch (error: any) {
    console.error("Insert content/evidence failed:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
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
