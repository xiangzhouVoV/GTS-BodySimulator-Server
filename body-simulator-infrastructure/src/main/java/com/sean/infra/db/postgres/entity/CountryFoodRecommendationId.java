package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

/** country_food_recommendations 表的复合主键。 */
@Embeddable
public class CountryFoodRecommendationId implements Serializable {

    /** 国家码。 */
    @Column(name = "country_code", length = 2, nullable = false)
    private String countryCode;

    /** 平台食物 UUID。 */
    @Column(name = "food_id", nullable = false)
    private UUID foodId;

    protected CountryFoodRecommendationId() {
        // Required by JPA.
    }

    public CountryFoodRecommendationId(String countryCode, UUID foodId) {
        this.countryCode = countryCode;
        this.foodId = foodId;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public UUID getFoodId() {
        return foodId;
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof CountryFoodRecommendationId that)) {
            return false;
        }
        return Objects.equals(countryCode, that.countryCode)
                && Objects.equals(foodId, that.foodId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(countryCode, foodId);
    }
}
