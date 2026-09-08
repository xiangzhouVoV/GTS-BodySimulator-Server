package com.sean.infra.db.postgres.repository;

import com.sean.infra.db.postgres.entity.CountryFoodRecommendationEntity;
import com.sean.infra.db.postgres.entity.CountryFoodRecommendationId;
import java.util.List;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/** country_food_recommendations 表的 JPA 查询仓储。 */
public interface CountryFoodRecommendationJpaRepository
        extends JpaRepository<CountryFoodRecommendationEntity, CountryFoodRecommendationId> {

    /** 随机查询国家和宏量栏目下的推荐食物。 */
    @Query("""
            select recommendation
            from CountryFoodRecommendationEntity recommendation
            join fetch recommendation.food food
            join recommendation.country country
            where recommendation.id.countryCode = :countryCode
              and recommendation.macroRole = :macroRole
              and country.active = true
            order by function('random')
            """)
    List<CountryFoodRecommendationEntity> findByCountryCodeAndMacroRole(
            @Param("countryCode") String countryCode,
            @Param("macroRole") String macroRole,
            Pageable pageable);
}
