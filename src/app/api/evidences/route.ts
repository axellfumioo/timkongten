export const dynamic = 'force-dynamic';

import { NextResponse } from "next/server";
import { uploadToB2 } from "@/app/lib/uploadToB2";
import { randomUUID } from "crypto";
import { getServerSession } from "next-auth";
import { logActivity } from "@/app/lib/logActivity";
import { authOptions } from "@/app/lib/authOptions";
import { cacheHelper } from "@/lib/redis";
import { query } from "@/app/lib/postgres";

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

  // ===== DB Query =====
  const monthStart = `${new Date().getFullYear()}-${evidenceMonth}-01`;
  const monthEndDate = new Date(
    new Date(monthStart).getFullYear(),
    new Date(monthStart).getMonth() + 1,
    0
  ).getDate();
  const monthEnd = `${new Date().getFullYear()}-${evidenceMonth}-${monthEndDate}`;

  // Cache key berdasarkan user dan month
  const cacheKey = `evidence:${user || 'all'}:${evidenceMonth}`;

  try {
    const dbStart = Date.now();
    const data = await cacheHelper.getOrSet(
      cacheKey,
      async () => {
        let sql = "SELECT *, TO_CHAR(evidence_date, 'YYYY-MM-DD') AS formatted_date FROM evidence WHERE evidence_date >= $2 AND evidence_date <= $3";
        const params: any[] = [user ?? null, monthStart, monthEnd];
        if (user) {
            sql += " AND user_email = $1";
        } else {
            sql += " AND ($1::text IS NULL)";
        }
        sql += " ORDER BY created_at DESC";
        const result = await query(sql, params);

        const rows = (result.rows || []).map((row: any) => {
          row.evidence_date = row.formatted_date;
          delete row.formatted_date;
          return row;
        });

        return rows;
      },
      300 // Cache 5 menit
    );

    const dbTime = Date.now() - dbStart;

    const acceptedEvidences = data.filter(
      (item: any) => item.evidence_status === "accepted"
    ).length;

    const profiling = {
      database: `${dbTime}ms`,
      total: `${Date.now() - totalStart}ms`,
    };

    console.log("[GET /evidences]", profiling);

    return NextResponse.json(
      { data, acceptedEvidences, profiling },
      {
        status: 200,
        headers: {
          "X-DB-Query": `${dbTime}ms`,
          "X-Total-Time": `${Date.now() - totalStart}ms`,
        },
      }
    );
  } catch (error: any) {
    console.error("GET /evidences error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
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
    const completion_proof = formData.get("completion_proof") as string | null;

    const fileUrl = completion_proof && completion_proof.trim() !== "" ? completion_proof : null;

    const contentIdValue =
      content_id && content_id !== "null" ? content_id : null;

    const insertStart = Date.now();
    const insertResult = await query(
        "INSERT INTO evidence (user_email, evidence_title, evidence_description, evidence_date, evidence_job, content_id, completion_proof, evidence_status) VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING id",
        [
          user_email,
          evidence_title,
          evidence_description,
          evidence_date,
          evidence_job,
          contentIdValue,
          fileUrl,
          "pending",
        ]
    );
    const insertTime = Date.now() - insertStart;

    if (insertResult.rowCount === 0) {
      return NextResponse.json({ error: "Insert gagal" }, { status: 500 });
    }

    // Invalidate cache immediately to prevent stale GET requests
    await cacheHelper.invalidateEvidences(user_email);

    logActivity({
      user_name: user.name,
      user_email,
      activity_type: "evidence",
      activity_name: "Evidence Created",
      activity_message: `${user.name} created evidence "${evidence_title}"`,
    }).catch(err => console.error("Background task error:", err));

    const profiling = {
      insert_db: `${insertTime}ms`,
      total: `${Date.now() - totalStart}ms`,
    };

    console.log("[POST /evidences]", profiling);

    return NextResponse.json(
      { message: "Evidence created successfully", url: fileUrl, profiling },
      {
        status: 201,
        headers: {
          "X-DB-Insert": `${insertTime}ms`,
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
