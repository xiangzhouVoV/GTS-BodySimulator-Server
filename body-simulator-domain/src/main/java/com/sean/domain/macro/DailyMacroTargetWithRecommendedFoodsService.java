package com.sean.domain.macro;

import com.sean.domain.macro.port.CountryFoodRecommendationProvider;
import java.util.List;
import java.util.Locale;

/** 计算每日宏量目标，并提供指定国家的食物推荐。 */
public class DailyMacroTargetWithRecommendedFoodsService {

    private static final String DEFAULT_COUNTRY_CODE = "US";
    private static final int FOODS_PER_MACRO_ROLE = 3;

    private final DailyMacroTargetService targetService;
    private final CountryFoodRecommendationProvider recommendationProvider;

    public DailyMacroTargetWithRecommendedFoodsService(
            DailyMacroTargetService targetService,
            CountryFoodRecommendationProvider recommendationProvider) {
        this.targetService = targetService;
        this.recommendationProvider = recommendationProvider;
    }

    /**
     * 返回每日目标与指定国家食物库中每个宏量栏目随机的三种推荐食物。
     *
     * <p>国家码无效、未启用或未配置完整推荐数据时，自动回退至美国。</p>
     */
    public DailyMacroTargetWithRecommendedFoods calculate(
            DailyMacroTargetRequest request, String requestedCountryCode) {
        String countryCode = normalizeCountryCode(requestedCountryCode);
        RecommendedFoods recommendedFoods = findRecommendedFoods(countryCode);
        if (!recommendedFoods.isComplete()) {
            countryCode = DEFAULT_COUNTRY_CODE;
            recommendedFoods = findRecommendedFoods(countryCode);
        }

        return new DailyMacroTargetWithRecommendedFoods(
                targetService.calculate(request),
                countryCode,
                recommendedFoods.proteinFoods(),
                recommendedFoods.carbsFoods(),
                recommendedFoods.fatFoods());
    }

    private RecommendedFoods findRecommendedFoods(String countryCode) {
        return new RecommendedFoods(
                recommendationProvider.findTopByCountryAndMacroRole(
                        countryCode, FoodMacroRole.PROTEIN, FOODS_PER_MACRO_ROLE),
                recommendationProvider.findTopByCountryAndMacroRole(
                        countryCode, FoodMacroRole.CARBS, FOODS_PER_MACRO_ROLE),
                recommendationProvider.findTopByCountryAndMacroRole(
                        countryCode, FoodMacroRole.FAT, FOODS_PER_MACRO_ROLE));
    }

    private String normalizeCountryCode(String countryCode) {
        if (countryCode == null || countryCode.isBlank()) {
            return DEFAULT_COUNTRY_CODE;
        }
        return countryCode.trim().toUpperCase(Locale.ROOT);
    }

    private record RecommendedFoods(
            List<RecommendedFood> proteinFoods,
            List<RecommendedFood> carbsFoods,
            List<RecommendedFood> fatFoods) {

        private boolean isComplete() {
            return proteinFoods.size() == FOODS_PER_MACRO_ROLE
                    && carbsFoods.size() == FOODS_PER_MACRO_ROLE
                    && fatFoods.size() == FOODS_PER_MACRO_ROLE;
        }
    }
}
