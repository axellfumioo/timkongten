// app/api/statistics/route.ts
import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
  try {
    // Panggil function RPC
    const { data, error } = await supabase.rpc("get_statistics");

    if (error) {
      console.error("Error fetching stats via RPC:", error.message);
      return NextResponse.json(
        { success: false, error: "Gagal mengambil statistik" },
        { status: 500 }
      );
    }

    return NextResponse.json(
      {
        success: true,
        message: "Statistik berhasil diambil",
        stats: data,
      },
      { status: 200 }
    );
  } catch (error: any) {
    console.error("Unexpected error:", error);
    return NextResponse.json(
      {
        success: false,
        error: "Terjadi kesalahan saat mengambil statistik",
      },
      { status: 500 }
    );
  }
}
