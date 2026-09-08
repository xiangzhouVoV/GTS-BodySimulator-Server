package com.sean.infra.db.postgres.repository;

import com.sean.domain.macro.FoodMacroRole;
import com.sean.domain.macro.RecommendedFood;
import com.sean.domain.macro.port.CountryFoodRecommendationProvider;
import com.sean.infra.db.postgres.entity.CountryFoodRecommendationEntity;
import com.sean.infra.db.postgres.entity.FoodEntity;
import java.util.List;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Repository;

/** 使用 PostgreSQL 查询国家食物推荐的领域端口实现。 */
@Repository
public class CountryFoodRecommendationPostgresAdapter
        implements CountryFoodRecommendationProvider {

    private final CountryFoodRecommendationJpaRepository repository;

    public CountryFoodRecommendationPostgresAdapter(
            CountryFoodRecommendationJpaRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<RecommendedFood> findTopByCountryAndMacroRole(
            String countryCode, FoodMacroRole macroRole, int limit) {
        if (limit <= 0) {
            return List.of();
        }

        return repository.findByCountryCodeAndMacroRole(
                        countryCode, macroRole.getValue(), PageRequest.of(0, limit))
                .stream()
                .map(this::toDomain)
                .toList();
    }

    private RecommendedFood toDomain(CountryFoodRecommendationEntity recommendation) {
        FoodEntity food = recommendation.getFood();
        return new RecommendedFood(
                food.getId(),
                food.getSlug(),
                food.getNameEn(),
                food.getNameZh(),
                food.getFoodGroup(),
                food.getProteinG(),
                food.getCarbsG(),
                food.getFatG(),
                food.getEnergyKcal(),
                food.getRemark());
    }
}
