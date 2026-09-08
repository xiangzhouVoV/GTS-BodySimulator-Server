package com.sean.domain.country.port;

import com.sean.domain.country.Country;
import java.util.List;

/** 查询可展示国家的领域端口。 */
public interface CountryProvider {

    List<Country> findActiveCountries();
}
