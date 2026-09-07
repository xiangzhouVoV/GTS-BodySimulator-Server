package com.sean.domain.macro.port;

import com.sean.domain.macro.DailyMacroTargetRule;
import com.sean.domain.macro.Gender;
import java.util.Optional;

/** 获取每日宏量营养素目标规则的领域端口。 */
public interface DailyMacroTargetRuleProvider {

    Optional<DailyMacroTargetRule> findMatchingRule(Gender gender, int weeklyTrainingMinutes);
}
