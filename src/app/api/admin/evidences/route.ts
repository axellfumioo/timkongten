export const dynamic = 'force-dynamic';

import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/lib/authOptions";
import { query } from "@/app/lib/postgres";

export async function GET(req: Request) {
  const session = await getServerSession(authOptions);
  const userauth = session?.user;

  if (!userauth?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const sql = `
      SELECT 
        e.*, 
        TO_CHAR(e.evidence_date, 'YYYY-MM-DD') AS formatted_date,
        json_build_object(
          'email', u.email,
          'name', u.name,
          'role', u.role
        ) as users
      FROM evidence e
      LEFT JOIN users u ON e.user_email = u.email
      WHERE e.evidence_status = 'pending'
      ORDER BY e.evidence_date DESC, e.created_at DESC
    `;
    
    const result = await query(sql);
    
    const rows = (result.rows || []).map((row: any) => {
      row.evidence_date = row.formatted_date;
      delete row.formatted_date;
      return row;
    });

    return NextResponse.json(rows);
  } catch (error: any) {
    console.error("GET /admin/evidences error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
