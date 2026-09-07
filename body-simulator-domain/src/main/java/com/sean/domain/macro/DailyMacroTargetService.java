package com.sean.domain.macro;

import com.sean.domain.macro.port.DailyMacroTargetRuleProvider;

/** 根据用户体重、性别和每周训练时长计算每日宏量营养素目标。 */
public class DailyMacroTargetService {

    private final DailyMacroTargetRuleProvider ruleProvider;

    public DailyMacroTargetService(DailyMacroTargetRuleProvider ruleProvider) {
        this.ruleProvider = ruleProvider;
    }

    public DailyMacroTarget calculate(DailyMacroTargetRequest request) {
        DailyMacroTargetRule rule = ruleProvider
                .findMatchingRule(request.gender(), request.weeklyTrainingMinutes())
                .orElseThrow(() -> new DailyMacroTargetRuleNotFoundException(
                        request.gender(), request.weeklyTrainingMinutes()));

        return new DailyMacroTarget(
                rule.proteinG().scaleToWeight(request.weightKg()),
                rule.carbsG().scaleToWeight(request.weightKg()),
                rule.fatG().scaleToWeight(request.weightKg()));
    }
}
