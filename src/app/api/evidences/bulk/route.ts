export const dynamic = 'force-dynamic';

import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { authOptions } from "@/app/lib/authOptions";
import { query } from "@/app/lib/postgres";
import { cacheHelper } from "@/lib/redis";
import { logActivity } from "@/app/lib/logActivity";

export async function PATCH(req: NextRequest) {
  const session = await getServerSession(authOptions);
  const user = session?.user;
  if (!user?.email)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { ids, status } = await req.json();
  
  if (!Array.isArray(ids) || ids.length === 0) {
    return NextResponse.json({ error: "No IDs provided" }, { status: 400 });
  }

  if (!["accepted", "declined"].includes(status))
    return NextResponse.json({ error: "Invalid status" }, { status: 400 });

  try {
    // Bulk update using Postgres ANY operator
    const updateResult = await query<{
      id: string;
      user_email: string;
      evidence_title: string;
    }>(
      "UPDATE evidence SET evidence_status = $1 WHERE id = ANY($2::uuid[]) RETURNING id, user_email, evidence_title",
      [status, ids]
    );

    if (updateResult.rowCount === 0)
      return NextResponse.json({ error: "No records updated" }, { status: 404 });

    const updatedRows = updateResult.rows;

    // Invalidate caches
    // Since this is a bulk operation, we invalidate the specific items and clear general queries
    await Promise.all([
      ...updatedRows.map(row => cacheHelper.invalidate(`evidence:id:${row.id}`)),
      ...Array.from(new Set(updatedRows.map(row => row.user_email))).map(email => 
        cacheHelper.invalidateEvidences(email)
      ),
      cacheHelper.invalidatePattern("admin:evidences:*")
    ]);

    logActivity({
      user_name: user.name,
      user_email: user.email,
      activity_type: "evidence",
      activity_name: "Bulk Evidence Status Updated",
      activity_message: `${user.name} bulk updated ${updateResult.rowCount} evidence(s) to "${status}"`,
    }).catch(err => console.error("Background task error:", err));

    return NextResponse.json({ 
      message: `Successfully updated ${updateResult.rowCount} evidences to ${status}` 
    });
  } catch (error: any) {
    console.error("Bulk update error:", error);
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
