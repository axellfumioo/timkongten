import { NextResponse } from "next/server";
import { query } from "@/app/lib/postgres";

export async function DELETE(req: Request) {
  try {
    const raw = await req.text();
    const body = JSON.parse(raw);

    if (!body.email) {
      return NextResponse.json(
        { message: "Email is required" },
        { status: 400 }
      );
    }

    const result = await query(
      "DELETE FROM users WHERE email = $1 RETURNING *",
      [body.email]
    );

    if (result.rowCount === 0) {
      return NextResponse.json(
        { message: "User not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      { message: "User deleted successfully", data: result.rows },
      { status: 200 }
    );
  } catch (err: any) {
    return NextResponse.json(
      { message: "Invalid JSON", error: err.message },
      { status: 400 }
    );
  }
}
