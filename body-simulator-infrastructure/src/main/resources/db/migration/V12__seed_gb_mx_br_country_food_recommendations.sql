-- 补齐首期剩余国家：英国（GB）、墨西哥（MX）、巴西（BR）。
-- 沿用 V11 已导入的统一 USDA Foundation Foods；本迁移仅维护国家与
-- 主展示栏目的映射，不复制或估算营养数据。
-- 每国 protein、carbs、fat 各 20 种，共 180 条映射。

INSERT INTO public.country_food_recommendations (country_code, food_id, macro_role)
SELECT country_seed.country_code, foods.id, food_seed.macro_role
FROM (
    VALUES ('GB'), ('MX'), ('BR')
) AS country_seed(country_code)
CROSS JOIN (
    VALUES
        -- Protein：禽肉、瘦肉、蛋奶、鱼虾为三国常见的高蛋白基础食物。
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

        -- Carbs：燕麦、谷物、米类、薯类、玉米及水果。
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

        -- Fat：坚果、种子、果酱、乳酪、蛋黄与牛油果。
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

-- 验收基线：3 个国家 × 3 栏 × 每栏 20 种 = 180 条推荐映射。
