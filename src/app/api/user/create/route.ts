import { NextResponse } from "next/server";
import { query } from "@/app/lib/postgres";

export async function POST(req: Request) {
  try {
    const raw = await req.text();
    const body = JSON.parse(raw);

    if (!body.name || !body.email) {
      return NextResponse.json(
        { error: "Name & Email is required" },
        { status: 400 }
      );
    }

    const newUser = {
      name: body.name,
      email: body.email,
      role: body.role,
    };

    let data;
    try {
      const result = await query(
        "INSERT INTO users (name, email, role) VALUES ($1,$2,$3) RETURNING *",
        [newUser.name, newUser.email, newUser.role]
      );
      data = result.rows;
    } catch (error: any) {
      if (error?.code === "23505") {
        return NextResponse.json(
          {
            message: "Email already exists",
            error: error.detail,
          },
          { status: 409 }
        );
      }

      return NextResponse.json(
        { message: "Failed to create user", error: error?.message || error },
        { status: 500 }
      );
    }

    return NextResponse.json(
      { message: "User created", data },
      { status: 201 }
    );
  } catch (err: any) {
    console.error("❌ JSON PARSE ERROR:", err);
    return NextResponse.json(
      { message: "Invalid JSON", error: err.message },
      { status: 400 }
    );
  }
}
