package com.sean.infra.db.postgres.repository;

import com.sean.domain.country.Country;
import com.sean.domain.country.port.CountryProvider;
import java.util.List;
import org.springframework.stereotype.Repository;

/** 使用 PostgreSQL countries 表实现国家查询端口。 */
@Repository
public class CountryPostgresAdapter implements CountryProvider {

    private final CountryJpaRepository repository;

    public CountryPostgresAdapter(CountryJpaRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Country> findActiveCountries() {
        return repository.findByActiveTrueOrderByNameEnAsc().stream()
                .map(country -> new Country(
                        country.getCountryCode(),
                        country.getNameEn(),
                        country.getNameLocal(),
                        country.getLocale()))
                .toList();
    }
}
