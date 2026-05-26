import { NextRequest, NextResponse } from "next/server";
import { query } from "@/app/lib/postgres";

export async function GET(req: NextRequest) {
  try {
    const randomNumber = Math.floor(Math.random() * (1000000000 - 99 + 1)) + 99;
    const result = await query("INSERT INTO request (id) VALUES ($1)", [
      randomNumber,
    ]);

    if (result.rowCount === 0) {
      return NextResponse.json(
        {
          success: false,
          error: "API tidak berjalan dengan normal",
          message: "Health check insert failed",
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
