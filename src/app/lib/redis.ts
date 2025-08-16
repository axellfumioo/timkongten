import Redis from "ioredis";

let redis: Redis;

// Singleton Redis biar gak reconnect tiap request
if (!(global as any)._redis) {
  (global as any)._redis = new Redis(process.env.REDIS_URL!, {
    maxRetriesPerRequest: 3,
    enableReadyCheck: true,
    connectTimeout: 10000,
    tls: process.env.REDIS_URL?.startsWith("rediss://")
      ? { rejectUnauthorized: true }
      : undefined,
  });
}

redis = (global as any)._redis;
export default redis;
