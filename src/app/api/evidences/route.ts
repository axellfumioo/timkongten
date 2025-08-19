import { supabase } from "@/app/lib/supabase";
import { NextResponse } from "next/server";
import { uploadToR2 } from "@/app/lib/uploadToR2";
import { randomUUID } from "crypto";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import redis from "@/app/lib/redis";
import { authOptions } from "@/app/lib/authOptions";

const CACHE_EXPIRE_SECONDS = 1800;

// Helper dapetin bulan format MM dari tanggal yyyy-mm-dd
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

  // ===== Redis GET =====
  const redisStart = Date.now();
  const cachedData = await redis.get(cacheKey);
  const redisTime = Date.now() - redisStart;
  if (cachedData) {
    const cachedJson: any[] = JSON.parse(cachedData);
    const acceptedEvidences = cachedJson.filter(
      (item) => item.evidence_status === "accepted"
    ).length;
    console.log(
      `Cache hit for ${cacheKey} - ${redisTime}ms, Total GET: ${
        Date.now() - totalStart
      }ms`
    );
    return NextResponse.json({ data: cachedJson, acceptedEvidences });
  }

  // ===== Optimized Supabase query =====
  // Ambil field yang perlu aja + filter bulan di query
  const monthStart = `${new Date().getFullYear()}-${evidenceMonth}-01`;
  const monthEndDate = new Date(
    new Date(monthStart).getFullYear(),
    new Date(monthStart).getMonth() + 1,
    0
  ).getDate();
  const monthEnd = `${new Date().getFullYear()}-${evidenceMonth}-${monthEndDate}`;

  let query = supabase
    .from("evidence")
    .select("id, evidence_title, evidence_date, evidence_status, created_at")
    .gte("evidence_date", monthStart)
    .lte("evidence_date", monthEnd)
    .order("created_at", { ascending: false });

  if (user) query = query.eq("user_email", user);

  const dbStart = Date.now();
  const { data, error } = await query;
  const dbTime = Date.now() - dbStart;

  if (error) {
    console.error("GET /evidences error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  const acceptedEvidences = (data || []).filter(
    (item) => item.evidence_status === "accepted"
  ).length;

  // ===== Redis SETEX =====
  const redisSetStart = Date.now();
  await redis.setex(cacheKey, CACHE_EXPIRE_SECONDS, JSON.stringify(data));
  const redisSetTime = Date.now() - redisSetStart;

  console.log(
    `DB query: ${dbTime}ms, Redis SETEX: ${redisSetTime}ms, Total GET: ${
      Date.now() - totalStart
    }ms`
  );

  return NextResponse.json({ data, acceptedEvidences });
}

export async function POST(req: Request) {
  try {
    const formData = await req.formData();
    const session = await getServerSession(authOptions);
    const user = session?.user;

    if (!user?.email) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const user_email = user.email;
    if (!user_email) {
      return NextResponse.json(
        { error: "User email tidak ditemukan" },
        { status: 400 }
      );
    }

    const evidence_title = formData.get("evidence_title") as string;
    const evidence_description = formData.get("evidence_description") as string;
    const evidence_date = formData.get("evidence_date") as string;
    const evidence_job = formData.get("evidence_job") as string;
    const evidence_status = "pending";
    const file = formData.get("completion_proof") as File | null;

    let fileUrl: string | null = null;
    if (file && file.name) {
      const fileExt = file.name.split(".").pop();
      const filename = `${randomUUID()}.${fileExt}`;
      fileUrl = await uploadToR2(file, filename, process.env.R2_BUCKET!);
      if (!fileUrl) {
        return NextResponse.json(
          { error: "Gagal mengunggah file ke R2" },
          { status: 500 }
        );
      }
    }

    const payload = {
      user_email,
      evidence_title,
      evidence_description,
      evidence_date,
      evidence_job,
      completion_proof: fileUrl,
      evidence_status,
    };

    const { data, error } = await supabase.from("evidence").insert([payload]);

    if (error) {
      console.error("Supabase insert error:", error);
      return NextResponse.json(
        { error: error.message || "Insert gagal" },
        { status: 500 }
      );
    }

    await logActivity({
      user_name: user.name,
      user_email,
      activity_type: "evidence",
      activity_name: "Evidence Created",
      activity_message: `${user.name} created evidence "${evidence_title}"`,
    });

    // Invalidasi cache bulan sesuai evidence_date
    const month = getMonthFromDate(evidence_date);
    const cacheKey = `evidence:${user.email}:${month}`;
    await redis.del(cacheKey);
    console.log(`Cache invalidated for key: ${cacheKey}`);

    return NextResponse.json(
      { message: "Evidence created successfully", url: fileUrl },
      { status: 201 }
    );
  } catch (err: any) {
    console.error("POST /evidences fatal error:", err);
    return NextResponse.json(
      { error: `Terjadi kesalahan pada server ${err}` },
      { status: 500 }
    );
  }
}
