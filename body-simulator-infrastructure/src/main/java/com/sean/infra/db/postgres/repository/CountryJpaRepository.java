package com.sean.infra.db.postgres.repository;

import com.sean.infra.db.postgres.entity.CountryEntity;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/** countries 表的 JPA 查询仓储。 */
public interface CountryJpaRepository extends JpaRepository<CountryEntity, String> {

    /** 按英文名称升序返回已启用国家。 */
    List<CountryEntity> findByActiveTrueOrderByNameEnAsc();
}
