export const dynamic = 'force-dynamic';

import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/lib/authOptions";
import { query } from "@/app/lib/postgres";
import { cacheHelper } from "@/lib/redis";

export async function PUT(req: Request, { params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
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

    const result = await query(
      "UPDATE users SET email = $1, name = $2, role = $3 WHERE id = $4 RETURNING *",
      [email, name, role, id]
    );

    if (result.rowCount === 0) {
        return NextResponse.json({ error: "Not found" }, { status: 404 });
    }

    await cacheHelper.invalidatePattern("admin:users:*");

    return NextResponse.json(result.rows[0]);
  } catch (error: any) {
    console.error("PUT /admin/users/[id] error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}

export async function DELETE(req: Request, { params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const session = await getServerSession(authOptions);
  const userauth = session?.user;

  if (!userauth?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const result = await query("DELETE FROM users WHERE id = $1", [id]);

    if (result.rowCount === 0) {
        return NextResponse.json({ error: "Not found" }, { status: 404 });
    }

    await cacheHelper.invalidatePattern("admin:users:*");

    return NextResponse.json({ message: "User deleted successfully" });
  } catch (error: any) {
    console.error("DELETE /admin/users/[id] error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
