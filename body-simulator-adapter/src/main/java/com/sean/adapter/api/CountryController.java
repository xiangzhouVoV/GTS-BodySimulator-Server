package com.sean.adapter.api;

import com.sean.domain.country.Country;
import com.sean.domain.country.CountryService;
import java.util.List;
import java.util.Locale;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/** 可供 Macro Calculator 选择的国家列表 HTTP 入口。 */
@RestController
@RequestMapping("/api/countries")
public class CountryController {

    private static final String FLAG_CDN_URL_TEMPLATE = "https://flagcdn.com/%s.svg";

    private final CountryService countryService;

    public CountryController(CountryService countryService) {
        this.countryService = countryService;
    }

    /**
     * 返回所有已启用国家，以及由 ISO 两位码生成的 SVG 国旗地址。
     *
     * <p>服务端不下载、存储或代理国旗图片，前端可直接使用 flagUrl 渲染并利用 CDN 缓存。</p>
     */
    @GetMapping
    public List<CountryResponse> listCountries() {
        return countryService.listActiveCountries().stream()
                .map(CountryResponse::from)
                .toList();
    }

    /** 单个国家的 API 响应。 */
    public record CountryResponse(
            String code,
            String nameEn,
            String nameLocal,
            String locale,
            String flagUrl) {

        private static CountryResponse from(Country country) {
            return new CountryResponse(
                    country.code(),
                    country.nameEn(),
                    country.nameLocal(),
                    country.locale(),
                    FLAG_CDN_URL_TEMPLATE.formatted(country.code().toLowerCase(Locale.ROOT)));
        }
    }
}
