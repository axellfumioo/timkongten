import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { cacheHelper } from "@/lib/redis";

export async function GET(req: NextRequest) {
  try {
    // Gunakan cache untuk statistics (cache lebih lama karena jarang berubah)
    const stats = await cacheHelper.getOrSet(
      'stats',
      async () => {
        const { data, error } = await supabase.rpc("get_statistics");

        if (error) {
          console.error("Error fetching stats via RPC:", error.message);
          throw new Error("Gagal mengambil statistik");
        }

        return data;
      },
      600 // Cache 10 menit
    );

    return NextResponse.json(
      {
        success: true,
        message: "Statistik berhasil diambil",
        stats,
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
