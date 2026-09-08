import { Pool, type PoolConfig } from "pg";

declare global {
  var bodySimulatorPool: Pool | undefined;
}

function databaseUrl(): string {
  if (process.env.DATABASE_URL) {
    return process.env.DATABASE_URL;
  }

  const required = [
    "SUPABASE_DB_HOST",
    "SUPABASE_DB_PORT",
    "SUPABASE_DB_NAME",
    "SUPABASE_DB_USERNAME",
    "SUPABASE_DB_PASSWORD",
  ] as const;
  const missing = required.filter((name) => !process.env[name]);
  if (missing.length > 0) {
    throw new Error(`Database configuration is missing: ${missing.join(", ")}`);
  }

  const username = encodeURIComponent(process.env.SUPABASE_DB_USERNAME!);
  const password = encodeURIComponent(process.env.SUPABASE_DB_PASSWORD!);
  return `postgresql://${username}:${password}@${process.env.SUPABASE_DB_HOST}:${process.env.SUPABASE_DB_PORT}/${process.env.SUPABASE_DB_NAME}`;
}

function createPool(): Pool {
  const sslMode = process.env.SUPABASE_DB_SSLMODE ?? "require";
  const defaultPoolSize = process.env.VERCEL ? 1 : 5;
  const config: PoolConfig = {
    connectionString: databaseUrl(),
    // A Vercel function can be replicated across many warm instances. Keep
    // one backend connection per instance by default; override only when the
    // database plan and expected concurrency justify a larger pool.
    max: Number(process.env.DB_POOL_MAX ?? defaultPoolSize),
    idleTimeoutMillis: 30_000,
    connectionTimeoutMillis: 10_000,
    ssl: sslMode === "disable" ? false : { rejectUnauthorized: false },
  };
  return new Pool(config);
}

/**
 * Creates the connection pool lazily. Next.js evaluates route modules while it
 * builds the application, when deployment secrets are intentionally absent.
 */
export function getDatabase(): Pool {
  if (!global.bodySimulatorPool) {
    global.bodySimulatorPool = createPool();
  }
  return global.bodySimulatorPool;
}
