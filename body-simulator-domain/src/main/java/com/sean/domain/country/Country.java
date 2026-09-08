package com.sean.domain.country;

/** 可在客户端选择的国家或地区。 */
public record Country(String code, String nameEn, String nameLocal, String locale) {
}
