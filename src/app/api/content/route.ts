import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import redis from "@/app/lib/redis";
import { authOptions } from "@/app/lib/authOptions";

import { randomUUID } from "crypto";

const CACHE_TTL = 60 * 30; // 5 menit biar gak basi tapi juga gak stale terlalu lama
const CACHE_PREFIX = "content:";

function getCacheKeyByMonth(dateStr: string) {
  if (!dateStr) throw new Error("Date is required for cache key");
  const parts = dateStr.split("-");
  if (parts.length < 2) throw new Error("Invalid date format");
  const month = parts[1].padStart(2, "0");
  if (!/^\d{2}$/.test(month)) throw new Error("Invalid month format");
  if (parseInt(month) < 1 || parseInt(month) > 12) {
    throw new Error("Month out of range");
  }
  return `${CACHE_PREFIX}${month}`;
}

// GET: Ambil semua content
export async function GET(req: Request) {
  const totalStart = Date.now();

  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);
  const date = searchParams.get("date") || ""; // YYYY-MM-DD
  const limit = Math.min(parseInt(searchParams.get("limit") || "50"), 100); // cap at 100

  const cacheKey = date ? `content:${date}` : "content:all";
  let redisHit = false;

  // ===== Redis GET =====
  let cached;
  const redisStart = Date.now();
  try {
    cached = await redis.get(cacheKey);
    if (cached) {
      redisHit = true;
      const redisTime = Date.now() - redisStart;
      console.log(`Redis hit for ${cacheKey} in ${redisTime}ms`);
      return NextResponse.json({
        data: JSON.parse(cached),
        debug: {
          cacheKey,
          redisHit,
          redisTime,
          dbTime: 0,
          totalTime: Date.now() - totalStart,
          limit,
          dateFilter: date || "none",
        },
      });
    }
  } catch (err) {
    console.error("Redis GET failed:", err);
  }
  const redisTime = Date.now() - redisStart;

  // ===== Supabase Query =====
  let query = supabase
    .from("content")
    .select(
      "id, content_title, content_caption, content_date, content_category, created_at, user_name"
    );

  if (date) {
    query = query
      .eq("content_date::date", date)
      .order("created_at", { ascending: false })
      .limit(limit);
  } else {
    query = query.order("created_at", { ascending: false }).limit(limit);
  }

  const dbStart = Date.now();
  const { data, error } = await query;
  const dbTime = Date.now() - dbStart;

  if (error) {
    console.error("Database error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  // ===== Redis SETEX =====
  const ttl = date ? CACHE_TTL * 2 : CACHE_TTL;
  try {
    await redis.setex(cacheKey, ttl, JSON.stringify(data || []));
  } catch (err) {
    console.error("Redis SETEX failed:", err);
  }

  const totalTime = Date.now() - totalStart;
  console.log(
    `DB query: ${dbTime}ms, Total GET: ${totalTime}ms, Rows: ${
      data?.length || 0
    }`
  );

  return NextResponse.json({
    data: data || [],
    debug: {
      cacheKey,
      redisHit,
      redisTime,
      dbTime,
      totalTime,
      limit,
      dateFilter: date || "none",
    },
  });
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

  const content_id = `${randomUUID()}`;

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
    await redis.del(`content:${content_date}`);
    await redis.del(`content:all`);

    // invalidate content per user (semua key yang match user.email)
    const keys = getCacheKeyByMonth(content_date);
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
