-- 首期八国食物展示配置。
-- 这是产品推荐配置，而非官方饮食消费排名；营养事实均由 V3 中的 USDA
-- Foundation Foods 原始记录提供。每个国家、每个宏量栏目暂展示前三项。

INSERT INTO public.country_food_recommendations (
    country_code, food_id, macro_role, display_name_en, display_name_local,
    serving_g, sort_order, is_active
)
SELECT
    seed.country_code,
    foods.id,
    seed.macro_role,
    seed.display_name_en,
    seed.display_name_local,
    seed.serving_g,
    seed.sort_order,
    TRUE
FROM (
    VALUES
        ('CN', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', '熟鸡胸肉', 150.00, 1),
        ('CN', 'chicken_drumstick_meat_only_cooked_braised', 'protein', 'Cooked chicken drumstick', '熟鸡腿肉', 150.00, 2),
        ('CN', 'tuna_light_canned_water_drained', 'protein', 'Canned light tuna', '水浸淡金枪鱼罐头', 100.00, 3),
        ('CN', 'fried_rice_chinese_restaurant_no_meat', 'carbs', 'Chinese fried rice', '中式素炒饭', 200.00, 1),
        ('CN', 'rice_flour_white_unenriched', 'carbs', 'White rice flour', '白米粉', 50.00, 2),
        ('CN', 'banana_ripe_raw', 'carbs', 'Ripe banana', '熟香蕉', 120.00, 3),
        ('CN', 'sunflower_seed_kernels_dry_roasted_salted', 'fat', 'Roasted sunflower seeds', '烤葵花籽', 30.00, 1),
        ('CN', 'coconut_oil', 'fat', 'Coconut oil', '椰子油', 15.00, 2),
        ('CN', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', '烤杏仁', 30.00, 3),

        ('US', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', 'Cooked chicken breast', 150.00, 1),
        ('US', 'turkey_ground_93_percent_lean_pan_broiled', 'protein', 'Pan-broiled lean ground turkey', 'Pan-broiled lean ground turkey', 150.00, 2),
        ('US', 'yogurt_greek_plain_nonfat', 'protein', 'Plain nonfat Greek yogurt', 'Plain nonfat Greek yogurt', 200.00, 3),
        ('US', 'banana_ripe_raw', 'carbs', 'Ripe banana', 'Ripe banana', 120.00, 1),
        ('US', 'whole_wheat_flour_unenriched', 'carbs', 'Whole wheat flour', 'Whole wheat flour', 50.00, 2),
        ('US', 'figs_dried_uncooked', 'carbs', 'Dried figs', 'Dried figs', 40.00, 3),
        ('US', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', 'Roasted almonds', 30.00, 1),
        ('US', 'cheese_cheddar', 'fat', 'Cheddar cheese', 'Cheddar cheese', 30.00, 2),
        ('US', 'hummus_commercial', 'fat', 'Commercial hummus', 'Commercial hummus', 50.00, 3),

        ('IN', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', 'पका हुआ चिकन ब्रेस्ट', 150.00, 1),
        ('IN', 'yogurt_greek_plain_nonfat', 'protein', 'Plain nonfat Greek yogurt', 'सादा नॉनफैट ग्रीक योगर्ट', 200.00, 2),
        ('IN', 'chicken_drumstick_meat_only_cooked_braised', 'protein', 'Cooked chicken drumstick', 'पका हुआ चिकन लेग', 150.00, 3),
        ('IN', 'rice_flour_white_unenriched', 'carbs', 'White rice flour', 'सफेद चावल का आटा', 50.00, 1),
        ('IN', 'cornmeal_yellow_fine_enriched', 'carbs', 'Fine yellow cornmeal', 'महीन पीला मक्के का आटा', 50.00, 2),
        ('IN', 'banana_ripe_raw', 'carbs', 'Ripe banana', 'पका केला', 120.00, 3),
        ('IN', 'coconut_oil', 'fat', 'Coconut oil', 'नारियल तेल', 15.00, 1),
        ('IN', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', 'भुने बादाम', 30.00, 2),
        ('IN', 'sunflower_seed_kernels_dry_roasted_salted', 'fat', 'Roasted sunflower seeds', 'भुने सूरजमुखी के बीज', 30.00, 3),

        ('JP', 'tuna_light_canned_water_drained', 'protein', 'Canned light tuna', '水煮ライトツナ缶', 100.00, 1),
        ('JP', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', '調理済み鶏むね肉', 150.00, 2),
        ('JP', 'yogurt_greek_plain_nonfat', 'protein', 'Plain nonfat Greek yogurt', 'プレーン無脂肪ギリシャヨーグルト', 200.00, 3),
        ('JP', 'fried_rice_chinese_restaurant_no_meat', 'carbs', 'Chinese fried rice', '中華チャーハン（肉なし）', 200.00, 1),
        ('JP', 'rice_flour_white_unenriched', 'carbs', 'White rice flour', '白米粉', 50.00, 2),
        ('JP', 'banana_ripe_raw', 'carbs', 'Ripe banana', '熟したバナナ', 120.00, 3),
        ('JP', 'sunflower_seed_kernels_dry_roasted_salted', 'fat', 'Roasted sunflower seeds', 'ローストひまわりの種', 30.00, 1),
        ('JP', 'cheese_mozzarella_low_moisture_part_skim', 'fat', 'Part-skim mozzarella', '低水分モッツァレラチーズ', 50.00, 2),
        ('JP', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', 'ローストアーモンド', 30.00, 3),

        ('KR', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', '조리된 닭가슴살', 150.00, 1),
        ('KR', 'tuna_light_canned_water_drained', 'protein', 'Canned light tuna', '물에 담근 라이트 참치 통조림', 100.00, 2),
        ('KR', 'chicken_drumstick_meat_only_cooked_braised', 'protein', 'Cooked chicken drumstick', '조리된 닭다리살', 150.00, 3),
        ('KR', 'fried_rice_chinese_restaurant_no_meat', 'carbs', 'Chinese fried rice', '중식 볶음밥(고기 없음)', 200.00, 1),
        ('KR', 'rice_flour_white_unenriched', 'carbs', 'White rice flour', '백미 가루', 50.00, 2),
        ('KR', 'banana_ripe_raw', 'carbs', 'Ripe banana', '익은 바나나', 120.00, 3),
        ('KR', 'sunflower_seed_kernels_dry_roasted_salted', 'fat', 'Roasted sunflower seeds', '볶은 해바라기씨', 30.00, 1),
        ('KR', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', '볶은 아몬드', 30.00, 2),
        ('KR', 'cheese_mozzarella_low_moisture_part_skim', 'fat', 'Part-skim mozzarella', '저지방 모짜렐라 치즈', 50.00, 3),

        ('GB', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', 'Cooked chicken breast', 150.00, 1),
        ('GB', 'beef_tenderloin_lean_cooked_roasted', 'protein', 'Roasted lean beef tenderloin', 'Roasted lean beef tenderloin', 150.00, 2),
        ('GB', 'cheese_cottage_lowfat_2_percent', 'protein', 'Low-fat cottage cheese', 'Low-fat cottage cheese', 200.00, 3),
        ('GB', 'whole_wheat_flour_unenriched', 'carbs', 'Whole wheat flour', 'Whole wheat flour', 50.00, 1),
        ('GB', 'banana_ripe_raw', 'carbs', 'Ripe banana', 'Ripe banana', 120.00, 2),
        ('GB', 'figs_dried_uncooked', 'carbs', 'Dried figs', 'Dried figs', 40.00, 3),
        ('GB', 'cheese_cheddar', 'fat', 'Cheddar cheese', 'Cheddar cheese', 30.00, 1),
        ('GB', 'cheese_parmesan_grated', 'fat', 'Grated parmesan', 'Grated parmesan', 20.00, 2),
        ('GB', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', 'Roasted almonds', 30.00, 3),

        ('MX', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', 'Pechuga de pollo cocida', 150.00, 1),
        ('MX', 'beef_tenderloin_lean_cooked_roasted', 'protein', 'Roasted lean beef tenderloin', 'Solomillo de res magro asado', 150.00, 2),
        ('MX', 'tuna_light_canned_water_drained', 'protein', 'Canned light tuna', 'Atún claro enlatado en agua', 100.00, 3),
        ('MX', 'tamale_pork_restaurant', 'carbs', 'Pork tamale', 'Tamal de cerdo', 150.00, 1),
        ('MX', 'cornmeal_yellow_fine_enriched', 'carbs', 'Fine yellow cornmeal', 'Harina de maíz amarilla fina', 50.00, 2),
        ('MX', 'banana_ripe_raw', 'carbs', 'Ripe banana', 'Plátano maduro', 120.00, 3),
        ('MX', 'cheese_queso_seco_dry_white', 'fat', 'Dry white queso seco', 'Queso seco blanco', 30.00, 1),
        ('MX', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', 'Almendras tostadas', 30.00, 2),
        ('MX', 'coconut_oil', 'fat', 'Coconut oil', 'Aceite de coco', 15.00, 3),

        ('BR', 'chicken_breast_skinless_boneless_cooked_braised', 'protein', 'Cooked chicken breast', 'Peito de frango cozido', 150.00, 1),
        ('BR', 'beef_tenderloin_lean_cooked_roasted', 'protein', 'Roasted lean beef tenderloin', 'Filé mignon magro assado', 150.00, 2),
        ('BR', 'yogurt_greek_plain_nonfat', 'protein', 'Plain nonfat Greek yogurt', 'Iogurte grego natural desnatado', 200.00, 3),
        ('BR', 'rice_flour_white_unenriched', 'carbs', 'White rice flour', 'Farinha de arroz branco', 50.00, 1),
        ('BR', 'cornmeal_yellow_fine_enriched', 'carbs', 'Fine yellow cornmeal', 'Fubá amarelo fino', 50.00, 2),
        ('BR', 'banana_ripe_raw', 'carbs', 'Ripe banana', 'Banana madura', 120.00, 3),
        ('BR', 'coconut_oil', 'fat', 'Coconut oil', 'Óleo de coco', 15.00, 1),
        ('BR', 'cheese_mozzarella_low_moisture_part_skim', 'fat', 'Part-skim mozzarella', 'Muçarela parcialmente desnatada', 50.00, 2),
        ('BR', 'almonds_dry_roasted_salted', 'fat', 'Roasted almonds', 'Amêndoas torradas', 30.00, 3)
) AS seed(country_code, slug, macro_role, display_name_en, display_name_local, serving_g, sort_order)
JOIN public.countries countries ON countries.country_code = seed.country_code
JOIN public.foods foods ON foods.slug = seed.slug
ON CONFLICT (country_code, food_id) DO UPDATE SET
    macro_role = EXCLUDED.macro_role,
    display_name_en = EXCLUDED.display_name_en,
    display_name_local = EXCLUDED.display_name_local,
    serving_g = EXCLUDED.serving_g,
    sort_order = EXCLUDED.sort_order,
    is_active = EXCLUDED.is_active;
