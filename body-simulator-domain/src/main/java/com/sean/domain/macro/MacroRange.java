package com.sean.domain.macro;

import java.math.BigDecimal;
import java.math.RoundingMode;

/** 宏量营养素的每日克数范围。 */
public record MacroRange(BigDecimal min, BigDecimal max) {

    public MacroRange {
        if (min == null || max == null || min.signum() < 0 || max.compareTo(min) < 0) {
            throw new IllegalArgumentException("macro range is invalid");
        }
    }

    /** 将 100kg 预置范围按实际体重换算为每日克数，保留一位小数。 */
    public MacroRange scaleToWeight(BigDecimal weightKg) {
        return new MacroRange(scale(min, weightKg), scale(max, weightKg));
    }

    private static BigDecimal scale(BigDecimal value, BigDecimal weightKg) {
        return value.multiply(weightKg)
                .movePointLeft(2)
                .setScale(1, RoundingMode.HALF_UP);
    }
}
