// app/api/activity-log/route.ts
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { supabase } from "@/app/lib/supabase";
import Redis from "ioredis";
import { authOptions } from "@/app/lib/authOptions";

// Use connection pooling and pipeline for Redis
const redis = new Redis(process.env.REDIS_URL!, {
  maxRetriesPerRequest: 2,
  connectTimeout: 1000,
  commandTimeout: 2000,
  lazyConnect: true,
});

const CACHE_EXPIRE_SECONDS = 900; // 15 minutes
const CACHE_PREFIX = 'al:';
const CACHE_VERSION_KEY = 'al:version';

// Helper function to generate cache key
function generateCacheKey(search: string, type: string, page: number, pageSize: number): string {
  return `${CACHE_PREFIX}${Buffer.from(`${search}:${type}:${page}:${pageSize}`).toString('base64').slice(0, 20)}`;
}

// Helper function to get common cache keys that need updating
function getCommonCacheKeys(): string[] {
  const commonQueries = [
    { search: "", type: "", page: 1, pageSize: 10 },
    { search: "", type: "", page: 1, pageSize: 20 },
    { search: "", type: "login", page: 1, pageSize: 10 },
    { search: "", type: "error", page: 1, pageSize: 10 },
    { search: "", type: "create", page: 1, pageSize: 10 },
    { search: "", type: "update", page: 1, pageSize: 10 },
    { search: "", type: "delete", page: 1, pageSize: 10 },
  ];

  return commonQueries.map(q => generateCacheKey(q.search, q.type, q.page, q.pageSize));
}

// Helper function to fetch and cache data
async function fetchAndCache(search: string, type: string, page: number, pageSize: number) {
  const offset = (page - 1) * pageSize;
  
  let query = supabase
    .from("activity_logs")
    .select(
      "user_email,user_name,activity_type,activity_name,activity_message,activity_date",
      { count: "exact" }
    )
    .order("activity_date", { ascending: false });

  if (search) {
    const safeSearch = search.replace(/[%_\\]/g, '\\$&').substring(0, 50);
    query = query.or(
      `user_name.ilike.%${safeSearch}%,activity_name.ilike.%${safeSearch}%,activity_message.ilike.%${safeSearch}%`
    );
  }

  if (type) {
    query = query.eq("activity_type", type);
  }

  query = query.range(offset, offset + pageSize - 1);

  const { data, error, count } = await query;

  if (error) {
    throw error;
  }

  return {
    success: true,
    data,
    pagination: {
      page,
      pageSize,
      total: count,
      totalPages: Math.ceil((count ?? 0) / pageSize),
    },
  };
}

// Background cache update function
async function updateCacheInBackground(activityType: string) {
  try {
    const commonKeys = getCommonCacheKeys();
    const pipeline = redis.pipeline();
    
    // Get current cache version
    const currentVersion = await redis.get(CACHE_VERSION_KEY) || '0';
    const newVersion = (parseInt(currentVersion) + 1).toString();
    
    // Update cache version first
    pipeline.set(CACHE_VERSION_KEY, newVersion, 'EX', CACHE_EXPIRE_SECONDS);

    // Update common cache patterns in parallel
    const updatePromises = [
      // Update general queries (most common)
      fetchAndCache("", "", 1, 10),
      fetchAndCache("", "", 1, 20),
      // Update type-specific queries
      fetchAndCache("", activityType, 1, 10),
      // Update other common types
      ...(activityType !== "login" ? [fetchAndCache("", "login", 1, 10)] : []),
      ...(activityType !== "error" ? [fetchAndCache("", "error", 1, 10)] : []),
    ];

    const results = await Promise.allSettled(updatePromises);
    
    // Cache the successful results
    results.forEach((result, index) => {
      if (result.status === 'fulfilled') {
        let cacheKey: string;
        switch (index) {
          case 0: cacheKey = generateCacheKey("", "", 1, 10); break;
          case 1: cacheKey = generateCacheKey("", "", 1, 20); break;
          case 2: cacheKey = generateCacheKey("", activityType, 1, 10); break;
          case 3: cacheKey = generateCacheKey("", "login", 1, 10); break;
          case 4: cacheKey = generateCacheKey("", "error", 1, 10); break;
          default: return;
        }
        
        pipeline.set(
          cacheKey, 
          JSON.stringify(result.value), 
          'EX', 
          CACHE_EXPIRE_SECONDS
        );
      }
    });

    await pipeline.exec();
    console.log(`Cache updated for activity type: ${activityType}, new version: ${newVersion}`);
  } catch (error) {
    console.warn('Background cache update failed:', error);
  }
}

// POST - Insert activity log with smart cache updating
export async function POST(req: NextRequest) {
  if (req.headers.get("x-api-key") !== process.env.INTERNAL_API_KEY) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const {
    user_email,
    user_name,
    activity_type,
    activity_name,
    activity_message,
    activity_method,
    activity_url,
    activity_agent,
  } = body;

  const timestamp = new Date().toISOString();

  try {
    // Insert the new activity log
    const { data, error } = await supabase.from("activity_logs").insert([
      {
        user_email,
        user_name,
        activity_type,
        activity_name,
        activity_message,
        activity_url,
        activity_agent,
        activity_method,
        activity_date: timestamp,
      },
    ]);

    if (error) {
      console.error("Supabase insert error:", error);
      return NextResponse.json(
        { success: false, error: error.message },
        { status: 500 }
      );
    }

    // Update cache in background (non-blocking)
    setImmediate(() => {
      updateCacheInBackground(activity_type);
    });

    return NextResponse.json({ success: true, data }, { status: 201 });
  } catch (err) {
    console.error("Unexpected error:", err);
    return NextResponse.json(
      { success: false, error: "Failed to log activity." },
      { status: 500 }
    );
  }
}

// GET - Optimized fetch with smart cache checking
export async function GET(req: NextRequest) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);

  const search = searchParams.get("search") || "";
  const type = searchParams.get("type") || "";
  const page = parseInt(searchParams.get("page") || "1");
  const pageSize = Math.min(parseInt(searchParams.get("pageSize") || "10"), 100);

  const cacheKey = generateCacheKey(search, type, page, pageSize);
  const cacheVersionKey = `${cacheKey}:version`;

  try {
    // Check cache and version in parallel
    const [cached, cacheVersion, currentVersion] = await Promise.all([
      redis.get(cacheKey),
      redis.get(cacheVersionKey),
      redis.get(CACHE_VERSION_KEY)
    ]);

    // Serve from cache if available and current version matches
    if (cached && cacheVersion === currentVersion) {
      return NextResponse.json(JSON.parse(cached), { 
        status: 200,
        headers: {
          'Cache-Control': 'public, max-age=60',
          'X-Cache': 'HIT',
          'X-Cache-Version': cacheVersion || '0'
        }
      });
    }

    // Cache miss or version mismatch - fetch fresh data
    const response = await fetchAndCache(search, type, page, pageSize);

    // Cache the response with current version
    const pipeline = redis.pipeline();
    pipeline.set(cacheKey, JSON.stringify(response), "EX", CACHE_EXPIRE_SECONDS);
    pipeline.set(cacheVersionKey, currentVersion || '0', "EX", CACHE_EXPIRE_SECONDS);
    
    // Non-blocking cache write
    pipeline.exec().catch(err => console.warn('Cache write failed:', err));

    return NextResponse.json(response, { 
      status: 200,
      headers: {
        'Cache-Control': 'public, max-age=60',
        'X-Cache': 'MISS',
        'X-Cache-Version': currentVersion || '0'
      }
    });
  } catch (err) {
    console.error("Unexpected error:", err);
    return NextResponse.json(
      { success: false, error: "Failed to fetch activity logs." },
      { status: 500 }
    );
  }
}

// PUT - Force cache refresh for specific queries
export async function PUT(req: NextRequest) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const { search = "", type = "", page = 1, pageSize = 10 } = body;

  try {
    // Fetch fresh data
    const response = await fetchAndCache(search, type, page, pageSize);
    
    // Update cache immediately
    const cacheKey = generateCacheKey(search, type, page, pageSize);
    const cacheVersionKey = `${cacheKey}:version`;
    const currentVersion = await redis.get(CACHE_VERSION_KEY) || '0';
    
    const pipeline = redis.pipeline();
    pipeline.set(cacheKey, JSON.stringify(response), "EX", CACHE_EXPIRE_SECONDS);
    pipeline.set(cacheVersionKey, currentVersion, "EX", CACHE_EXPIRE_SECONDS);
    await pipeline.exec();

    return NextResponse.json({
      success: true,
      message: "Cache refreshed",
      version: currentVersion,
      data: response
    });
  } catch (err) {
    console.error("Cache refresh error:", err);
    return NextResponse.json(
      { success: false, error: "Failed to refresh cache." },
      { status: 500 }
    );
  }
}

// PATCH - Warmup cache and show cache statistics
export async function PATCH(req: NextRequest) {
  try {
    // Get cache statistics
    const cacheKeys = await redis.keys(`${CACHE_PREFIX}*`);
    const currentVersion = await redis.get(CACHE_VERSION_KEY) || '0';
    
    // Warmup common queries
    const warmupResults = await Promise.allSettled([
      fetchAndCache("", "", 1, 10),
      fetchAndCache("", "", 1, 20),
      fetchAndCache("", "login", 1, 10),
      fetchAndCache("", "error", 1, 10),
      fetchAndCache("", "create", 1, 10),
    ]);

    // Update cache with warmed data
    const pipeline = redis.pipeline();
    const commonKeys = [
      generateCacheKey("", "", 1, 10),
      generateCacheKey("", "", 1, 20),
      generateCacheKey("", "login", 1, 10),
      generateCacheKey("", "error", 1, 10),
      generateCacheKey("", "create", 1, 10),
    ];

    warmupResults.forEach((result, index) => {
      if (result.status === 'fulfilled') {
        const cacheKey = commonKeys[index];
        const versionKey = `${cacheKey}:version`;
        pipeline.set(cacheKey, JSON.stringify(result.value), "EX", CACHE_EXPIRE_SECONDS);
        pipeline.set(versionKey, currentVersion, "EX", CACHE_EXPIRE_SECONDS);
      }
    });

    await pipeline.exec();

    return NextResponse.json({ 
      success: true,
      warmed: warmupResults.filter(r => r.status === 'fulfilled').length,
      total: warmupResults.length,
      currentVersion,
      totalCacheKeys: cacheKeys.length,
      message: "Cache warmed up successfully"
    });
  } catch (err) {
    console.error("Warmup error:", err);
    return NextResponse.json(
      { success: false, error: "Failed to warmup cache." },
      { status: 500 }
    );
  }
}