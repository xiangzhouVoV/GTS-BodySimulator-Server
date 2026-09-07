package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.OffsetDateTime;

/** Maps the country-specific display mapping for a food. */
@Entity
@Table(name = "country_food_recommendations", schema = "public")
public class CountryFoodRecommendationEntity {

    @EmbeddedId
    /** 国家和食物组成的复合主键。 */
    private CountryFoodRecommendationId id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @MapsId("countryCode")
    @JoinColumn(name = "country_code", nullable = false)
    /** 推荐所属国家。 */
    private CountryEntity country;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @MapsId("foodId")
    @JoinColumn(name = "food_id", nullable = false)
    /** 被推荐的统一食物记录。 */
    private FoodEntity food;

    @Column(name = "macro_role", nullable = false)
    /** 页面展示栏目：protein、carbs 或 fat。 */
    private String macroRole;

    @Column(name = "display_name_en", nullable = false)
    /** 面向该国家用户展示的英文名称。 */
    private String displayNameEn;

    @Column(name = "display_name_local", nullable = false)
    /** 面向该国家用户展示的当地语言名称。 */
    private String displayNameLocal;

    @Column(name = "serving_g", precision = 7, scale = 2, nullable = false)
    /** 建议单份重量（克），不改变每 100g 营养事实。 */
    private BigDecimal servingG;

    @Column(name = "sort_order", nullable = false)
    /** 同一国家、同一栏目内的升序展示顺序。 */
    private int sortOrder;

    @Column(name = "is_active", nullable = false)
    /** 是否在公开推荐列表中展示。 */
    private boolean active = true;

    @Column(name = "created_at", nullable = false, updatable = false)
    /** 记录创建时间（UTC）。 */
    private OffsetDateTime createdAt;

    protected CountryFoodRecommendationEntity() {
        // Required by JPA.
    }

    public CountryFoodRecommendationId getId() { return id; }
    public CountryEntity getCountry() { return country; }
    public FoodEntity getFood() { return food; }
    public String getMacroRole() { return macroRole; }
    public String getDisplayNameEn() { return displayNameEn; }
    public String getDisplayNameLocal() { return displayNameLocal; }
    public BigDecimal getServingG() { return servingG; }
    public int getSortOrder() { return sortOrder; }
    public boolean isActive() { return active; }
    public OffsetDateTime getCreatedAt() { return createdAt; }
}
