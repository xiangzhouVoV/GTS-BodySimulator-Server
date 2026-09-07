package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

/** Composite key for public.country_food_recommendations. */
@Embeddable
public class CountryFoodRecommendationId implements Serializable {

    @Column(name = "country_code", length = 2, nullable = false)
    /** 推荐所属国家码。 */
    private String countryCode;

    @Column(name = "food_id", nullable = false)
    /** 被推荐食物的 UUID。 */
    private UUID foodId;

    protected CountryFoodRecommendationId() {
        // Required by JPA.
    }

    public CountryFoodRecommendationId(String countryCode, UUID foodId) {
        this.countryCode = countryCode;
        this.foodId = foodId;
    }

    public String getCountryCode() { return countryCode; }
    public UUID getFoodId() { return foodId; }

    @Override
    public boolean equals(Object other) {
        if (this == other) return true;
        if (!(other instanceof CountryFoodRecommendationId that)) return false;
        return Objects.equals(countryCode, that.countryCode)
                && Objects.equals(foodId, that.foodId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(countryCode, foodId);
    }
}
