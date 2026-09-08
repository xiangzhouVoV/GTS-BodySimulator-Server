package com.sean.domain.country;

import com.sean.domain.country.port.CountryProvider;
import java.util.List;

/** 国家列表查询领域服务。 */
public class CountryService {

    private final CountryProvider countryProvider;

    public CountryService(CountryProvider countryProvider) {
        this.countryProvider = countryProvider;
    }

    /** 返回已启用、可供用户选择的国家列表。 */
    public List<Country> listActiveCountries() {
        return countryProvider.findActiveCountries();
    }
}
