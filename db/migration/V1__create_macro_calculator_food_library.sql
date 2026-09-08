-- Macro Calculator 统一食物营养库。
-- 所有营养数值均表示每 100g 可食部分，而非建议单份的营养数值。

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE public.countries (
    country_code CHAR(2) PRIMARY KEY,
    name_en TEXT NOT NULL,
    name_local TEXT NOT NULL,
    locale TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT countries_country_code_uppercase_check
        CHECK (country_code ~ '^[A-Z]{2}$')
);

COMMENT ON TABLE public.countries IS 'Macro Calculator 可展示的国家或地区配置。国家仅影响食物推荐与本地化展示，不影响用户宏量营养目标。';
COMMENT ON COLUMN public.countries.country_code IS 'ISO 3166-1 alpha-2 两位大写国家码，例如 CN、US、JP；主键。';
COMMENT ON COLUMN public.countries.name_en IS '国家英文名称。';
COMMENT ON COLUMN public.countries.name_local IS '国家当地语言名称。';
COMMENT ON COLUMN public.countries.locale IS '默认展示语言区域标识，例如 zh-CN、en-US。';
COMMENT ON COLUMN public.countries.is_active IS '是否在客户端国家选择器中展示。';
COMMENT ON COLUMN public.countries.created_at IS '记录创建时间（UTC）。';

CREATE TABLE public.foods (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug TEXT NOT NULL UNIQUE,
    name_en TEXT NOT NULL,
    food_group TEXT NOT NULL,
    protein_g NUMERIC(7, 2) NOT NULL,
    carbs_g NUMERIC(7, 2) NOT NULL,
    fat_g NUMERIC(7, 2) NOT NULL,
    energy_kcal NUMERIC(7, 2) NOT NULL,
    source_name TEXT NOT NULL,
    source_url TEXT NOT NULL,
    source_record_id TEXT NOT NULL,
    source_version TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT foods_slug_format_check CHECK (slug ~ '^[a-z0-9]+(?:_[a-z0-9]+)*$'),
    CONSTRAINT foods_protein_g_nonnegative_check CHECK (protein_g >= 0),
    CONSTRAINT foods_carbs_g_nonnegative_check CHECK (carbs_g >= 0),
    CONSTRAINT foods_fat_g_nonnegative_check CHECK (fat_g >= 0),
    CONSTRAINT foods_energy_kcal_nonnegative_check CHECK (energy_kcal >= 0)
);

COMMENT ON TABLE public.foods IS '统一食物营养事实库。一条记录必须代表明确最终状态的食物，例如 rice_cooked、beef_jerky；营养数值均按每 100g 可食部分保存。';
COMMENT ON COLUMN public.foods.id IS '食物主键 UUID。';
COMMENT ON COLUMN public.foods.slug IS '稳定且唯一的程序标识；必须包含食物最终状态，不设置独立 preparation 字段。';
COMMENT ON COLUMN public.foods.name_en IS '食物统一英文名称，名称应明确体现最终状态。';
COMMENT ON COLUMN public.foods.food_group IS '食物大类，例如 poultry、grain、legume、dairy。';
COMMENT ON COLUMN public.foods.protein_g IS '每 100g 可食部分的蛋白质克数。';
COMMENT ON COLUMN public.foods.carbs_g IS '每 100g 可食部分的碳水化合物克数。';
COMMENT ON COLUMN public.foods.fat_g IS '每 100g 可食部分的脂肪克数。';
COMMENT ON COLUMN public.foods.energy_kcal IS '每 100g 可食部分的能量（千卡）。';
COMMENT ON COLUMN public.foods.source_name IS '营养数据来源名称，例如 USDA FoodData Central 或国家官方成分库。';
COMMENT ON COLUMN public.foods.source_url IS '营养数据来源的可访问链接。';
COMMENT ON COLUMN public.foods.source_record_id IS '来源系统中的食物记录唯一标识，用于回溯原始数据。';
COMMENT ON COLUMN public.foods.source_version IS '来源数据版本、发布日期或抓取批次标识。';
COMMENT ON COLUMN public.foods.created_at IS '记录创建时间（UTC）。';

CREATE TABLE public.country_food_recommendations (
    country_code CHAR(2) NOT NULL REFERENCES public.countries(country_code),
    food_id UUID NOT NULL REFERENCES public.foods(id),
    macro_role TEXT NOT NULL,
    display_name_en TEXT NOT NULL,
    display_name_local TEXT NOT NULL,
    serving_g NUMERIC(7, 2) NOT NULL,
    sort_order INTEGER NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (country_code, food_id),
    CONSTRAINT country_food_recommendations_macro_role_check
        CHECK (macro_role IN ('protein', 'carbs', 'fat')),
    CONSTRAINT country_food_recommendations_serving_g_positive_check
        CHECK (serving_g > 0),
    CONSTRAINT country_food_recommendations_sort_order_positive_check
        CHECK (sort_order > 0),
    CONSTRAINT country_food_recommendations_role_sort_order_unique
        UNIQUE (country_code, macro_role, sort_order)
);

COMMENT ON TABLE public.country_food_recommendations IS '国家与统一食物库之间的展示推荐映射。它决定食物在哪个宏量栏目出现、名称、建议份量和排序，不复制营养数据。';
COMMENT ON COLUMN public.country_food_recommendations.country_code IS '关联 countries.country_code 的国家码；与 food_id 共同组成主键。';
COMMENT ON COLUMN public.country_food_recommendations.food_id IS '关联 foods.id 的食物；同一食物在同一国家仅能推荐一次，避免跨三栏重复。';
COMMENT ON COLUMN public.country_food_recommendations.macro_role IS '页面展示栏目，只能是 protein、carbs 或 fat。';
COMMENT ON COLUMN public.country_food_recommendations.display_name_en IS '面向该国家用户显示的英文食物名称。';
COMMENT ON COLUMN public.country_food_recommendations.display_name_local IS '面向该国家用户显示的当地语言食物名称。';
COMMENT ON COLUMN public.country_food_recommendations.serving_g IS '该国家场景下建议单份重量（克）；不改变 foods 中每 100g 的营养事实。';
COMMENT ON COLUMN public.country_food_recommendations.sort_order IS '同一国家、同一宏量栏目内的升序展示排序。';
COMMENT ON COLUMN public.country_food_recommendations.is_active IS '是否在客户端推荐列表中展示。';
COMMENT ON COLUMN public.country_food_recommendations.created_at IS '记录创建时间（UTC）。';

CREATE INDEX country_food_recommendations_active_listing_idx
    ON public.country_food_recommendations (country_code, macro_role, sort_order)
    WHERE is_active = TRUE;

-- 首期支持的国家。食物与推荐数据应由独立的、可追溯来源的后续迁移导入。
INSERT INTO public.countries (country_code, name_en, name_local, locale) VALUES
    ('CN', 'China', '中国', 'zh-CN'),
    ('US', 'United States', 'United States', 'en-US'),
    ('IN', 'India', 'भारत', 'hi-IN'),
    ('JP', 'Japan', '日本', 'ja-JP'),
    ('KR', 'South Korea', '대한민국', 'ko-KR'),
    ('GB', 'United Kingdom', 'United Kingdom', 'en-GB'),
    ('MX', 'Mexico', 'México', 'es-MX'),
    ('BR', 'Brazil', 'Brasil', 'pt-BR');

-- 客户端仅可读取已启用的公开数据；没有写策略，写操作只能由数据库管理员或受控服务完成。
ALTER TABLE public.countries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.foods ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.country_food_recommendations ENABLE ROW LEVEL SECURITY;

GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT SELECT ON public.countries, public.foods, public.country_food_recommendations TO anon, authenticated;

CREATE POLICY countries_public_read_active
    ON public.countries FOR SELECT TO anon, authenticated
    USING (is_active = TRUE);

CREATE POLICY country_food_recommendations_public_read_active
    ON public.country_food_recommendations FOR SELECT TO anon, authenticated
    USING (
        is_active = TRUE
        AND EXISTS (
            SELECT 1
            FROM public.countries c
            WHERE c.country_code = country_food_recommendations.country_code
              AND c.is_active = TRUE
        )
    );

CREATE POLICY foods_public_read_recommended
    ON public.foods FOR SELECT TO anon, authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.country_food_recommendations r
            JOIN public.countries c ON c.country_code = r.country_code
            WHERE r.food_id = foods.id
              AND r.is_active = TRUE
              AND c.is_active = TRUE
        )
    );
