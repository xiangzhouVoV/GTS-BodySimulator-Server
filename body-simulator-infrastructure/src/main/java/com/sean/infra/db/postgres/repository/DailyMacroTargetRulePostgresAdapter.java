package com.sean.infra.db.postgres.repository;

import com.sean.domain.macro.DailyMacroTargetRule;
import com.sean.domain.macro.Gender;
import com.sean.domain.macro.MacroRange;
import com.sean.domain.macro.port.DailyMacroTargetRuleProvider;
import com.sean.infra.db.postgres.entity.DailyMacroTargetRuleEntity;
import java.util.Optional;
import org.springframework.stereotype.Repository;

/** 使用 PostgreSQL 规则表实现每日宏量目标规则查询端口。 */
@Repository
public class DailyMacroTargetRulePostgresAdapter implements DailyMacroTargetRuleProvider {

    private final DailyMacroTargetRuleJpaRepository repository;

    public DailyMacroTargetRulePostgresAdapter(DailyMacroTargetRuleJpaRepository repository) {
        this.repository = repository;
    }

    @Override
    public Optional<DailyMacroTargetRule> findMatchingRule(Gender gender, int weeklyTrainingMinutes) {
        return repository.findMatchingRule(gender.getValue(), weeklyTrainingMinutes)
                .map(this::toDomain);
    }

    private DailyMacroTargetRule toDomain(DailyMacroTargetRuleEntity entity) {
        return new DailyMacroTargetRule(
                Gender.fromValue(entity.getGender()),
                entity.getTrainingMinutesMin(),
                entity.getTrainingMinutesMax(),
                new MacroRange(entity.getProteinGMin(), entity.getProteinGMax()),
                new MacroRange(entity.getCarbsGMin(), entity.getCarbsGMax()),
                new MacroRange(entity.getFatGMin(), entity.getFatGMax()));
    }
}
