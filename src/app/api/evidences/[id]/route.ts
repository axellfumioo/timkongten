import { supabase } from "@/app/lib/supabase";
import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import Redis from "ioredis";
import { uploadToR2 } from "@/app/lib/uploadToR2";
import { randomUUID } from "crypto";
import { authOptions } from "@/app/lib/authOptions";

// Init Redis
const redis = new Redis(process.env.REDIS_URL!);

// Helper ambil bulan format MM dari tanggal yyyy-mm-dd
function getMonthFromDate(dateStr: string): string {
  if (!dateStr) return "all";
  const parts = dateStr.split("-");
  return parts[1]?.padStart(2, "0") || "all";
}

// GET by ID
export async function GET(
  req: Request,
  context: { params: { id: string } }
) {
  const { id } = context.params;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  // Ambil data dari DB
  const { data, error } = await supabase
    .from("evidence")
    .select("*")
    .eq("id", id)
    .single();

  if (error)
    return NextResponse.json({ error: error.message }, { status: 404 });

  const month = getMonthFromDate(data.evidence_date);
  const cacheKey = `evidence:${month}`;

  // Cek cache bulan
  const cached = await redis.get(cacheKey);
  if (cached) {
    const cachedData = JSON.parse(cached);
    const found = Array.isArray(cachedData)
      ? cachedData.find((item: any) => item.id === id)
      : null;
    if (found) return NextResponse.json(found);
  }

  // Log activity (async, tidak blocking)
  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Viewed",
    activity_message: `${user.name} viewed evidence "${data.evidence_title}"`,
  }).catch(() => {});

  return NextResponse.json(data);
}

// PUT (update evidence + upload file ke R2)
export async function PUT(
  req: Request,
  context: { params: { id: string } }
) {
  const { id } = context.params;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const formData = await req.formData();
  const evidence_title = formData.get("evidence_title") as string;
  const completion_proof = formData.get("completion_proof") as File | null;

  // Cari data lama
  const { data: oldData, error: fetchErr } = await supabase
    .from("evidence")
    .select("evidence_date, completion_proof")
    .eq("id", id)
    .single();

  if (fetchErr)
    return NextResponse.json({ error: fetchErr.message }, { status: 500 });

  const month = getMonthFromDate(oldData?.evidence_date);
  let fileUrl = oldData?.completion_proof || null;

  // Upload file baru jika ada
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

  // Update DB
  const { error } = await supabase
    .from("evidence")
    .update({
      evidence_title,
      completion_proof: fileUrl,
    })
    .eq("id", id);

  if (error)
    return NextResponse.json({ error: error.message }, { status: 500 });

  // Log activity
  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Updated",
    activity_message: `${user.name} updated evidence "${evidence_title}"`,
  });

  // Invalidate cache bulan
  await redis.del(`evidence:${month}`);

  return NextResponse.json({ message: "Evidence updated successfully" });
}

// DELETE
export async function DELETE(
  req: Request,
  context: { params: { id: string } }
) {
  const { id } = context.params;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  // Ambil data dulu buat log
  const { data: evidenceData, error: getError } = await supabase
    .from("evidence")
    .select("evidence_title,evidence_date")
    .eq("id", id)
    .single();

  if (getError) console.error("Fetch before delete error:", getError);

  const month = getMonthFromDate(evidenceData?.evidence_date);

  const { error } = await supabase.from("evidence").delete().eq("id", id);
  if (error)
    return NextResponse.json({ error: error.message }, { status: 500 });

  // Log activity
  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Deleted",
    activity_message: `${user.name} deleted evidence "${
      evidenceData?.evidence_title || id
    }"`,
  });

  // Invalidate cache bulan
  await redis.del(`evidence:${month}`);

  return NextResponse.json({ message: "Evidence deleted successfully" });
}

// PATCH (update status accepted/declined)
export async function PATCH(
  req: Request,
  context: { params: { id: string } }
) {
  const { id } = context.params;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { status } = await req.json();

  if (!["accepted", "declined"].includes(status)) {
    return NextResponse.json({ error: "Invalid status" }, { status: 400 });
  }

  // Ambil data untuk bulan & title
  const { data: evidenceData, error: fetchErr } = await supabase
    .from("evidence")
    .select("evidence_title, evidence_date")
    .eq("id", id)
    .single();

  if (fetchErr || !evidenceData) {
    return NextResponse.json(
      { error: fetchErr?.message || "Not found" },
      { status: 404 }
    );
  }

  const month = getMonthFromDate(evidenceData.evidence_date);

  // Update status
  const { error } = await supabase
    .from("evidence")
    .update({ evidence_status: status })
    .eq("id", id);

  if (error)
    return NextResponse.json({ error: error.message }, { status: 500 });

  // Invalidate cache
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
