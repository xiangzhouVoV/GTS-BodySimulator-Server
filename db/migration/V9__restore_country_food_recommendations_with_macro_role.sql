-- 国家常见食物仍需以主宏量营养素归类，便于前端分栏展示。
-- 食物记录本身始终保存完整的蛋白质、碳水化合物和脂肪营养值；macro_role
-- 仅表示该国家场景下的主展示分类，不表示食物只含一种营养素。
-- 不恢复 serving_g：份量由客户端或用户自行输入。

CREATE TABLE public.country_food_recommendations (
    country_code CHAR(2) NOT NULL REFERENCES public.countries(country_code),
    food_id UUID NOT NULL REFERENCES public.foods(id),
    macro_role TEXT NOT NULL,
    PRIMARY KEY (country_code, food_id),
    CONSTRAINT country_food_recommendations_macro_role_check
        CHECK (macro_role IN ('protein', 'carbs', 'fat'))
);

COMMENT ON TABLE public.country_food_recommendations IS '各国常见食物与统一食物库的关联，并标记食物的主宏量营养素展示分类。';
COMMENT ON COLUMN public.country_food_recommendations.country_code IS '关联 countries.country_code 的国家码；与 food_id 共同组成主键。';
COMMENT ON COLUMN public.country_food_recommendations.food_id IS '关联 foods.id 的平台食物记录；同一国家的同一食物仅出现一次。';
COMMENT ON COLUMN public.country_food_recommendations.macro_role IS '前端主展示栏目，只能为 protein、carbs 或 fat；食物本身仍保留完整三大营养素。';

CREATE INDEX country_food_recommendations_country_role_idx
    ON public.country_food_recommendations (country_code, macro_role);

ALTER TABLE public.country_food_recommendations ENABLE ROW LEVEL SECURITY;

GRANT SELECT ON public.country_food_recommendations TO anon, authenticated;

CREATE POLICY country_food_recommendations_public_read_active_country
    ON public.country_food_recommendations FOR SELECT TO anon, authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.countries c
            WHERE c.country_code = country_food_recommendations.country_code
              AND c.is_active = TRUE
        )
    );

-- V8 删除了依赖旧推荐表的策略；在映射表恢复后同步恢复平台食物只读策略。
DROP POLICY IF EXISTS foods_public_read_recommended ON public.foods;

CREATE POLICY foods_public_read_recommended
    ON public.foods FOR SELECT TO anon, authenticated
    USING (
        EXISTS (
            SELECT 1
            FROM public.country_food_recommendations r
            JOIN public.countries c ON c.country_code = r.country_code
            WHERE r.food_id = foods.id
              AND c.is_active = TRUE
        )
    );
