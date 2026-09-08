package com.sean.adapter.config;

import com.sean.domain.country.CountryService;
import com.sean.domain.country.port.CountryProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/** 将国家列表领域服务装配为 Spring Bean。 */
@Configuration
public class CountryDomainConfig {

    @Bean
    CountryService countryService(CountryProvider countryProvider) {
        return new CountryService(countryProvider);
    }
}
