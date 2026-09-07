package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;

/**
 * 按性别和每周训练时长配置的每日宏量营养素目标范围。
 *
 * <p>表中的克数以体重 100kg 为预设基准；应用层须按用户实际体重等比例换算。</p>
 */
@Entity
@Table(name = "daily_macro_target_rules", schema = "public")
public class DailyMacroTargetRuleEntity {

    /** 性别与每周训练分钟数下限组成的复合主键。 */
    @EmbeddedId
    private DailyMacroTargetRuleId id;

    /** 每周训练分钟数区间上限（不包含）；为空表示无上限。 */
    @Column(name = "training_minutes_max")
    private Integer trainingMinutesMax;

    /** 体重 100kg 基准下的每日蛋白质目标下限，单位为克。 */
    @Column(name = "protein_g_min", precision = 6, scale = 1, nullable = false)
    private BigDecimal proteinGMin;

    /** 体重 100kg 基准下的每日蛋白质目标上限，单位为克。 */
    @Column(name = "protein_g_max", precision = 6, scale = 1, nullable = false)
    private BigDecimal proteinGMax;

    /** 体重 100kg 基准下的每日碳水化合物目标下限，单位为克。 */
    @Column(name = "carbs_g_min", precision = 6, scale = 1, nullable = false)
    private BigDecimal carbsGMin;

    /** 体重 100kg 基准下的每日碳水化合物目标上限，单位为克。 */
    @Column(name = "carbs_g_max", precision = 6, scale = 1, nullable = false)
    private BigDecimal carbsGMax;

    /** 体重 100kg 基准下的每日脂肪目标下限，单位为克。 */
    @Column(name = "fat_g_min", precision = 6, scale = 1, nullable = false)
    private BigDecimal fatGMin;

    /** 体重 100kg 基准下的每日脂肪目标上限，单位为克。 */
    @Column(name = "fat_g_max", precision = 6, scale = 1, nullable = false)
    private BigDecimal fatGMax;

    protected DailyMacroTargetRuleEntity() {
        // Required by JPA.
    }

    public DailyMacroTargetRuleId getId() {
        return id;
    }

    public String getGender() {
        return id == null ? null : id.getGender();
    }

    public int getTrainingMinutesMin() {
        return id.getTrainingMinutesMin();
    }

    public Integer getTrainingMinutesMax() {
        return trainingMinutesMax;
    }

    public BigDecimal getProteinGMin() {
        return proteinGMin;
    }

    public BigDecimal getProteinGMax() {
        return proteinGMax;
    }

    public BigDecimal getCarbsGMin() {
        return carbsGMin;
    }

    public BigDecimal getCarbsGMax() {
        return carbsGMax;
    }

    public BigDecimal getFatGMin() {
        return fatGMin;
    }

    public BigDecimal getFatGMax() {
        return fatGMax;
    }
}
