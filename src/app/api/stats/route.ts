export const dynamic = 'force-dynamic';

import { NextRequest, NextResponse } from "next/server";
import { cacheHelper } from "@/lib/redis";
import { query } from "@/app/lib/postgres";

export async function GET(req: NextRequest) {
  try {
    const url = new URL(req.url);
    const email = url.searchParams.get("email");

    // Gunakan cache untuk statistics (cache lebih lama karena jarang berubah)
    const stats = await cacheHelper.getOrSet(
      'stats',
      async () => {
        const [evidenceResult, contentResult] = await Promise.all([
          query("SELECT count(*) FROM evidence"),
          query("SELECT count(*) FROM content")
        ]);

        return {
          total_evidences: parseInt(evidenceResult.rows[0].count, 10),
          total_contents: parseInt(contentResult.rows[0].count, 10)
        };
      },
      600 // Cache 10 menit
    );

    let user_evidences = 0;
    if (email) {
      const userStats = await cacheHelper.getOrSet(
        `stats:user:${email}`,
        async () => {
          const userEvidenceResult = await query("SELECT count(*) FROM evidence WHERE user_email = $1", [email]);
          return {
            total_evidences: parseInt(userEvidenceResult.rows[0].count, 10)
          };
        },
        600
      );
      user_evidences = userStats.total_evidences;
    }

    return NextResponse.json(
      {
        success: true,
        message: "Statistik berhasil diambil",
        stats: {
          ...stats,
          user_evidences
        },
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
