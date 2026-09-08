-- USDA FoodData Central Foundation Foods 导入（2026-04-30 数据快照）。
-- 仅保留原始 JSON 中同时提供 Protein(203)、Fat(204)、Carbohydrate(205)
-- 与 Energy(208) 的记录；所有数值按 USDA 原始记录的每 100g 可食部分保存。
-- 原始文件：FoodData_Central_foundation_food_json_2026-04-30.json

INSERT INTO public.foods (
    slug, name_en, food_group, protein_g, carbs_g, fat_g, energy_kcal,
    source_name, source_url, source_record_id, source_version
)
VALUES
    ('hummus_commercial', 'Hummus, commercial', 'Legumes and Legume Products', 7.35, 14.90, 17.10, 229.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/321358/nutrients', '321358', '2026-04-30'),
    ('almonds_dry_roasted_salted', 'Almonds, dry roasted, with salt added', 'Nut and Seed Products', 20.40, 16.20, 57.80, 620.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/323294/nutrients', '323294', '2026-04-30'),
    ('sunflower_seed_kernels_dry_roasted_salted', 'Sunflower seed kernels, dry roasted, with salt added', 'Nut and Seed Products', 21.00, 17.10, 56.10, 612.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/325524/nutrients', '325524', '2026-04-30'),
    ('cheese_parmesan_grated', 'Cheese, parmesan, grated', 'Dairy and Egg Products', 29.60, 12.40, 28.00, 421.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/325036/nutrients', '325036', '2026-04-30'),
    ('cheese_cheddar', 'Cheese, cheddar', 'Dairy and Egg Products', 23.30, 2.44, 34.00, 408.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/328637/nutrients', '328637', '2026-04-30'),
    ('cheese_cottage_lowfat_2_percent', 'Cheese, cottage, lowfat, 2% milkfat', 'Dairy and Egg Products', 11.00, 4.31, 2.30, 84.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/328841/nutrients', '328841', '2026-04-30'),
    ('cheese_mozzarella_low_moisture_part_skim', 'Cheese, mozzarella, low moisture, part-skim', 'Dairy and Egg Products', 23.70, 4.44, 20.40, 298.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/329370/nutrients', '329370', '2026-04-30'),
    ('yogurt_greek_plain_nonfat', 'Yogurt, Greek, plain, nonfat', 'Dairy and Egg Products', 10.30, 3.64, 0.37, 61.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/330137/nutrients', '330137', '2026-04-30'),
    ('coconut_oil', 'Oil, coconut', 'Fats and Oils', 0.00, 0.84, 99.10, 833.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/330458/nutrients', '330458', '2026-04-30'),
    ('chicken_drumstick_meat_only_cooked_braised', 'Chicken drumstick, meat only, cooked, braised', 'Poultry Products', 23.90, 0.00, 5.95, 156.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/331897/nutrients', '331897', '2026-04-30'),
    ('chicken_breast_skinless_boneless_cooked_braised', 'Chicken breast, skinless, boneless, cooked, braised', 'Poultry Products', 32.10, 0.00, 3.24, 166.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/331960/nutrients', '331960', '2026-04-30'),
    ('tuna_light_canned_water_drained', 'Tuna, light, canned in water, drained solids', 'Finfish and Shellfish Products', 19.00, 0.08, 0.94, 90.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/334194/nutrients', '334194', '2026-04-30'),
    ('fried_rice_chinese_restaurant_no_meat', 'Chinese restaurant fried rice, without meat', 'Restaurant Foods', 3.84, 32.50, 3.19, 174.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/334536/nutrients', '334536', '2026-04-30'),
    ('tamale_pork_restaurant', 'Restaurant tamale, pork', 'Restaurant Foods', 7.38, 15.80, 9.04, 174.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/334628/nutrients', '334628', '2026-04-30'),
    ('pupusa_bean_restaurant', 'Restaurant pupusa, bean', 'Restaurant Foods', 5.59, 31.50, 9.01, 229.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/334720/nutrients', '334720', '2026-04-30'),
    ('beef_tenderloin_lean_cooked_roasted', 'Beef tenderloin, lean, cooked, roasted', 'Beef Products', 27.70, 0.00, 6.36, 176.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746758/nutrients', '746758', '2026-04-30'),
    ('cheese_queso_seco_dry_white', 'Cheese, dry white, queso seco', 'Dairy and Egg Products', 24.50, 2.07, 24.30, 326.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746765/nutrients', '746765', '2026-04-30'),
    ('figs_dried_uncooked', 'Figs, dried, uncooked', 'Fruits and Fruit Juices', 3.30, 63.90, 0.92, 249.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746768/nutrients', '746768', '2026-04-30'),
    ('turkey_ground_93_percent_lean_pan_broiled', 'Turkey, ground, 93% lean, pan-broiled crumbles', 'Poultry Products', 27.10, 0.00, 11.60, 220.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/746785/nutrients', '746785', '2026-04-30'),
    ('whole_wheat_flour_unenriched', 'Whole wheat flour, unenriched', 'Cereal Grains and Pasta', 15.10, 71.20, 2.73, 370.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/790085/nutrients', '790085', '2026-04-30'),
    ('rice_flour_white_unenriched', 'Rice flour, white, unenriched', 'Cereal Grains and Pasta', 6.94, 79.80, 1.30, 359.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/790214/nutrients', '790214', '2026-04-30'),
    ('cornmeal_yellow_fine_enriched', 'Cornmeal, yellow, fine, enriched', 'Cereal Grains and Pasta', 6.20, 80.80, 1.74, 364.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/790276/nutrients', '790276', '2026-04-30'),
    ('banana_ripe_raw', 'Banana, ripe and slightly ripe, raw', 'Fruits and Fruit Juices', 0.74, 23.00, 0.29, 97.00, 'USDA FoodData Central Foundation Foods', 'https://fdc.nal.usda.gov/fdc-app.html#/food/1105314/nutrients', '1105314', '2026-04-30')
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
    source_version = EXCLUDED.source_version;
