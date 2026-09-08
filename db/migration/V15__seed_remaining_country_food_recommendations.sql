-- 补齐其余 20 个预置国家的常见食物推荐映射。
-- 本迁移仅复用已入库的统一营养食物与完整推荐模板，不复制 foods 营养数据。
-- 每个目标国家从与其饮食场景相近的已完成国家复制 protein、carbs、fat
-- 各 20 种候选食物，共 20 × 60 = 1,200 条推荐映射。
-- 后续取得当地权威食品成分库后，可在新的迁移中替换对应国家的特色食物。

INSERT INTO public.country_food_recommendations (
    country_code,
    food_id,
    macro_role
)
SELECT
    target.country_code,
    source_recommendation.food_id,
    source_recommendation.macro_role
FROM (
    VALUES
        -- 英语国家：复用加拿大模板。
        ('AU', 'CA'),
        ('NZ', 'CA'),

        -- 东南亚：复用中国的谷物、禽肉、鱼虾与豆类基础模板。
        ('SG', 'CN'),
        ('MY', 'CN'),
        ('ID', 'CN'),
        ('TH', 'CN'),
        ('VN', 'CN'),

        -- 菲律宾：复用美国模板。
        ('PH', 'US'),

        -- 欧洲：复用德国的烹调状态明确的 BLS 食物模板。
        ('FR', 'DE'),
        ('IT', 'DE'),
        ('ES', 'DE'),
        ('NL', 'DE'),
        ('RU', 'DE'),
        ('TR', 'DE'),
        ('CH', 'DE'),
        ('SE', 'DE'),

        -- 阿拉伯国家：复用美国模板中的谷物、坚果、芝麻酱等基础食物。
        ('SA', 'US'),
        ('AE', 'US'),

        -- 南部非洲与南美：分别复用英国、巴西模板。
        ('ZA', 'GB'),
        ('AR', 'BR')
) AS template_seed(country_code, template_country_code)
JOIN public.countries AS target
    ON target.country_code = template_seed.country_code
JOIN public.country_food_recommendations AS source_recommendation
    ON source_recommendation.country_code = template_seed.template_country_code
JOIN public.foods AS foods
    ON foods.id = source_recommendation.food_id
ON CONFLICT (country_code, food_id) DO UPDATE SET
    macro_role = EXCLUDED.macro_role;

-- 验收基线：20 个目标国家 × 3 个宏量栏目 × 每栏 20 种 = 1,200 条推荐映射。
