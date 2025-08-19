import Redis from "ioredis";

declare global {
  // Prevent multiple Redis instances in dev (Next.js hot reload problem)
  // eslint-disable-next-line no-var
  var redis: Redis | undefined;
}

let redis: Redis;

if (!global.redis) {
  const primaryUrl = process.env.REDIS_URL_PRIMARY || "redis://localhost:6379";
  const secondaryUrl =
    process.env.REDIS_URL_SECONDARY || "redis://localhost:6380";

  // Try primary first
  const client = new Redis(primaryUrl, {
    maxRetriesPerRequest: null,
    enableReadyCheck: false,
  });

  // Attach error & failover handling
  client.on("error", (err) => {
    console.error("[Redis] Primary connection error:", err.message);
  });

  client.on("end", () => {
    console.warn("[Redis] Primary disconnected. Switching to secondary...");

    if (!global.redis || global.redis.options.host === client.options.host) {
      const fallback = new Redis(secondaryUrl, {
        maxRetriesPerRequest: null,
        enableReadyCheck: false,
      });

      fallback.on("error", (err) => {
        console.error("[Redis] Secondary connection error:", err.message);
      });

      global.redis = fallback;
    }
  });

  global.redis = client;
}

redis = global.redis;

export default redis;
