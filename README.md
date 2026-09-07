# GTS-BodySimulator-Server

## Database connection

The application reads every PostgreSQL connection setting from JVM system
properties or environment variables:

```text
-DSUPABASE_DB_HOST=aws-0-us-west-1.pooler.supabase.com
-DSUPABASE_DB_PORT=5432
-DSUPABASE_DB_NAME=postgres
-DSUPABASE_DB_USERNAME=postgres.csvmlhpsxfepglbdkhcq
-DSUPABASE_DB_PASSWORD=<database-password>
-DSUPABASE_DB_SSLMODE=require
```

Do not set `SUPABASE_DB_URL`; the JDBC URL is assembled from the properties
above. The same names can be provided as environment variables when running
outside an IDE.

## Daily macro target API

`GET /api/daily-macro-target` calculates daily protein, carbohydrate, and fat
targets from the configured 100kg rule and the user's actual body weight. The
frontend sends a training level (1–5), not minutes; the domain layer maps it to
the lower bound of the corresponding database interval.

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
