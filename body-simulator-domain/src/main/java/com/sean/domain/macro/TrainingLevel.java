package com.sean.domain.macro;

/**
 * 前端使用的每周训练时长档位，与 daily_macro_target_rules 的预置区间对应：
 * <ul>
 *     <li>1：数据库 {@code [0, 60)} 分钟（0～1 小时）</li>
 *     <li>2：数据库 {@code [120, 180)} 分钟（2～3 小时）</li>
 *     <li>3：数据库 {@code [240, 300)} 分钟（4～5 小时）</li>
 *     <li>4：数据库 {@code [360, 420)} 分钟（6～7 小时）</li>
 *     <li>5：数据库 {@code [480, NULL)} 分钟（8～9 小时及以上）</li>
 * </ul>
 * 数据库规则仍按分钟区间保存，领域层使用每档的区间下限查询规则。
 */
public enum TrainingLevel {
    /** 档位 1：0～1 小时，对应 training_minutes_min=0。 */
    LEVEL_1(1, 0),
    /** 档位 2：2～3 小时，对应 training_minutes_min=120。 */
    LEVEL_2(2, 120),
    /** 档位 3：4～5 小时，对应 training_minutes_min=240。 */
    LEVEL_3(3, 240),
    /** 档位 4：6～7 小时，对应 training_minutes_min=360。 */
    LEVEL_4(4, 360),
    /** 档位 5：8～9 小时及以上，对应 training_minutes_min=480。 */
    LEVEL_5(5, 480);

    private final int value;
    private final int weeklyTrainingMinutesStart;

    TrainingLevel(int value, int weeklyTrainingMinutesStart) {
        this.value = value;
        this.weeklyTrainingMinutesStart = weeklyTrainingMinutesStart;
    }

    public int getValue() {
        return value;
    }

    public int getWeeklyTrainingMinutesStart() {
        return weeklyTrainingMinutesStart;
    }

    public static TrainingLevel fromValue(int value) {
        for (TrainingLevel level : values()) {
            if (level.value == value) {
                return level;
            }
        }
        throw new IllegalArgumentException("trainingLevel must be between 1 and 5");
    }
}
