import { supabase } from "@/app/lib/supabase";
import { NextResponse } from "next/server";
import { uploadToB2 } from "@/app/lib/uploadToB2";
import { randomUUID } from "crypto";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import redis from "@/app/lib/redis";
import { authOptions } from "@/app/lib/authOptions";

const CACHE_EXPIRE_SECONDS = 1800;

// Helper ambil bulan format MM
function getMonthFromDate(dateStr: string): string {
  if (!dateStr) return "all";
  const parts = dateStr.split("-");
  return parts[1]?.padStart(2, "0") || "all";
}

export async function GET(req: Request) {
  const totalStart = Date.now();

  const session = await getServerSession(authOptions);
  const userauth = session?.user;

  if (!userauth?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);
  const user = searchParams.get("user");
  const monthParam = searchParams.get("month");

  const currentMonth = String(new Date().getMonth() + 1).padStart(2, "0");
  const evidenceMonth = monthParam ? monthParam.padStart(2, "0") : currentMonth;

  const cacheKey = `evidence:${user}:${evidenceMonth}`;

  // ===== Redis GET Profiling =====
  const redisGetStart = Date.now();
  const cachedData = await redis.get(cacheKey);
  const redisGetTime = Date.now() - redisGetStart;

  if (cachedData) {
    const cachedJson: any[] = JSON.parse(cachedData);
    const acceptedEvidences = cachedJson.filter(
      (item) => item.evidence_status === "accepted"
    ).length;

    const profiling = {
      redis_get: `${redisGetTime}ms`,
      supabase: "0ms",
      redis_set: "0ms",
      total: `${Date.now() - totalStart}ms`,
    };

    console.log("[GET /evidences] Cache HIT", profiling);

    return NextResponse.json(
      { data: cachedJson, acceptedEvidences, profiling },
      {
        status: 200,
        headers: {
          "X-Redis-Get": `${redisGetTime}ms`,
          "X-Supabase-Query": "0ms",
          "X-Redis-Set": "0ms",
          "X-Total-Time": `${Date.now() - totalStart}ms`,
        },
      }
    );
  }

  // ===== Supabase Query Profiling =====
  const monthStart = `${new Date().getFullYear()}-${evidenceMonth}-01`;
  const monthEndDate = new Date(
    new Date(monthStart).getFullYear(),
    new Date(monthStart).getMonth() + 1,
    0
  ).getDate();
  const monthEnd = `${new Date().getFullYear()}-${evidenceMonth}-${monthEndDate}`;

  

  const dbStart = Date.now();
  const { data, error } = await supabase.rpc("get_evidences", {
  target_email: user ?? null,
  start_date: monthStart,
  end_date: monthEnd,
});

  const dbTime = Date.now() - dbStart;

  if (error) {
    console.error("GET /evidences error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  const acceptedEvidences = (data || []).filter(
    (item: any) => item.evidence_status === "accepted"
  ).length;

  // ===== Redis SET Profiling =====
  const redisSetStart = Date.now();
  await redis.setex(cacheKey, CACHE_EXPIRE_SECONDS, JSON.stringify(data));
  const redisSetTime = Date.now() - redisSetStart;

  const profiling = {
    redis_get: `${redisGetTime}ms`,
    supabase: `${dbTime}ms`,
    redis_set: `${redisSetTime}ms`,
    total: `${Date.now() - totalStart}ms`,
  };

  console.log("[GET /evidences] Cache MISS", profiling);

  return NextResponse.json(
    { data, acceptedEvidences, profiling },
    {
      status: 200,
      headers: {
        "X-Redis-Get": `${redisGetTime}ms`,
        "X-Supabase-Query": `${dbTime}ms`,
        "X-Redis-Set": `${redisSetTime}ms`,
        "X-Total-Time": `${Date.now() - totalStart}ms`,
      },
    }
  );
}

export async function POST(req: Request) {
  const totalStart = Date.now();
  try {
    const formData = await req.formData();
    const session = await getServerSession(authOptions);
    const user = session?.user;

    if (!user?.email) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const user_email = user.email;

    const evidence_title = formData.get("evidence_title") as string;
    const evidence_description = formData.get("evidence_description") as string;
    const evidence_date = formData.get("evidence_date") as string;
    const evidence_job = formData.get("evidence_job") as string;
    const content_id = formData.get("content_id") as string | null;
    const file = formData.get("completion_proof") as File | null;

    // ===== Upload File Profiling =====
    let fileUrl: string | null = null;
    let uploadTime = 0;
    if (file && file.name) {
      const fileExt = file.name.split(".").pop();
      const filename = `${randomUUID()}.${fileExt}`;
      const uploadStart = Date.now();
      fileUrl = await uploadToB2(file, filename, process.env.B2_BUCKET!);
      uploadTime = Date.now() - uploadStart;
    }

    if (file && !fileUrl) {
      return NextResponse.json(
        { error: "Gagal mengunggah file ke R2" },
        { status: 500 }
      );
    }

    const payload = {
      user_email,
      evidence_title,
      evidence_description,
      evidence_date,
      evidence_job,
      content_id,
      completion_proof: fileUrl,
      evidence_status: "pending",
    };

    // ===== Supabase Insert + Cache Invalidate Profiling =====
    const month = getMonthFromDate(evidence_date);
    const cacheKey = `evidence:${user.email}:${month}`;

    const insertStart = Date.now();
    const [insertResult] = await Promise.all([
      supabase.from("evidence").insert([payload]),
      logActivity({
        user_name: user.name,
        user_email,
        activity_type: "evidence",
        activity_name: "Evidence Created",
        activity_message: `${user.name} created evidence "${evidence_title}"`,
      }),
      redis.del(cacheKey),
    ]);
    const insertTime = Date.now() - insertStart;

    if (insertResult.error) {
      console.error("Supabase insert error:", insertResult.error);
      return NextResponse.json(
        { error: insertResult.error.message || "Insert gagal" },
        { status: 500 }
      );
    }

    const profiling = {
      upload_b2: `${uploadTime}ms`,
      insert_supabase: `${insertTime}ms`,
      total: `${Date.now() - totalStart}ms`,
    };

    console.log("[POST /evidences]", profiling);

    return NextResponse.json(
      { message: "Evidence created successfully", url: fileUrl, profiling },
      {
        status: 201,
        headers: {
          "X-Upload-R2": `${uploadTime}ms`,
          "X-Supabase-Insert": `${insertTime}ms`,
          "X-Total-Time": `${Date.now() - totalStart}ms`,
        },
      }
    );
  } catch (err: any) {
    console.error("POST /evidences fatal error:", err);
    return NextResponse.json(
      { error: `Terjadi kesalahan pada server ${err}` },
      { status: 500 }
    );
  }
}
