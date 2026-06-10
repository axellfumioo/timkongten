import { Pool, PoolClient, QueryResultRow } from "pg";

type PoolConfig = {
  connectionString: string | undefined;
  ssl?: { rejectUnauthorized: boolean } | boolean;
  max?: number;
  idleTimeoutMillis?: number;
};

const rawConnectionString = process.env.DATABASE_URL;
const shouldUseSsl =
  process.env.DATABASE_SSL === "true" ||
  (rawConnectionString?.includes("sslmode=require") ?? false);

const connectionString = rawConnectionString
  ? rawConnectionString
      .replace(/([?&])sslmode=[^&]+/i, "$1")
      .replace(/[?&]$/, "")
  : rawConnectionString;

const poolConfig: PoolConfig = {
  connectionString,
  ssl: shouldUseSsl ? { rejectUnauthorized: false } : false,
  max: parseInt(process.env.DATABASE_POOL_MAX || (process.env.NODE_ENV === "production" ? "10" : "2"), 10),
  idleTimeoutMillis: parseInt(process.env.DATABASE_IDLE_TIMEOUT_MS || "30000", 10),
  allowExitOnIdle: process.env.NODE_ENV !== "production",
};

const globalForPg = globalThis as unknown as { pgPool?: Pool };

export const pgPool = globalForPg.pgPool ?? new Pool(poolConfig);

globalForPg.pgPool = pgPool;

export async function query<T extends QueryResultRow = any>(text: string, params: any[] = []) {
  return pgPool.query<T>(text, params);
}

export async function withTransaction<T>(fn: (client: PoolClient) => Promise<T>) {
  const client = await pgPool.connect();
  try {
    await client.query("BEGIN");
    const result = await fn(client);
    await client.query("COMMIT");
    return result;
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
}
