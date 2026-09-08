package com.sean.domain.macro.port;

import com.sean.domain.macro.FoodMacroRole;
import com.sean.domain.macro.RecommendedFood;
import java.util.List;

/** 查询指定国家的系统维护食物推荐。 */
public interface CountryFoodRecommendationProvider {

    /**
     * 返回指定国家、指定宏量栏目中最多 limit 种食物。
     *
     * @param countryCode ISO 3166-1 alpha-2 国家码
     * @param macroRole 食物主展示栏目
     * @param limit 返回数量上限
     */
    List<RecommendedFood> findTopByCountryAndMacroRole(
            String countryCode, FoodMacroRole macroRole, int limit);
}
