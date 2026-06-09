export const dynamic = 'force-dynamic';

import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { logActivity } from "@/app/lib/logActivity";
import { authOptions } from "@/app/lib/authOptions";
import { randomUUID } from "crypto";
import { uploadToB2 } from "@/app/lib/uploadToB2";
import { cacheHelper } from "@/lib/redis";
import { query } from "@/app/lib/postgres";

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

  const cacheKey = `evidence:id:${id}`;
  const data = await cacheHelper.getOrSet(
    cacheKey,
    async () => {
      const result = await query("SELECT * FROM evidence WHERE id = $1 LIMIT 1", [
        id,
      ]);
      return result.rows[0] ?? null;
    },
    300
  );

  if (!data)
    return NextResponse.json({ error: "Evidence not found" }, { status: 404 });

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
  const evidence_description = formData.get("evidence_description") as string;
  const evidence_job = formData.get("evidence_job") as string;
  const evidence_date = formData.get("evidence_date") as string;
  const completion_proof = formData.get("completion_proof") as string | null;

  const oldResult = await query<{
    evidence_date: string;
    completion_proof: string | null;
  }>("SELECT evidence_date, completion_proof FROM evidence WHERE id = $1 LIMIT 1", [
    id,
  ]);

  const oldData = oldResult.rows[0];
  if (!oldData)
    return NextResponse.json({ error: "Not found" }, { status: 404 });

  let fileUrl = oldData.completion_proof || null;

  if (completion_proof && completion_proof.trim() !== "") {
    fileUrl = completion_proof;
  }

  const updateResult = await query(
    "UPDATE evidence SET evidence_title = $1, evidence_description = $2, evidence_job = $3, evidence_date = $4, completion_proof = $5 WHERE id = $6",
    [evidence_title, evidence_description, evidence_job, evidence_date, fileUrl, id]
  );

  if (updateResult.rowCount === 0)
    return NextResponse.json({ error: "Not found" }, { status: 404 });

  // Invalidate cache immediately to prevent stale GET requests
  await cacheHelper.invalidate(`evidence:id:${id}`);
  await cacheHelper.invalidateEvidences(user.email);

  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Updated",
    activity_message: `${user.name} updated evidence "${evidence_title}"`,
  }).catch(err => console.error("Background task error:", err));

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

  const deleteResult = await query<{
    user_email: string;
    evidence_title: string;
    evidence_date: string;
  }>(
    "DELETE FROM evidence WHERE id = $1 RETURNING user_email, evidence_title, evidence_date",
    [id]
  );

  if (deleteResult.rowCount === 0)
    return NextResponse.json({ error: "Not found" }, { status: 404 });

  const evidenceData = deleteResult.rows[0];

  // Invalidate cache immediately to prevent stale GET requests
  await cacheHelper.invalidate(`evidence:id:${id}`);
  await cacheHelper.invalidateEvidences(user.email);

  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Deleted",
    activity_message: `${user.name} deleted evidence "${
      evidenceData?.evidence_title || id
    }"`,
  }).catch(err => console.error("Background task error:", err));

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

  const updateResult = await query<{
    user_email: string;
    evidence_title: string;
    evidence_date: string;
  }>(
    "UPDATE evidence SET evidence_status = $1 WHERE id = $2 RETURNING user_email, evidence_title, evidence_date",
    [status, id]
  );

  if (updateResult.rowCount === 0)
    return NextResponse.json({ error: "Not found" }, { status: 404 });

  const evidenceData = updateResult.rows[0];

  // Invalidate cache immediately to prevent stale GET requests
  await cacheHelper.invalidate(`evidence:id:${id}`);
  await cacheHelper.invalidateEvidences(user.email);

  logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Status Updated",
    activity_message: `${user.name} set evidence "${evidenceData.evidence_title}" to "${status}"`,
  }).catch(err => console.error("Background task error:", err));

  return NextResponse.json({ message: `Evidence status updated to ${status}` });
}
