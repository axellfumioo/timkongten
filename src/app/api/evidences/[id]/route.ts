import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { logActivity } from "@/app/lib/logActivity";
import redis from "@/app/lib/redis";
import { authOptions } from "@/app/lib/authOptions";
import { randomUUID } from "crypto";
import { uploadToB2 } from "@/app/lib/uploadToB2";

const CACHE_PREFIX = "evidence:";
const CACHE_EXPIRE_SECONDS = 1800;

// Helper ambil bulan format MM dari tanggal yyyy-mm-dd
function getMonthFromDate(dateString: string) {
  const date = new Date(dateString);
  const month = date.getMonth() + 1; // getMonth() dari 0-11
  return month.toString().padStart(2, "0"); // jadi '08' untuk Agustus
}

/**
 * GET Evidence by ID
 */
export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { data, error } = await supabase
    .from("evidence")
    .select("*")
    .eq("id", id)
    .single();

  if (error || !data)
    return NextResponse.json({ error: "Evidence not found" }, { status: 404 });

  const month = getMonthFromDate(data.evidence_date);
  const cacheKey = `${CACHE_PREFIX}${user.email}:${month}`;


  const cached = await redis.get(cacheKey);
  if (cached) {
    const cachedData = JSON.parse(cached);
    const found = Array.isArray(cachedData)
      ? cachedData.find((item: any) => item.id === id)
      : null;
    if (found) return NextResponse.json(found);
  }

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

/**
 * PUT / Update Evidence by ID
 */
export async function PUT(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const formData = await req.formData();
  const evidence_title = formData.get("evidence_title") as string;
  const completion_proof = formData.get("completion_proof") as File | null;

  const { data: oldData, error: fetchErr } = await supabase
    .from("evidence")
    .select("evidence_date, completion_proof")
    .eq("id", id)
    .single();

  if (fetchErr || !oldData)
    return NextResponse.json(
      { error: fetchErr?.message || "Not found" },
      { status: 404 }
    );

  const month = getMonthFromDate(oldData.evidence_date);
  let fileUrl = oldData.completion_proof || null;

  if (completion_proof && completion_proof.name) {
    const fileExt = completion_proof.name.split(".").pop();
    const filename = `${randomUUID()}.${fileExt}`;
    fileUrl = await uploadToB2(
      completion_proof,
      filename,
      process.env.R2_BUCKET!
    );
    if (!fileUrl)
      return NextResponse.json(
        { error: "Failed uploading file" },
        { status: 500 }
      );
  }

  const { error } = await supabase
    .from("evidence")
    .update({ evidence_title, completion_proof: fileUrl })
    .eq("id", id);

  if (error)
    return NextResponse.json({ error: error.message }, { status: 500 });

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Updated",
    activity_message: `${user.name} updated evidence "${evidence_title}"`,
  });

  await redis.del(`${CACHE_PREFIX}${user.email}:${month}`);

  return NextResponse.json({ message: "Evidence updated successfully" });
}

/**
 * DELETE Evidence by ID
 */
export async function DELETE(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { data: evidenceData, error: getError } = await supabase
    .from("evidence")
    .select("user_email,evidence_title,evidence_date")
    .eq("id", id)
    .single();

  const month = getMonthFromDate(evidenceData?.evidence_date);

  const { error } = await supabase.from("evidence").delete().eq("id", id);

  if (error)
    return NextResponse.json({ error: error.message }, { status: 500 });

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Deleted",
    activity_message: `${user.name} deleted evidence "${
      evidenceData?.evidence_title || id
    }"`,
  });

  await redis.del(`${CACHE_PREFIX}${evidenceData?.user_email}:${month}`);
  // console.log(`OAKWOAKWOWAKOAWKWAOKWAOKAWOKAWOKWAOKWAOWAK | ${CACHE_PREFIX}:${evidenceData?.user_email}:${month}`)

  return NextResponse.json({ message: "Evidence deleted successfully" });
}

/**
 * PATCH Evidence Status by ID
 */
export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  const { id } = await params;

  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { status } = await req.json();
  if (!["accepted", "declined"].includes(status))
    return NextResponse.json({ error: "Invalid status" }, { status: 400 });

  const { data: evidenceData, error: fetchErr } = await supabase
    .from("evidence")
    .select("user_email, evidence_title, evidence_date")
    .eq("id", id)
    .single();

  if (fetchErr || !evidenceData)
    return NextResponse.json(
      { error: fetchErr?.message || "Not found" },
      { status: 404 }
    );

  const month = getMonthFromDate(evidenceData.evidence_date);

  const { error } = await supabase
    .from("evidence")
    .update({ evidence_status: status })
    .eq("id", id);

  if (error)
    return NextResponse.json({ error: error.message }, { status: 500 });

  await redis.del(`${CACHE_PREFIX}${evidenceData.user_email}:${month}`);

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Status Updated",
    activity_message: `${user.name} set evidence "${evidenceData.evidence_title}" to "${status}"`,
  });

  return NextResponse.json({ message: `Evidence status updated to ${status}` });
}
