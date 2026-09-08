-- countries 为预置配置数据，不维护单条记录创建时间。
ALTER TABLE public.countries
    DROP COLUMN IF EXISTS created_at;
