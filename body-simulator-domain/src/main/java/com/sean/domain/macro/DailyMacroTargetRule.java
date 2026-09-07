package com.sean.domain.macro;

/** 按性别和每周训练分钟数匹配的 100kg 基准宏量目标规则。 */
public record DailyMacroTargetRule(
        Gender gender,
        int trainingMinutesMin,
        Integer trainingMinutesMax,
        MacroRange proteinG,
        MacroRange carbsG,
        MacroRange fatG) {

    public DailyMacroTargetRule {
        if (trainingMinutesMin < 0
                || (trainingMinutesMax != null && trainingMinutesMax <= trainingMinutesMin)) {
            throw new IllegalArgumentException("training minutes range is invalid");
        }
    }

    /** 判断每周训练分钟数是否属于左闭右开的规则区间。 */
    public boolean matches(int weeklyTrainingMinutes) {
        return weeklyTrainingMinutes >= trainingMinutesMin
                && (trainingMinutesMax == null || weeklyTrainingMinutes < trainingMinutesMax);
    }
}
