import { NextResponse } from "next/server";
import { supabase } from "@/app/lib/supabase";

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

    const { data, error } = await supabase
      .from("users")
      .insert([newUser]);

    if (error) {
      if (error.code === "23505") {
        return NextResponse.json(
          {
            message: "Email already exists",
            error: error.details,
          },
          { status: 409 }
        );
      }

      return NextResponse.json(
        { message: "Failed to create user", error },
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
