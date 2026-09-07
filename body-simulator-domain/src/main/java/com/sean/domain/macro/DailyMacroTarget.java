package com.sean.domain.macro;

/** 按用户实际体重计算后的每日宏量营养素目标范围。 */
public record DailyMacroTarget(MacroRange proteinG, MacroRange carbsG, MacroRange fatG) {
}
