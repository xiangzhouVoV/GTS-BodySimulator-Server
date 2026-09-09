# GTS-BodySimulator-Server

## 使用 VPS + Dokploy 部署

本分支是 Node.js 22 / Next.js API 服务，容器监听 `8089`，数据库使用现有
Supabase PostgreSQL。因此 VPS 仅运行 Dokploy 和本服务，不要在 Dokploy 中为
此项目额外创建 PostgreSQL 服务或持久卷。

仓库已包含 `Dockerfile` 和 `.dockerignore`，Dokploy 可直接从 Git 仓库构建。

1. 在 VPS 上安装 Dokploy，并在安全组/防火墙放通 `80`、`443` 和 Dokploy
   管理端口；不要将应用的 `8089` 暴露到公网。
2. 在 Dokploy 创建 **Application**，连接此仓库与生产分支；构建类型选择
   **Dockerfile**，Dockerfile 路径为 `Dockerfile`，构建上下文为仓库根目录。
3. 在应用的 Environment 设置中填入下面变量（密码只保存在 Dokploy 的
   Secret/Environment 中，不提交到 Git）：

   ```dotenv
   SUPABASE_DB_HOST=aws-0-us-west-1.pooler.supabase.com
   SUPABASE_DB_PORT=5432
   SUPABASE_DB_NAME=postgres
   SUPABASE_DB_USERNAME=postgres.<your-project-ref>
   SUPABASE_DB_PASSWORD=<database-password>
   SUPABASE_DB_SSLMODE=require
   ```

   也可以改为只设置标准 PostgreSQL 连接串 `DATABASE_URL`。切勿设置
   `SUPABASE_DB_URL` 或 Supabase `service_role` key。
4. 在 Domains 添加 API 域名，容器端口填 `8089`，启用 HTTPS；DNS 的 A/AAAA
   记录先指向 VPS 公网 IP。
5. 在 Health Check 设置 `GET /api/health`、端口 `8089`，成功状态码为
   `200`。该端点会检查数据库连通性。
6. 点击 Deploy。部署成功后验证：

   ```bash
   curl -fsS https://api.example.com/api/health
   curl -fsS https://api.example.com/api/countries
   ```

建议在 Dokploy 为该服务设置至少 `256 MiB` 内存和自动重启；初次部署应确认
Supabase 的网络访问策略允许 VPS 出口 IP 连接数据库。代码推送到已连接分支后，
可在 Dokploy 开启自动部署。

## Next.js API

API 路由位于 `src/app/api`，并保持原有接口契约：

- `GET /api/countries`
- `GET /api/daily-macro-target?weightKg=85&gender=male&trainingLevel=3&country=CN`

服务以 `DATABASE_URL` 为优先连接字符串；若未设置，则由下列 Supabase 环境变量
拼装连接地址：`SUPABASE_DB_HOST`、`SUPABASE_DB_PORT`、`SUPABASE_DB_NAME`、
`SUPABASE_DB_USERNAME`、`SUPABASE_DB_PASSWORD`。`SUPABASE_DB_SSLMODE` 默认为
`require`。本服务只读取公开的营养数据，使用数据库账号即可，不需要 Supabase
`service_role` key。

本地启动：

```bash
npm ci
npm run dev
```

## 部署到 Cloudflare Workers

本项目使用 **OpenNext + Cloudflare Hyperdrive**。Hyperdrive 在 Cloudflare
侧维护 PostgreSQL 连接池，因此 Worker 内不配置 `SUPABASE_DB_*`、
`DATABASE_URL` 或数据库密码。

1. 在 Supabase 的 Connect 页面复制 **Direct connection** URL。不要使用
   Session Pooler（`5432`）或 Transaction Pooler（`6543`）；Hyperdrive 已经
   负责连接池。
2. 在 Cloudflare Dashboard → Workers & Pages → **Hyperdrive** 创建配置，粘贴
   Direct connection URL。建议为 Hyperdrive 创建只读数据库账号，只有
   `countries`、`foods`、`country_food_recommendations` 和
   `daily_macro_target_rules` 的 `SELECT` 权限。
3. 复制创建完成后的 Hyperdrive ID，替换
   [`wrangler.jsonc`](./wrangler.jsonc) 中的
   `REPLACE_WITH_YOUR_HYPERDRIVE_ID`。绑定名称必须保持为 `HYPERDRIVE`。
4. 将 Git 仓库接入 Cloudflare Workers Builds，生产分支选
   `codex/nextjs-api`。构建命令为 `npm run build:cloudflare`，部署命令为
   `npx wrangler deploy`；或在已登录 Cloudflare 的本地终端运行：

   ```bash
   npm run deploy:cloudflare
   ```

5. 部署后检查：

   ```text
   https://<your-worker-domain>/api/health
   https://<your-worker-domain>/api/countries
   https://<your-worker-domain>/api/daily-macro-target?weightKg=85&gender=male&trainingLevel=3&country=CN
   ```

`npm run preview:cloudflare` 可在本地用 Workers runtime 预览；需要真实
Hyperdrive 连接时使用 Cloudflare 的远程预览。不要将 Direct connection URL 或
数据库密码提交到仓库。

## 部署到 Vercel

Vercel 会自动识别 Next.js 项目，不需要使用本仓库的 Dockerfile。创建项目时
选择本仓库的 `codex/nextjs-api` 分支，Build Command 使用默认的
`npm run build`，不需要配置 Output Directory。

在 Vercel Project Settings → Environment Variables 中逐项添加：

```dotenv
SUPABASE_DB_HOST=aws-0-us-west-1.pooler.supabase.com
SUPABASE_DB_PORT=6543
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USERNAME=postgres.<your-project-ref>
SUPABASE_DB_PASSWORD=<database-password>
SUPABASE_DB_SSLMODE=require
```

这里的 `6543` 是 Supabase **Transaction Pooler**，适合 Vercel Serverless。代码会在
每个 Serverless 实例中复用连接池，并在检测到 `VERCEL` 时默认将连接数限制为
1；如需调整，可设置 `DB_POOL_MAX`。Vercel 环境变量不要写成 Java 的
`-DNAME=value` 形式，也不要把密码提交到 Git。

本项目没有使用命名 prepared statement，因此无需额外的 pgbouncer 参数。若部署
到长期运行的 VPS/Dokploy 容器，再考虑使用 Session Pooler `5432`；Direct
connection 更适合支持 IPv6 的持久化服务，不是 Vercel 的首选。

部署后可访问：

```text
https://<your-vercel-domain>/api/health
https://<your-vercel-domain>/api/countries
https://<your-vercel-domain>/api/daily-macro-target?weightKg=85&gender=male&trainingLevel=3&country=CN
```

## Database connection

The Next.js service reads its PostgreSQL connection from `DATABASE_URL` or the
following environment variables:

```text
SUPABASE_DB_HOST=aws-0-us-west-1.pooler.supabase.com
SUPABASE_DB_PORT=6543
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USERNAME=postgres.<your-project-ref>
SUPABASE_DB_PASSWORD=<database-password>
SUPABASE_DB_SSLMODE=require
```

Do not set `SUPABASE_DB_URL`; use standard `DATABASE_URL` when supplying a
single connection string. Otherwise the service assembles the PostgreSQL URL
from the variables above.

## Daily macro target API

`GET /api/daily-macro-target` calculates daily protein, carbohydrate, and fat
targets from the configured 100kg rule and the user's actual body weight. The
frontend sends a training level (1–5), not minutes; the API maps it to the
lower bound of the corresponding database interval.

Training-level mapping: `1 → [0,60)`, `2 → [120,180)`, `3 → [240,300)`,
`4 → [360,420)`, `5 → [480,NULL)` minutes per week.

```text
/api/daily-macro-target?weightKg=85&gender=male&trainingLevel=3
```

The endpoint returns each nutrient as a daily grams range:

```json
{
  "proteinG": {"min": 127.5, "max": 127.5},
  "carbsG": {"min": 199.8, "max": 199.8},
  "fatG": {"min": 72.3, "max": 72.3}
}
```

## Countries API

`GET /api/countries` returns all active countries in English-name order. Each
record includes a derived SVG country-flag URL; flag image files are not stored
in the database.

```json
[
  {
    "code": "CN",
    "nameEn": "China",
    "nameLocal": "中国",
    "locale": "zh-CN",
    "flagUrl": "https://flagcdn.com/cn.svg"
  }
]
```
