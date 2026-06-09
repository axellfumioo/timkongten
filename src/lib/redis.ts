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
    return new Promise((resolve) => {
      let count = 0;
      const stream = redis.scanStream({
        match: pattern,
        count: 100
      });

      stream.on('data', (keys: string[]) => {
        if (keys.length > 0) {
          count += keys.length;
          stream.pause();
          redis.del(...keys).then(() => {
            stream.resume();
          }).catch(err => {
            console.error('Error deleting keys during scan:', err);
            stream.resume();
          });
        }
      });

      stream.on('end', () => {
        if (count > 0) {
          console.log(`Cache invalidated (${count} keys): ${pattern}`);
        }
        resolve();
      });

      stream.on('error', (error) => {
        console.error('Cache pattern invalidation error:', error);
        resolve();
      });
    });
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
   * Fast invalidation for evidences without SCAN
   */
  async invalidateEvidences(user_email: string): Promise<void> {
    try {
      const months = Array.from({ length: 12 }, (_, i) => String(i + 1).padStart(2, '0'));
      const userKeys = months.map(m => `evidence:${user_email}:${m}`);
      const allKeys = months.map(m => `evidence:all:${m}`);
      
      const keysToDelete = [
        ...userKeys,
        ...allKeys,
        'stats',
        `stats:${user_email}`,
        'admin:evidences:pending',
      ];
      
      await redis.del(...keysToDelete);
      console.log(`Fast cache invalidated for user ${user_email} and global stats`);
    } catch (err) {
      console.error('Fast cache invalidation error:', err);
    }
  },
};
