import Redis from "ioredis";

declare global {
  // Prevent multiple Redis instances in dev (Next.js hot reload problem)
  // eslint-disable-next-line no-var
  var redis: Redis | undefined;
}

let redis: Redis;

if (!global.redis) {
  const primaryUrl = process.env.REDIS_URL_PRIMARY || "redis://localhost:6379";
  
  const client = new Redis(primaryUrl, {
    // Essential optimizations
    connectTimeout: 5000,
    commandTimeout: 2000,
    lazyConnect: false,
    maxRetriesPerRequest: 3,
    enableReadyCheck: true,
    family: 4, // Force IPv4
    enableOfflineQueue: false,
  });

  client.on("error", (err) => {
    console.error("[Redis] Connection error:", err.message);
  });

  client.on("connect", () => {
    console.log("[Redis] Connected");
  });

  // Test connection
  client.ping().catch((err) => {
    console.error("[Redis] Ping failed:", err.message);
  });

  global.redis = client;
}

redis = global.redis;

// Simple helper for timing operations
export async function timedRedisOperation<T>(
  operation: () => Promise<T>,
  operationName: string
): Promise<T> {
  const start = Date.now();
  try {
    const result = await operation();
    const duration = Date.now() - start;
    if (duration > 100) {
      console.warn(`[Redis] ${operationName} took ${duration}ms`);
    }
    return result;
  } catch (error) {
    const duration = Date.now() - start;
    console.error(`[Redis] ${operationName} failed after ${duration}ms:`, error);
    throw error;
  }
}

export default redis;