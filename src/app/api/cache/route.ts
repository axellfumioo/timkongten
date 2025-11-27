import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/lib/authOptions";
import { cacheHelper } from "@/lib/redis";
import redis from "@/lib/redis";

// GET: Check Redis status dan info
export async function GET(req: NextRequest) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const info = await redis.info('stats');
    const dbSize = await redis.dbsize();
    const ping = await redis.ping();

    return NextResponse.json({
      success: true,
      status: ping === 'PONG' ? 'connected' : 'disconnected',
      keys: dbSize,
      info: info,
    });
  } catch (error: any) {
    return NextResponse.json({
      success: false,
      error: error.message,
      status: 'error'
    }, { status: 500 });
  }
}

// DELETE: Invalidate cache
export async function DELETE(req: NextRequest) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);
  const pattern = searchParams.get("pattern");
  const key = searchParams.get("key");

  try {
    if (pattern) {
      await cacheHelper.invalidatePattern(pattern);
      return NextResponse.json({
        success: true,
        message: `Cache invalidated for pattern: ${pattern}`,
      });
    } else if (key) {
      await cacheHelper.invalidate(key);
      return NextResponse.json({
        success: true,
        message: `Cache invalidated for key: ${key}`,
      });
    } else {
      // Flush all cache
      await redis.flushdb();
      return NextResponse.json({
        success: true,
        message: "All cache cleared",
      });
    }
  } catch (error: any) {
    return NextResponse.json({
      success: false,
      error: error.message,
    }, { status: 500 });
  }
}
