package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

/** daily_macro_target_rules 表的复合主键。 */
@Embeddable
public class DailyMacroTargetRuleId implements Serializable {

    /** 性别：male 或 female。 */
    @Column(name = "gender", nullable = false)
    private String gender;

    /** 每周训练分钟数区间下限（包含）。 */
    @Column(name = "training_minutes_min", nullable = false)
    private int trainingMinutesMin;

    protected DailyMacroTargetRuleId() {
        // Required by JPA.
    }

    public DailyMacroTargetRuleId(String gender, int trainingMinutesMin) {
        this.gender = gender;
        this.trainingMinutesMin = trainingMinutesMin;
    }

    public String getGender() {
        return gender;
    }

    public int getTrainingMinutesMin() {
        return trainingMinutesMin;
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof DailyMacroTargetRuleId that)) {
            return false;
        }
        return trainingMinutesMin == that.trainingMinutesMin
                && Objects.equals(gender, that.gender);
    }

    @Override
    public int hashCode() {
        return Objects.hash(gender, trainingMinutesMin);
    }
}
