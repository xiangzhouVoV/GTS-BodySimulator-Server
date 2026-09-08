package com.sean.domain.macro;

import java.util.List;

/** 每日宏量营养素目标及按栏目推荐的食物。 */
public record DailyMacroTargetWithRecommendedFoods(
        DailyMacroTarget target,
        String countryCode,
        List<RecommendedFood> proteinFoods,
        List<RecommendedFood> carbsFoods,
        List<RecommendedFood> fatFoods) {

    public DailyMacroTargetWithRecommendedFoods {
        proteinFoods = List.copyOf(proteinFoods);
        carbsFoods = List.copyOf(carbsFoods);
        fatFoods = List.copyOf(fatFoods);
    }
}
