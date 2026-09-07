package com.sean.domain.macro;

import java.math.BigDecimal;

/** 每日宏量营养素目标计算的输入参数。 */
public record DailyMacroTargetRequest(Gender gender, BigDecimal weightKg, int weeklyTrainingMinutes) {

    public DailyMacroTargetRequest {
        if (gender == null) {
            throw new IllegalArgumentException("gender is required");
        }
        if (weightKg == null || weightKg.signum() <= 0) {
            throw new IllegalArgumentException("weightKg must be greater than zero");
        }
        if (weeklyTrainingMinutes < 0 || weeklyTrainingMinutes > 540) {
            throw new IllegalArgumentException("weeklyTrainingMinutes must be between 0 and 540");
        }
    }
}
