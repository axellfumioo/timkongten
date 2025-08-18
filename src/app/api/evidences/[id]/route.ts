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

export async function GET(
  _req: Request,
  context: { params: { id: string } }
) {
  const { params } = context;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { data, error } = await supabase
    .from("evidence")
    .select("*")
    .eq("id", params.id)
    .single();

  if (error) return NextResponse.json({ error: error.message }, { status: 404 });

  const month = getMonthFromDate(data.evidence_date);
  const cacheKey = `evidence:${month}`;

  const cached = await redis.get(cacheKey);
  if (cached) {
    const cachedData = JSON.parse(cached);
    const found = Array.isArray(cachedData)
      ? cachedData.find((item: any) => item.id === params.id)
      : null;
    if (found) return NextResponse.json(found);
  }

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
  context: { params: { id: string } }
) {
  const { params } = context;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const formData = await req.formData();
  const evidence_title = formData.get("evidence_title") as string;
  const completion_proof = formData.get("completion_proof") as File | null;

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

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Updated",
    activity_message: `${user.name} updated evidence "${evidence_title}"`,
  });

  await redis.del(`evidence:${month}`);

  return NextResponse.json({ message: "Evidence updated successfully" });
}

export async function DELETE(
  _req: Request,
  context: { params: { id: string } }
) {
  const { params } = context;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { data: evidenceData, error: getError } = await supabase
    .from("evidence")
    .select("evidence_title,evidence_date")
    .eq("id", params.id)
    .single();

  const month = getMonthFromDate(evidenceData?.evidence_date);

  const { error } = await supabase
    .from("evidence")
    .delete()
    .eq("id", params.id);

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Deleted",
    activity_message: `${user.name} deleted evidence "${
      evidenceData?.evidence_title || params.id
    }"`,
  });

  await redis.del(`evidence:${month}`);

  return NextResponse.json({ message: "Evidence deleted successfully" });
}

export async function PATCH(
  req: Request,
  context: { params: { id: string } }
) {
  const { params } = context;
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { status } = await req.json();

  if (!["accepted", "declined"].includes(status)) {
    return NextResponse.json({ error: "Invalid status" }, { status: 400 });
  }

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

  const { error } = await supabase
    .from("evidence")
    .update({ evidence_status: status })
    .eq("id", params.id);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  await redis.del(`evidence:${month}`);

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Status Updated",
    activity_message: `${user.name} set evidence "${evidenceData.evidence_title}" to "${status}"`,
  });

  return NextResponse.json({ message: `Evidence status updated to ${status}` });
}
