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
    const result = await query(
      `SELECT u.id, u.name, u.email, u.role, COUNT(e.user_email)::int AS points
       FROM users u
       LEFT JOIN evidence e ON u.email = e.user_email
       GROUP BY u.id, u.name, u.email, u.role
       ORDER BY points DESC`
    );

    return NextResponse.json(result.rows || []);
  } catch (error: any) {
    console.error("GET /admin/leaderboard error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
