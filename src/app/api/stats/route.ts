// app/api/statistics/route.ts
import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import redis from "@/app/lib/redis";

const REDIS_KEY = "statistics_cache";
const CACHE_TTL = 43200; // dalam detik, ganti sesuai kebutuhan

export async function GET(req: NextRequest) {
  try {
    // cek cache di Redis dulu
    const cachedStats = await redis.get(REDIS_KEY);
    if (cachedStats) {
      return NextResponse.json(
        {
          success: true,
          message: "Statistik berhasil diambil (dari cache)",
          stats: JSON.parse(cachedStats),
        },
        { status: 200 }
      );
    }

    // ambil data dari Supabase RPC
    const { data, error } = await supabase.rpc("get_statistics");

    if (error) {
      console.error("Error fetching stats via RPC:", error.message);
      return NextResponse.json(
        { success: false, error: "Gagal mengambil statistik" },
        { status: 500 }
      );
    }

    // simpan data ke Redis sebelum return
    await redis.setex(REDIS_KEY, CACHE_TTL, JSON.stringify(data));

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
