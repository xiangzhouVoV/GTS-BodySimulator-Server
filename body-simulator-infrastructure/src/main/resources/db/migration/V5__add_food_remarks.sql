-- 食物的产品侧中文备注；不替代 USDA 原始英文名称或营养数据来源。

ALTER TABLE public.foods
    ADD COLUMN IF NOT EXISTS remark TEXT;

COMMENT ON COLUMN public.foods.remark IS '食物的简短中文备注，用于解释食物状态或向客户端展示；不作为营养数据来源。';

UPDATE public.foods AS foods
SET remark = seed.remark
FROM (
    VALUES
        ('hummus_commercial', '市售鹰嘴豆泥，以鹰嘴豆和芝麻酱为主要原料。'),
        ('almonds_dry_roasted_salted', '加盐烘烤杏仁。'),
        ('sunflower_seed_kernels_dry_roasted_salted', '加盐烘烤葵花籽仁。'),
        ('cheese_parmesan_grated', '磨碎的帕玛森奶酪。'),
        ('cheese_cheddar', '切达奶酪。'),
        ('cheese_cottage_lowfat_2_percent', '脂肪含量 2% 的低脂茅屋奶酪。'),
        ('cheese_mozzarella_low_moisture_part_skim', '低水分、部分脱脂的马苏里拉奶酪。'),
        ('yogurt_greek_plain_nonfat', '原味无脂希腊酸奶。'),
        ('coconut_oil', '椰子油。'),
        ('chicken_drumstick_meat_only_cooked_braised', '去骨肉部分的熟炖鸡腿肉。'),
        ('chicken_breast_skinless_boneless_cooked_braised', '去皮去骨的熟炖鸡胸肉。'),
        ('tuna_light_canned_water_drained', '水浸淡金枪鱼罐头，沥干固形物。'),
        ('fried_rice_chinese_restaurant_no_meat', '餐厅中式无肉炒饭。'),
        ('tamale_pork_restaurant', '餐厅供应的猪肉塔马利。'),
        ('pupusa_bean_restaurant', '餐厅供应的豆馅普普萨饼。'),
        ('beef_tenderloin_lean_cooked_roasted', '去可见脂肪的熟烤牛里脊。'),
        ('cheese_queso_seco_dry_white', '干制白奶酪（Queso Seco）。'),
        ('figs_dried_uncooked', '未经烹调的干无花果。'),
        ('turkey_ground_93_percent_lean_pan_broiled', '93% 瘦的平底锅煎熟火鸡肉末。'),
        ('whole_wheat_flour_unenriched', '未强化的全麦面粉。'),
        ('rice_flour_white_unenriched', '未强化的白米粉。'),
        ('cornmeal_yellow_fine_enriched', '强化的细粒黄玉米粉。'),
        ('banana_ripe_raw', '生食的成熟或略熟香蕉。')
) AS seed(slug, remark)
WHERE foods.slug = seed.slug;
