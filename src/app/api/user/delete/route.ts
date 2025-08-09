import { NextResponse } from "next/server";
import { supabase } from "@/app/lib/supabase";

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

    const { data, error } = await supabase
      .from("users")
      .delete()
      .eq("email", body.email)
      .select();

    if (error) {
      return NextResponse.json(
        { message: "Failed to delete user", error },
        { status: 500 }
      );
    }

    if (!data || data.length === 0) {
      return NextResponse.json(
        { message: "User not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      { message: "User deleted successfully", data },
      { status: 200 }
    );
  } catch (err: any) {
    return NextResponse.json(
      { message: "Invalid JSON", error: err.message },
      { status: 400 }
    );
  }
}
