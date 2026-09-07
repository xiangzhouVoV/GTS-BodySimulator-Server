package com.sean.domain.macro;

/** 支持计算每日宏量营养素目标的生理性别。 */
public enum Gender {
    MALE("male"),
    FEMALE("female");

    private final String value;

    Gender(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    /** 将 API 传入的值转换为领域枚举。 */
    public static Gender fromValue(String value) {
        for (Gender gender : values()) {
            if (gender.value.equalsIgnoreCase(value)) {
                return gender;
            }
        }
        throw new IllegalArgumentException("gender must be male or female");
    }
}
