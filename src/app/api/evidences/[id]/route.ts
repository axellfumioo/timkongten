import { supabase } from "@/app/lib/supabase";
import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import Redis from "ioredis";
import { uploadToR2 } from "@/app/lib/uploadToR2";
import { randomUUID } from "crypto";
import { authOptions } from "@/app/lib/authOptions";

const redis = new Redis(process.env.REDIS_URL!);

// Helper ambil bulan format MM dari tanggal yyyy-mm-dd
function getMonthFromDate(dateStr: string): string {
  if (!dateStr) return "all";
  const parts = dateStr.split("-");
  return parts[1]?.padStart(2, "0") || "all";
}

export async function GET(_: Request, { params }: { params: { id: string } }) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  // Ambil data dari DB dulu supaya bisa dapat bulan
  const { data, error } = await supabase
    .from("evidence")
    .select("*")
    .eq("id", params.id)
    .single();

  if (error)
    return NextResponse.json({ error: error.message }, { status: 404 });

  const month = getMonthFromDate(data.evidence_date);
  const cacheKey = `evidence:${month}`;

  // Cek cache per bulan aja
  const cached = await redis.get(cacheKey);
  if (cached) {
    // Cache ada, kembalikan data cache yang berisi array data evidence di bulan itu
    // Tapi karena GET by id, kita perlu filter data sesuai id dari cached data
    const cachedData = JSON.parse(cached);
    const found = Array.isArray(cachedData)
      ? cachedData.find((item: any) => item.id === params.id)
      : null;
    if (found) return NextResponse.json(found);
  }

  // Kalau gak ada di cache atau data id gak ketemu di cache, return hasil DB langsung

  // Supabase ga buat cache list di sini, cuma cache bulan aja
  // Jadi simpen data bulan (array) harus dari route 2,
  // tapi di route 1 GET by id ini kita simpen cache bulan array baru dengan data yang diambil?
  // Bisa bikin cache bulan kosong dulu atau biar gak bentrok, skip cache simpan di sini aja

  // Log activity async
  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Viewed",
    activity_message: `${user.name} viewed evidence "${data.evidence_title}"`,
  }).catch(() => {});

  return NextResponse.json(data);
}

export async function PUT(
  req: Request,
  { params }: { params: { id: string } }
) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  // Ambil formData
  const formData = await req.formData();
  const evidence_title = formData.get("evidence_title") as string;
  const completion_proof = formData.get("completion_proof") as File | null;

  // Cari data lama
  const { data: oldData, error: fetchErr } = await supabase
    .from("evidence")
    .select("evidence_date, completion_proof")
    .eq("id", params.id)
    .single();

  if (fetchErr) {
    return NextResponse.json({ error: fetchErr.message }, { status: 500 });
  }

  const month = getMonthFromDate(oldData?.evidence_date);
  let fileUrl = oldData?.completion_proof || null;

  // Kalau ada file baru, upload ke R2
  if (completion_proof && completion_proof.name) {
    const fileExt = completion_proof.name.split(".").pop();
    const filename = `${randomUUID()}.${fileExt}`;
    fileUrl = await uploadToR2(
      completion_proof,
      filename,
      process.env.R2_BUCKET!
    );

    if (!fileUrl) {
      return NextResponse.json(
        { error: "Gagal mengunggah file ke R2" },
        { status: 500 }
      );
    }
  }

  // Update database
  const { error } = await supabase
    .from("evidence")
    .update({
      evidence_title,
      completion_proof: fileUrl,
    })
    .eq("id", params.id);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  // Log activity
  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Updated",
    activity_message: `${user.name} updated evidence "${evidence_title}"`,
  });

  // Hapus cache bulan itu
  await redis.del(`evidence:${month}`);

  return NextResponse.json({ message: "Evidence updated successfully" });
}

export async function DELETE(
  _: Request,
  { params }: { params: { id: string } }
) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  // Ambil data dulu buat dapetin bulan dan title buat log
  const { data: evidenceData, error: getError } = await supabase
    .from("evidence")
    .select("evidence_title,evidence_date")
    .eq("id", params.id)
    .single();

  if (getError) {
    console.error("Fetch before delete error:", getError);
  }

  const month = getMonthFromDate(evidenceData?.evidence_date);

  const { error } = await supabase
    .from("evidence")
    .delete()
    .eq("id", params.id);

  if (error)
    return NextResponse.json({ error: error.message }, { status: 500 });

  // Log activity
  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Deleted",
    activity_message: `${user.name} deleted evidence "${
      evidenceData?.evidence_title || params.id
    }"`,
  });

  // Invalidate cache bulan aja
  const cacheKey = `evidence:${month}`;
  await redis.del(cacheKey);

  return NextResponse.json({ message: "Evidence deleted successfully" });
}

export async function PATCH(
  req: Request,
  { params }: { params: { id: string } }
) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { status } = await req.json();

  if (!["accepted", "declined"].includes(status)) {
    return NextResponse.json({ error: "Invalid status" }, { status: 400 });
  }

  // Ambil data buat dapetin bulan dan judul evidence
  const { data: evidenceData, error: fetchErr } = await supabase
    .from("evidence")
    .select("evidence_title, evidence_date")
    .eq("id", params.id)
    .single();

  if (fetchErr || !evidenceData) {
    return NextResponse.json(
      { error: fetchErr?.message || "Not found" },
      { status: 404 }
    );
  }

  const month = getMonthFromDate(evidenceData.evidence_date);

  // Update status di DB
  const { error } = await supabase
    .from("evidence")
    .update({ evidence_status: status })
    .eq("id", params.id);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  // Hapus cache bulan biar data terbaru ke-fetch
  await redis.del(`evidence:${month}`);

  // Log activity
  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Status Updated",
    activity_message: `${user.name} set evidence "${evidenceData.evidence_title}" to "${status}"`,
  });

  return NextResponse.json({ message: `Evidence status updated to ${status}` });
}
