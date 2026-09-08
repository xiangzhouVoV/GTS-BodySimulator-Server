package com.sean.adapter.config;

import com.sean.domain.macro.DailyMacroTargetService;
import com.sean.domain.macro.DailyMacroTargetWithRecommendedFoodsService;
import com.sean.domain.macro.port.CountryFoodRecommendationProvider;
import com.sean.domain.macro.port.DailyMacroTargetRuleProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/** 将宏量目标领域服务装配为 Spring Bean。 */
@Configuration
public class MacroTargetDomainConfig {

    @Bean
    DailyMacroTargetService dailyMacroTargetService(DailyMacroTargetRuleProvider ruleProvider) {
        return new DailyMacroTargetService(ruleProvider);
    }

    @Bean
    DailyMacroTargetWithRecommendedFoodsService dailyMacroTargetWithRecommendedFoodsService(
            DailyMacroTargetService targetService,
            CountryFoodRecommendationProvider recommendationProvider) {
        return new DailyMacroTargetWithRecommendedFoodsService(targetService, recommendationProvider);
    }
}
