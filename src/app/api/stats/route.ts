export const dynamic = 'force-dynamic';

import { NextRequest, NextResponse } from "next/server";
import { cacheHelper } from "@/lib/redis";
import { query } from "@/app/lib/postgres";

export async function GET(req: NextRequest) {
  try {
    // Gunakan cache untuk statistics (cache lebih lama karena jarang berubah)
    const stats = await cacheHelper.getOrSet(
      'stats',
      async () => {
        const evidenceResult = await query("SELECT count(*) FROM evidence");
        const contentResult = await query("SELECT count(*) FROM content");

        return {
          total_evidences: parseInt(evidenceResult.rows[0].count, 10),
          total_contents: parseInt(contentResult.rows[0].count, 10)
        };
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
