package com.sean.domain.macro;

/** 食物在推荐列表中的主宏量营养素展示分类。 */
public enum FoodMacroRole {
    PROTEIN("protein"),
    CARBS("carbs"),
    FAT("fat");

    private final String value;

    FoodMacroRole(String value) {
        this.value = value;
    }

    /** 返回数据库中存储的分类值。 */
    public String getValue() {
        return value;
    }
}
