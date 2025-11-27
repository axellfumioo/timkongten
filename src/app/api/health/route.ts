import { NextRequest, NextResponse } from "next/server";
import { supabase } from "@/app/lib/supabase";

export async function GET(req: NextRequest) {
  try {
    const randomNumber = Math.floor(Math.random() * (1000000000 - 99 + 1)) + 99;
    const { data, error } = await supabase.from("request").insert([
      {
        id: randomNumber,
      },
    ]);

    if (error) {
      return NextResponse.json(
        {
          success: false,
          error: "API tidak berjalan dengan normal",
          message: error,
        },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: "API runing normally. All function is working!",
    });
  } catch (error: any) {
    return NextResponse.json(
      {
        success: false,
        error: "API tidak berjalan dengan normal",
        message: error,
      },
      { status: 500 }
    );
  }
}
