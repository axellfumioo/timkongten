# Redis Caching Implementation

Redis caching telah diimplementasikan untuk meningkatkan performa aplikasi.

## Configuration

Environment variable yang diperlukan di `.env`:
```
REDIS_URL_PRIMARY="redis://:password@host:port"
```

## Endpoints yang Menggunakan Cache

### GET Endpoints (dengan cache)
1. **GET /api/content** - Cache: 5 menit
   - Cache key: `content:{date}:{limit}`
   
2. **GET /api/evidences** - Cache: 5 menit
   - Cache key: `evidence:{user}:{month}`
   
3. **GET /api/stats** - Cache: 10 menit
   - Cache key: `stats`

### Write Operations (dengan cache invalidation)
Semua operasi POST, PUT, DELETE, PATCH akan secara otomatis menginvalidate cache yang relevan:
- **POST/PUT/DELETE /api/content** → Invalidates `content:*`, `evidence:*`, `stats`
- **POST/PUT/DELETE/PATCH /api/evidences** → Invalidates `evidence:*`, `stats`

## Cache Management Endpoint

**GET /api/cache**
- Check Redis connection status
- Get database size and statistics
- Requires authentication

**DELETE /api/cache**
- Invalidate specific cache key: `/api/cache?key=stats`
- Invalidate by pattern: `/api/cache?pattern=content:*`
- Clear all cache: `/api/cache`
- Requires authentication

## Cache Helper Usage

```typescript
import { cacheHelper } from '@/lib/redis';

// Get or Set dengan auto-caching
const data = await cacheHelper.getOrSet(
  'my-cache-key',
  async () => {
    // Fetch data dari database
    return await fetchFromDB();
  },
  300 // TTL in seconds (5 minutes)
);

// Manual cache operations
await cacheHelper.set('key', data, 600);
const cached = await cacheHelper.get('key');

// Invalidation
await cacheHelper.invalidate('key');
await cacheHelper.invalidatePattern('content:*');
```

## Performance Benefits

- **Reduced database queries**: Data yang sering diakses di-cache di Redis
- **Faster response times**: Cache hit langsung return data tanpa query database
- **Auto-invalidation**: Cache otomatis di-clear saat data berubah
- **Fallback mechanism**: Jika Redis error, aplikasi tetap berjalan dengan fetch langsung ke database

## Monitoring

Check Redis connection dan stats:
```bash
curl http://localhost:3000/api/cache
```

Clear specific cache:
```bash
curl -X DELETE http://localhost:3000/api/cache?pattern=content:*
```

Clear all cache:
```bash
curl -X DELETE http://localhost:3000/api/cache
```
