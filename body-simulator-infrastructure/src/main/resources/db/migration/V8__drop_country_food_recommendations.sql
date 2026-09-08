-- 当前产品直接展示每个食物完整的蛋白质、碳水化合物和脂肪数据，
-- 不再按单一宏量栏目归类，也不维护默认建议份量。
-- foods_public_read_recommended RLS 策略依赖该表，CASCADE 会同步删除旧策略。
DROP TABLE IF EXISTS public.country_food_recommendations CASCADE;
