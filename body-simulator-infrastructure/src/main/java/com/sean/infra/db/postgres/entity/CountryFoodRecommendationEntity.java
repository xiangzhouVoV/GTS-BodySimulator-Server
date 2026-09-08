package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;

/** 国家常见食物与主宏量营养素展示栏目的映射。 */
@Entity
@Table(name = "country_food_recommendations", schema = "public")
public class CountryFoodRecommendationEntity {

    /** 国家与食物组成的复合主键。 */
    @EmbeddedId
    private CountryFoodRecommendationId id;

    /** 该食物所属国家。 */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @MapsId("countryCode")
    @JoinColumn(name = "country_code", nullable = false)
    private CountryEntity country;

    /** 被标记为该国家常见食物的平台食物记录。 */
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @MapsId("foodId")
    @JoinColumn(name = "food_id", nullable = false)
    private FoodEntity food;

    /** 前端主展示分类：protein、carbs 或 fat。食物仍保留完整三大营养素。 */
    @Column(name = "macro_role", nullable = false)
    private String macroRole;

    protected CountryFoodRecommendationEntity() {
        // Required by JPA.
    }

    public CountryFoodRecommendationId getId() {
        return id;
    }

    public CountryEntity getCountry() {
        return country;
    }

    public FoodEntity getFood() {
        return food;
    }

    public String getMacroRole() {
        return macroRole;
    }
}
