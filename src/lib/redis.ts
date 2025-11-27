import Redis from 'ioredis';

// Buat Redis client
const redis = new Redis(process.env.REDIS_URL_PRIMARY!, {
  maxRetriesPerRequest: 3,
  retryStrategy(times) {
    const delay = Math.min(times * 50, 2000);
    return delay;
  },
  enableReadyCheck: true,
  lazyConnect: false,
});

redis.on('error', (err) => {
  console.error('Redis connection error:', err);
});

redis.on('connect', () => {
  console.log('Redis connected successfully');
});

export default redis;

// Helper functions untuk caching
export const cacheHelper = {
  /**
   * Get data dari cache atau fetch dari database
   */
  async getOrSet<T>(
    key: string,
    fetchFn: () => Promise<T>,
    ttl: number = 300 // default 5 menit
  ): Promise<T> {
    try {
      // Cek cache dulu
      const cached = await redis.get(key);
      if (cached) {
        console.log(`Cache HIT: ${key}`);
        return JSON.parse(cached) as T;
      }

      console.log(`Cache MISS: ${key}`);
      // Fetch dari database
      const data = await fetchFn();
      
      // Simpan ke cache
      await redis.setex(key, ttl, JSON.stringify(data));
      
      return data;
    } catch (error) {
      console.error('Cache error:', error);
      // Fallback ke database jika Redis error
      return await fetchFn();
    }
  },

  /**
   * Invalidate cache by key
   */
  async invalidate(key: string): Promise<void> {
    try {
      await redis.del(key);
      console.log(`Cache invalidated: ${key}`);
    } catch (error) {
      console.error('Cache invalidation error:', error);
    }
  },

  /**
   * Invalidate cache by pattern
   */
  async invalidatePattern(pattern: string): Promise<void> {
    try {
      const keys = await redis.keys(pattern);
      if (keys.length > 0) {
        await redis.del(...keys);
        console.log(`Cache invalidated (${keys.length} keys): ${pattern}`);
      }
    } catch (error) {
      console.error('Cache pattern invalidation error:', error);
    }
  },

  /**
   * Set cache dengan TTL
   */
  async set(key: string, data: any, ttl: number = 300): Promise<void> {
    try {
      await redis.setex(key, ttl, JSON.stringify(data));
    } catch (error) {
      console.error('Cache set error:', error);
    }
  },

  /**
   * Get cache
   */
  async get<T>(key: string): Promise<T | null> {
    try {
      const cached = await redis.get(key);
      return cached ? JSON.parse(cached) : null;
    } catch (error) {
      console.error('Cache get error:', error);
      return null;
    }
  },
};
