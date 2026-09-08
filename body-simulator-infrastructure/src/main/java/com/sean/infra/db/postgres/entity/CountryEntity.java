package com.sean.infra.db.postgres.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/** Maps the public.countries table. */
@Entity
@Table(name = "countries", schema = "public")
public class CountryEntity {

    @Id
    @Column(name = "country_code", length = 2, nullable = false, updatable = false)
    /** ISO 3166-1 alpha-2 两位大写国家码。 */
    private String countryCode;

    @Column(name = "name_en", nullable = false)
    /** 国家英文名称。 */
    private String nameEn;

    @Column(name = "name_local", nullable = false)
    /** 国家当地语言名称。 */
    private String nameLocal;

    @Column(name = "locale", nullable = false)
    /** 默认展示语言区域，例如 zh-CN、en-US。 */
    private String locale;

    @Column(name = "is_active", nullable = false)
    /** 是否在国家选择器和公开接口中展示。 */
    private boolean active = true;

    protected CountryEntity() {
        // Required by JPA.
    }

    public CountryEntity(String countryCode, String nameEn, String nameLocal, String locale) {
        this.countryCode = countryCode;
        this.nameEn = nameEn;
        this.nameLocal = nameLocal;
        this.locale = locale;
    }

    public String getCountryCode() { return countryCode; }
    public String getNameEn() { return nameEn; }
    public String getNameLocal() { return nameLocal; }
    public String getLocale() { return locale; }
    public boolean isActive() { return active; }
}
