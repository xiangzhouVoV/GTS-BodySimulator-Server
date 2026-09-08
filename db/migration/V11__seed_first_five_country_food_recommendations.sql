-- 首批五国（CN、US、IN、JP、KR）的系统维护食物与推荐映射。
-- 每个国家的 protein、carbs、fat 三个栏目各有 20 个候选食物，共 300 条映射。
-- 食物营养事实来自用户提供的 USDA FoodData Central Foundation Foods
-- 2026-04-30 快照；所有数值均为每 100g 可食部分。
-- Energy 使用 USDA 原始记录中的 Nutrient 1008；若该记录未提供 1008，
-- 使用其同一原始记录中的 Nutrient 2047（Energy, Atwater General Factors），不做估算。

INSERT INTO public.foods (
    slug, name_en, food_group, protein_g, carbs_g, fat_g, energy_kcal,
    source_name, source_url, source_record_id, source_version, remark
)
VALUES
    -- Protein：20 种
    ('chicken_breast_skinless_boneless_cooked_braised', 'Chicken breast, skinless, boneless, meat only, cooked, braised', 'Poultry Products', 32.10, 0.00, 3.24, 166.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/331960/nutrients', '331960', '2026-04-30', '去皮去骨、熟炖的鸡胸肉。'),
    ('chicken_drumstick_meat_only_cooked_braised', 'Chicken drumstick, meat only, cooked, braised', 'Poultry Products', 23.90, 0.00, 5.95, 156.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/331897/nutrients', '331897', '2026-04-30', '仅肉部分、熟炖的鸡小腿。'),
    ('tuna_light_canned_water_drained', 'Tuna, light, canned in water, drained solids', 'Finfish and Shellfish Products', 19.00, 0.08, 0.94, 90.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/334194/nutrients', '334194', '2026-04-30', '水浸淡金枪鱼罐头，沥干固形物。'),
    ('beef_tenderloin_lean_cooked_roasted', 'Beef tenderloin roast, lean only, cooked, roasted', 'Beef Products', 27.70, 0.00, 6.36, 176.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746758/nutrients', '746758', '2026-04-30', '去可见脂肪、熟烤的牛里脊。'),
    ('turkey_ground_93_percent_lean_pan_broiled', 'Turkey, ground, 93% lean, pan-broiled crumbles', 'Poultry Products', 27.10, 0.00, 11.60, 220.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746785/nutrients', '746785', '2026-04-30', '93% 瘦、平底锅煎熟的火鸡肉末。'),
    ('egg_whole_raw_frozen_pasteurized', 'Egg, whole, raw, frozen, pasteurized', 'Dairy and Egg Products', 12.30, 0.91, 10.30, 150.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/323604/nutrients', '323604', '2026-04-30', '经巴氏杀菌的冷冻生全蛋液。'),
    ('egg_white_raw_frozen_pasteurized', 'Egg white, raw, frozen, pasteurized', 'Dairy and Egg Products', 10.10, 0.74, 0.16, 48.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/323697/nutrients', '323697', '2026-04-30', '经巴氏杀菌的冷冻生蛋清。'),
    ('yogurt_greek_plain_nonfat', 'Yogurt, Greek, plain, nonfat', 'Dairy and Egg Products', 10.30, 3.64, 0.37, 61.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/330137/nutrients', '330137', '2026-04-30', '原味无脂希腊酸奶。'),
    ('cheese_cottage_lowfat_2_percent', 'Cheese, cottage, lowfat, 2% milkfat', 'Dairy and Egg Products', 11.00, 4.31, 2.30, 84.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/328841/nutrients', '328841', '2026-04-30', '乳脂含量 2% 的低脂茅屋奶酪。'),
    ('pork_loin_boneless_raw', 'Pork loin, boneless, raw', 'Pork Products', 21.10, 0.00, 9.47, 168.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2646168/nutrients', '2646168', '2026-04-30', '去骨生猪里脊。'),
    ('pork_tenderloin_boneless_raw', 'Pork loin, tenderloin, boneless, raw', 'Pork Products', 21.60, 0.00, 3.90, 119.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2646169/nutrients', '2646169', '2026-04-30', '去骨生猪里脊嫩肉。'),
    ('chicken_breast_skinless_boneless_raw', 'Chicken breast, boneless, skinless, raw', 'Poultry Products', 22.50, 0.00, 1.93, 106.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2646170/nutrients', '2646170', '2026-04-30', '去皮去骨的生鸡胸肉。'),
    ('chicken_thigh_skinless_boneless_raw', 'Chicken thigh, boneless, skinless, raw', 'Poultry Products', 18.60, 0.00, 7.92, 144.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2646171/nutrients', '2646171', '2026-04-30', '去皮去骨的生鸡腿肉。'),
    ('salmon_sockeye_wild_raw', 'Salmon, sockeye, wild caught, raw', 'Finfish and Shellfish Products', 22.30, 0.00, 4.94, 130.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2684440/nutrients', '2684440', '2026-04-30', '野生红鲑，生。'),
    ('salmon_atlantic_farmed_raw', 'Salmon, Atlantic, farm raised, raw', 'Finfish and Shellfish Products', 20.30, 0.00, 13.10, 197.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2684441/nutrients', '2684441', '2026-04-30', '养殖大西洋鲑，生。'),
    ('tilapia_farmed_raw', 'Tilapia, farm raised, raw', 'Finfish and Shellfish Products', 19.00, 0.00, 2.48, 94.70, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2684442/nutrients', '2684442', '2026-04-30', '养殖罗非鱼，生。'),
    ('shrimp_farmed_raw', 'Shrimp, farm raised, raw', 'Finfish and Shellfish Products', 15.60, 0.49, 0.80, 71.40, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2684443/nutrients', '2684443', '2026-04-30', '养殖虾，生。'),
    ('cod_atlantic_wild_raw', 'Cod, Atlantic, wild caught, raw', 'Finfish and Shellfish Products', 16.10, 0.00, 0.67, 66.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2684444/nutrients', '2684444', '2026-04-30', '野生大西洋鳕鱼，生。'),
    ('haddock_raw', 'Haddock, raw', 'Finfish and Shellfish Products', 16.30, 0.00, 0.45, 74.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/333374/nutrients', '333374', '2026-04-30', '黑线鳕鱼，生。'),
    ('pollock_raw', 'Pollock, raw', 'Finfish and Shellfish Products', 12.30, 0.00, 0.41, 56.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/333476/nutrients', '333476', '2026-04-30', '明太鱼（狭鳕），生。'),

    -- Carbs：20 种
    ('oats_rolled_old_fashioned_dry', 'Oats, whole grain, rolled, old fashioned', 'Cereal Grains and Pasta', 13.50, 68.70, 5.89, 382.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2346396/nutrients', '2346396', '2026-04-30', '全谷传统燕麦片，干。'),
    ('oats_steel_cut_dry', 'Oats, whole grain, steel cut', 'Cereal Grains and Pasta', 12.50, 69.80, 5.80, 381.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2346397/nutrients', '2346397', '2026-04-30', '全谷钢切燕麦，干。'),
    ('rice_brown_long_grain_raw', 'Rice, brown, long grain, unenriched, raw', 'Cereal Grains and Pasta', 7.25, 76.70, 3.31, 366.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2512380/nutrients', '2512380', '2026-04-30', '未强化长粒糙米，生。'),
    ('rice_white_long_grain_raw', 'Rice, white, long grain, unenriched, raw', 'Cereal Grains and Pasta', 7.04, 80.30, 1.03, 359.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2512381/nutrients', '2512381', '2026-04-30', '未强化长粒白米，生。'),
    ('rice_black_unenriched_raw', 'Rice, black, unenriched, raw', 'Cereal Grains and Pasta', 7.57, 77.20, 3.44, 370.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2710825/nutrients', '2710825', '2026-04-30', '未强化黑米，生。'),
    ('rice_red_unenriched_dry', 'Rice, red, unenriched, dry', 'Cereal Grains and Pasta', 8.56, 76.20, 3.44, 370.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2710838/nutrients', '2710838', '2026-04-30', '未强化红米，干。'),
    ('buckwheat_whole_grain_dry', 'Buckwheat, whole grain', 'Cereal Grains and Pasta', 11.10, 71.10, 3.04, 356.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2512378/nutrients', '2512378', '2026-04-30', '全粒荞麦，干。'),
    ('millet_whole_grain_dry', 'Millet, whole grain', 'Cereal Grains and Pasta', 10.00, 74.40, 4.19, 376.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2512379/nutrients', '2512379', '2026-04-30', '全粒小米，干。'),
    ('potato_russet_without_skin_raw', 'Potato, russet, without skin, raw', 'Vegetables and Vegetable Products', 2.27, 17.80, 0.36, 83.40, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2346401/nutrients', '2346401', '2026-04-30', '去皮褐皮马铃薯，生。'),
    ('sweet_potato_orange_without_skin_raw', 'Sweet potato, orange flesh, without skin, raw', 'Vegetables and Vegetable Products', 1.58, 17.30, 0.38, 79.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2346404/nutrients', '2346404', '2026-04-30', '去皮橙肉红薯，生。'),
    ('whole_wheat_flour_unenriched', 'Flour, whole wheat, unenriched', 'Cereal Grains and Pasta', 15.10, 71.20, 2.73, 370.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/790085/nutrients', '790085', '2026-04-30', '未强化全麦面粉。'),
    ('rice_flour_white_unenriched', 'Flour, rice, white, unenriched', 'Cereal Grains and Pasta', 6.94, 79.80, 1.30, 359.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/790214/nutrients', '790214', '2026-04-30', '未强化白米粉。'),
    ('cornmeal_yellow_fine_enriched', 'Flour, corn, yellow, fine meal, enriched', 'Cereal Grains and Pasta', 6.20, 80.80, 1.74, 364.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/790276/nutrients', '790276', '2026-04-30', '强化细粒黄玉米粉。'),
    ('masa_harina_raw', 'Corn flour, masa harina, white or yellow, dry, raw', 'Cereal Grains and Pasta', 7.56, 76.70, 4.34, 376.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2710835/nutrients', '2710835', '2026-04-30', '白色或黄色玛莎玉米粉，干、生。'),
    ('quinoa_flour', 'Flour, quinoa', 'Cereal Grains and Pasta', 11.90, 69.50, 6.60, 385.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2512372/nutrients', '2512372', '2026-04-30', '藜麦粉。'),
    ('amaranth_flour', 'Flour, amaranth', 'Cereal Grains and Pasta', 13.20, 68.80, 6.24, 384.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2512371/nutrients', '2512371', '2026-04-30', '苋籽粉。'),
    ('cassava_flour', 'Flour, cassava', 'Vegetables and Vegetable Products', 0.92, 87.30, 0.49, 357.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2512377/nutrients', '2512377', '2026-04-30', '木薯粉。'),
    ('banana_ripe_raw', 'Banana, ripe and slightly ripe, raw', 'Fruits and Fruit Juices', 0.74, 23.00, 0.29, 97.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/1105314/nutrients', '1105314', '2026-04-30', '成熟或略熟香蕉，生食。'),
    ('apple_red_delicious_with_skin_raw', 'Apple, Red Delicious, with skin, raw', 'Fruits and Fruit Juices', 0.19, 14.80, 0.21, 61.80, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/1750339/nutrients', '1750339', '2026-04-30', '红蛇果，带皮生食。'),
    ('mango_tommy_atkins_peeled_raw', 'Mango, Tommy Atkins, peeled, raw', 'Fruits and Fruit Juices', 0.56, 15.30, 0.57, 68.50, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2710833/nutrients', '2710833', '2026-04-30', 'Tommy Atkins 芒果，去皮生食。'),

    -- Fat：20 种
    ('almonds_dry_roasted_salted', 'Almonds, dry roasted, with salt added', 'Nut and Seed Products', 20.40, 16.20, 57.80, 620.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/323294/nutrients', '323294', '2026-04-30', '加盐干烤杏仁。'),
    ('sunflower_seed_kernels_dry_roasted_salted', 'Sunflower seed kernels, dry roasted, with salt added', 'Nut and Seed Products', 21.00, 17.10, 56.10, 612.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/325524/nutrients', '325524', '2026-04-30', '加盐干烤葵花籽仁。'),
    ('coconut_oil', 'Oil, coconut', 'Fats and Oils', 0.00, 0.84, 99.10, 833.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/330458/nutrients', '330458', '2026-04-30', '椰子油。'),
    ('peanut_butter_creamy', 'Peanut butter, creamy', 'Legumes and Legume Products', 24.00, 22.70, 49.40, 632.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2262072/nutrients', '2262072', '2026-04-30', '顺滑型花生酱。'),
    ('sesame_butter_creamy', 'Sesame butter, creamy', 'Nut and Seed Products', 19.70, 14.20, 62.40, 697.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2262073/nutrients', '2262073', '2026-04-30', '顺滑型芝麻酱。'),
    ('almond_butter_creamy', 'Almond butter, creamy', 'Nut and Seed Products', 20.80, 21.20, 53.00, 645.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2262074/nutrients', '2262074', '2026-04-30', '顺滑型杏仁酱。'),
    ('flaxseed_ground', 'Flaxseed, ground', 'Nut and Seed Products', 18.00, 34.40, 37.30, 545.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2262075/nutrients', '2262075', '2026-04-30', '研磨亚麻籽。'),
    ('pine_nuts_raw', 'Pine nuts, raw', 'Nut and Seed Products', 15.70, 18.60, 61.30, 689.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2346392/nutrients', '2346392', '2026-04-30', '松子，生。'),
    ('walnuts_english_raw', 'Walnuts, English, halves, raw', 'Nut and Seed Products', 14.60, 10.90, 69.70, 730.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2346394/nutrients', '2346394', '2026-04-30', '英式核桃半仁，生。'),
    ('pecans_raw', 'Pecans, halves, raw', 'Nut and Seed Products', 9.96, 12.70, 73.30, 750.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2346395/nutrients', '2346395', '2026-04-30', '碧根果半仁，生。'),
    ('cashews_raw', 'Cashew nuts, raw', 'Nut and Seed Products', 17.40, 36.30, 38.90, 565.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2515374/nutrients', '2515374', '2026-04-30', '腰果，生。'),
    ('avocado_hass_peeled_raw', 'Avocado, Hass, peeled, raw', 'Fruits and Fruit Juices', 1.81, 8.32, 20.30, 223.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2710824/nutrients', '2710824', '2026-04-30', '哈斯牛油果，去皮生食。'),
    ('cheese_cheddar', 'Cheese, cheddar', 'Dairy and Egg Products', 23.30, 2.44, 34.00, 408.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/328637/nutrients', '328637', '2026-04-30', '切达奶酪。'),
    ('cheese_parmesan_grated', 'Cheese, parmesan, grated', 'Dairy and Egg Products', 29.60, 12.40, 28.00, 421.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/325036/nutrients', '325036', '2026-04-30', '磨碎帕玛森奶酪。'),
    ('cheese_mozzarella_low_moisture_part_skim', 'Cheese, mozzarella, low moisture, part-skim', 'Dairy and Egg Products', 23.70, 4.44, 20.40, 298.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/329370/nutrients', '329370', '2026-04-30', '低水分、部分脱脂马苏里拉奶酪。'),
    ('egg_yolk_raw_frozen_pasteurized', 'Egg yolk, raw, frozen, pasteurized', 'Dairy and Egg Products', 15.60, 0.59, 25.10, 296.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/329596/nutrients', '329596', '2026-04-30', '经巴氏杀菌的冷冻生蛋黄。'),
    ('cheese_queso_seco_dry_white', 'Cheese, dry white, queso seco', 'Dairy and Egg Products', 24.50, 2.07, 24.30, 326.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746765/nutrients', '746765', '2026-04-30', '干制白奶酪（Queso Seco）。'),
    ('cheese_ricotta_whole_milk', 'Cheese, ricotta, whole milk', 'Dairy and Egg Products', 7.81, 6.86, 11.00, 157.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746766/nutrients', '746766', '2026-04-30', '全脂意大利乳清奶酪。'),
    ('cheese_swiss', 'Cheese, swiss', 'Dairy and Egg Products', 27.00, 1.44, 31.00, 393.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746767/nutrients', '746767', '2026-04-30', '瑞士奶酪。'),
    ('yogurt_greek_plain_whole_milk', 'Yogurt, Greek, plain, whole milk', 'Dairy and Egg Products', 8.78, 4.75, 4.39, 93.70, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/2259794/nutrients', '2259794', '2026-04-30', '原味全脂希腊酸奶。')
ON CONFLICT (slug) DO UPDATE SET
    name_en = EXCLUDED.name_en,
    food_group = EXCLUDED.food_group,
    protein_g = EXCLUDED.protein_g,
    carbs_g = EXCLUDED.carbs_g,
    fat_g = EXCLUDED.fat_g,
    energy_kcal = EXCLUDED.energy_kcal,
    source_name = EXCLUDED.source_name,
    source_url = EXCLUDED.source_url,
    source_record_id = EXCLUDED.source_record_id,
    source_version = EXCLUDED.source_version,
    remark = EXCLUDED.remark;

-- 同一食物库在五国复用；国家与宏量栏目关系由此表维护，不复制营养数据。
INSERT INTO public.country_food_recommendations (country_code, food_id, macro_role)
SELECT country_seed.country_code, foods.id, food_seed.macro_role
FROM (
    VALUES ('CN'), ('US'), ('IN'), ('JP'), ('KR')
) AS country_seed(country_code)
CROSS JOIN (
    VALUES
        ('protein', 'chicken_breast_skinless_boneless_cooked_braised'),
        ('protein', 'chicken_drumstick_meat_only_cooked_braised'),
        ('protein', 'tuna_light_canned_water_drained'),
        ('protein', 'beef_tenderloin_lean_cooked_roasted'),
        ('protein', 'turkey_ground_93_percent_lean_pan_broiled'),
        ('protein', 'egg_whole_raw_frozen_pasteurized'),
        ('protein', 'egg_white_raw_frozen_pasteurized'),
        ('protein', 'yogurt_greek_plain_nonfat'),
        ('protein', 'cheese_cottage_lowfat_2_percent'),
        ('protein', 'pork_loin_boneless_raw'),
        ('protein', 'pork_tenderloin_boneless_raw'),
        ('protein', 'chicken_breast_skinless_boneless_raw'),
        ('protein', 'chicken_thigh_skinless_boneless_raw'),
        ('protein', 'salmon_sockeye_wild_raw'),
        ('protein', 'salmon_atlantic_farmed_raw'),
        ('protein', 'tilapia_farmed_raw'),
        ('protein', 'shrimp_farmed_raw'),
        ('protein', 'cod_atlantic_wild_raw'),
        ('protein', 'haddock_raw'),
        ('protein', 'pollock_raw'),
        ('carbs', 'oats_rolled_old_fashioned_dry'),
        ('carbs', 'oats_steel_cut_dry'),
        ('carbs', 'rice_brown_long_grain_raw'),
        ('carbs', 'rice_white_long_grain_raw'),
        ('carbs', 'rice_black_unenriched_raw'),
        ('carbs', 'rice_red_unenriched_dry'),
        ('carbs', 'buckwheat_whole_grain_dry'),
        ('carbs', 'millet_whole_grain_dry'),
        ('carbs', 'potato_russet_without_skin_raw'),
        ('carbs', 'sweet_potato_orange_without_skin_raw'),
        ('carbs', 'whole_wheat_flour_unenriched'),
        ('carbs', 'rice_flour_white_unenriched'),
        ('carbs', 'cornmeal_yellow_fine_enriched'),
        ('carbs', 'masa_harina_raw'),
        ('carbs', 'quinoa_flour'),
        ('carbs', 'amaranth_flour'),
        ('carbs', 'cassava_flour'),
        ('carbs', 'banana_ripe_raw'),
        ('carbs', 'apple_red_delicious_with_skin_raw'),
        ('carbs', 'mango_tommy_atkins_peeled_raw'),
        ('fat', 'almonds_dry_roasted_salted'),
        ('fat', 'sunflower_seed_kernels_dry_roasted_salted'),
        ('fat', 'coconut_oil'),
        ('fat', 'peanut_butter_creamy'),
        ('fat', 'sesame_butter_creamy'),
        ('fat', 'almond_butter_creamy'),
        ('fat', 'flaxseed_ground'),
        ('fat', 'pine_nuts_raw'),
        ('fat', 'walnuts_english_raw'),
        ('fat', 'pecans_raw'),
        ('fat', 'cashews_raw'),
        ('fat', 'avocado_hass_peeled_raw'),
        ('fat', 'cheese_cheddar'),
        ('fat', 'cheese_parmesan_grated'),
        ('fat', 'cheese_mozzarella_low_moisture_part_skim'),
        ('fat', 'egg_yolk_raw_frozen_pasteurized'),
        ('fat', 'cheese_queso_seco_dry_white'),
        ('fat', 'cheese_ricotta_whole_milk'),
        ('fat', 'cheese_swiss'),
        ('fat', 'yogurt_greek_plain_whole_milk')
) AS food_seed(macro_role, slug)
JOIN public.countries countries ON countries.country_code = country_seed.country_code
JOIN public.foods foods ON foods.slug = food_seed.slug
ON CONFLICT (country_code, food_id) DO UPDATE SET
    macro_role = EXCLUDED.macro_role;

-- 验收基线：5 个国家 × 3 栏 × 每栏 20 种 = 300 条推荐映射。
