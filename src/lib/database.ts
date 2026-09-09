import { getCloudflareContext } from "@opennextjs/cloudflare";
import { Client, Pool, type PoolConfig } from "pg";

declare global {
  var bodySimulatorPool: Pool | undefined;
}

export type Database = Pick<Pool, "query">;
type HyperdriveBinding = { connectionString: string };

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

function hyperdriveConnectionString(): string | undefined {
  try {
    const { env } = getCloudflareContext();
    return (env as unknown as { HYPERDRIVE?: HyperdriveBinding }).HYPERDRIVE?.connectionString;
  } catch {
    // The OpenNext binding context only exists when code runs in a Worker.
    return undefined;
  }
}

/**
 * Creates the connection pool lazily. Next.js evaluates route modules while it
 * builds the application, when deployment secrets are intentionally absent.
 */
function getNodeDatabase(): Pool {
  if (!global.bodySimulatorPool) {
    global.bodySimulatorPool = createPool();
  }
  return global.bodySimulatorPool;
}

/**
 * Runs a query callback using the platform-appropriate Postgres connection.
 *
 * On Cloudflare Workers a client is created for each request with Hyperdrive's
 * binding. Hyperdrive owns the real connection pool, so the short-lived
 * client is intentional. Local development, Dokploy, and Vercel retain their
 * shared Node.js pool.
 */
export async function withDatabase<T>(
  operation: (database: Database) => Promise<T>,
): Promise<T> {
  const connectionString = hyperdriveConnectionString();
  if (!connectionString) {
    return operation(getNodeDatabase());
  }

  const client = new Client({ connectionString });
  await client.connect();
  try {
    return await operation(client);
  } finally {
    await client.end();
  }
}
