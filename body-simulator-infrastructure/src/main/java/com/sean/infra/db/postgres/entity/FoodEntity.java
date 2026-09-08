package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.util.UUID;

/** Maps the public.foods table. Nutrition values are per 100g edible portion. */
@Entity
@Table(name = "foods", schema = "public")
public class FoodEntity {

    @Id
    @GeneratedValue
    @Column(name = "id", nullable = false, updatable = false)
    /** 食物 UUID 主键。 */
    private UUID id;

    @Column(name = "slug", nullable = false, unique = true)
    /** 稳定且唯一的程序标识，包含食物最终状态。 */
    private String slug;

    @Column(name = "name_en", nullable = false)
    /** 食物统一英文名称。 */
    private String nameEn;

    @Column(name = "name_zh")
    /** 面向中文用户展示的食物名称。 */
    private String nameZh;

    @Column(name = "food_group", nullable = false)
    /** 食物大类，例如 poultry、grain、legume、dairy。 */
    private String foodGroup;

    @Column(name = "protein_g", precision = 7, scale = 2, nullable = false)
    /** 每 100g 可食部分的蛋白质克数。 */
    private BigDecimal proteinG;

    @Column(name = "carbs_g", precision = 7, scale = 2, nullable = false)
    /** 每 100g 可食部分的碳水化合物克数。 */
    private BigDecimal carbsG;

    @Column(name = "fat_g", precision = 7, scale = 2, nullable = false)
    /** 每 100g 可食部分的脂肪克数。 */
    private BigDecimal fatG;

    @Column(name = "energy_kcal", precision = 7, scale = 2, nullable = false)
    /** 每 100g 可食部分的能量（千卡）。 */
    private BigDecimal energyKcal;

    @Column(name = "remark")
    /** 食物状态或展示用途的简短中文备注，不作为营养数据来源。 */
    private String remark;

    protected FoodEntity() {
        // Required by JPA.
    }

    public UUID getId() { return id; }
    public String getSlug() { return slug; }
    public String getNameEn() { return nameEn; }
    public String getNameZh() { return nameZh; }
    public String getFoodGroup() { return foodGroup; }
    public BigDecimal getProteinG() { return proteinG; }
    public BigDecimal getCarbsG() { return carbsG; }
    public BigDecimal getFatG() { return fatG; }
    public BigDecimal getEnergyKcal() { return energyKcal; }
    public String getRemark() { return remark; }
}
