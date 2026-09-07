package com.sean.domain.macro;

/** 输入参数未匹配到宏量目标规则时抛出。 */
public class DailyMacroTargetRuleNotFoundException extends RuntimeException {

    public DailyMacroTargetRuleNotFoundException(Gender gender, int weeklyTrainingMinutes) {
        super("No macro target rule for gender=%s, weeklyTrainingMinutes=%d"
                .formatted(gender.getValue(), weeklyTrainingMinutes));
    }
}
