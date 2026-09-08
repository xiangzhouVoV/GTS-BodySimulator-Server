package com.sean.domain.macro;

import java.math.BigDecimal;
import java.util.UUID;

/** 用于每日宏量目标页面展示的食物营养信息。所有营养数值均按每 100g 可食部分。 */
public record RecommendedFood(
        UUID id,
        String slug,
        String nameEn,
        String nameZh,
        String foodGroup,
        BigDecimal proteinG,
        BigDecimal carbsG,
        BigDecimal fatG,
        BigDecimal energyKcal,
        String remark) {
}
