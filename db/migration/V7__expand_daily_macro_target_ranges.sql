-- 已执行 V6 的数据库修正：在原有预置边界上增加约 ±10% 浮动。
-- 对已有女性碳水区间，下限乘 0.9、上限乘 1.1；其余单点值同样扩展为 90%～110%。

UPDATE public.daily_macro_target_rules
SET
    protein_g_min = ROUND(protein_g_min * 0.9, 1),
    protein_g_max = ROUND(protein_g_max * 1.1, 1),
    carbs_g_min = ROUND(carbs_g_min * 0.9, 1),
    carbs_g_max = ROUND(carbs_g_max * 1.1, 1),
    fat_g_min = ROUND(fat_g_min * 0.9, 1),
    fat_g_max = ROUND(fat_g_max * 1.1, 1)
WHERE gender IN ('male', 'female')
  AND training_minutes_min IN (0, 60, 120, 180, 240, 300, 360, 420, 480);
