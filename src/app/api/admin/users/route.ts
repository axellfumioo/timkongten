export const dynamic = 'force-dynamic';

import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/lib/authOptions";
import { query } from "@/app/lib/postgres";
import { randomUUID } from "crypto";
import { cacheHelper } from "@/lib/redis";

export async function GET(req: Request) {
  const session = await getServerSession(authOptions);
  const userauth = session?.user;

  if (!userauth?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const cacheKey = "admin:users:list";
    const data = await cacheHelper.getOrSet(
      cacheKey,
      async () => {
        const result = await query(
          "SELECT id, email, name, role FROM users ORDER BY id ASC"
        );
        return result.rows || [];
      },
      300
    );

    return NextResponse.json(data);
  } catch (error: any) {
    console.error("GET /admin/users error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}

export async function POST(req: Request) {
  const session = await getServerSession(authOptions);
  const userauth = session?.user;

  if (!userauth?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const body = await req.json();
    const { email, name, role } = body;
    
    if (!email || !name || !role) {
      return NextResponse.json({ error: "Bad Request" }, { status: 400 });
    }

    const id = randomUUID();
    const result = await query(
      "INSERT INTO users (id, email, name, role) VALUES ($1, $2, $3, $4) RETURNING *",
      [id, email, name, role]
    );

    await cacheHelper.invalidatePattern("admin:users:*");

    return NextResponse.json(result.rows[0], { status: 201 });
  } catch (error: any) {
    console.error("POST /admin/users error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
