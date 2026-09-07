package com.sean.infra.db.postgres.repository;

import com.sean.infra.db.postgres.entity.DailyMacroTargetRuleEntity;
import com.sean.infra.db.postgres.entity.DailyMacroTargetRuleId;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/** daily_macro_target_rules 表的 JPA 查询仓储。 */
public interface DailyMacroTargetRuleJpaRepository
        extends JpaRepository<DailyMacroTargetRuleEntity, DailyMacroTargetRuleId> {

    @Query("""
            select rule
            from DailyMacroTargetRuleEntity rule
            where rule.id.gender = :gender
              and rule.id.trainingMinutesMin <= :weeklyTrainingMinutes
              and (rule.trainingMinutesMax is null or :weeklyTrainingMinutes < rule.trainingMinutesMax)
            """)
    Optional<DailyMacroTargetRuleEntity> findMatchingRule(
            @Param("gender") String gender,
            @Param("weeklyTrainingMinutes") int weeklyTrainingMinutes);
}
