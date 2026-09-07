package com.sean.adapter.api;

import com.sean.domain.macro.DailyMacroTarget;
import com.sean.domain.macro.DailyMacroTargetRequest;
import com.sean.domain.macro.DailyMacroTargetRuleNotFoundException;
import com.sean.domain.macro.DailyMacroTargetService;
import com.sean.domain.macro.Gender;
import com.sean.domain.macro.MacroRange;
import com.sean.domain.macro.TrainingLevel;
import java.math.BigDecimal;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

/** 每日蛋白质、碳水化合物及脂肪目标的 HTTP 入口。 */
@RestController
@RequestMapping("/api/daily-macro-target")
public class DailyMacroTargetController {

    private final DailyMacroTargetService service;

    public DailyMacroTargetController(DailyMacroTargetService service) {
        this.service = service;
    }

    /**
     * 按实际体重、性别与每周训练时长档位返回每日宏量营养素克数范围。
     *
     * @param weightKg 用户体重（kg），必须大于零
     * @param gender 性别，只能是 male 或 female
     * @param trainingLevel 每周训练时长档位，取值 1～5：1=0～1h，2=2～3h，
     *                      3=4～5h，4=6～7h，5=8～9h及以上；对应数据库分钟区间下限
     */
    @GetMapping
    public DailyMacroTargetResponse calculate(
            @RequestParam("weightKg") BigDecimal weightKg,
            @RequestParam("gender") String gender,
            @RequestParam("trainingLevel") int trainingLevel) {
        try {
            TrainingLevel level = TrainingLevel.fromValue(trainingLevel);
            DailyMacroTarget target = service.calculate(new DailyMacroTargetRequest(
                    Gender.fromValue(gender), weightKg, level.getWeeklyTrainingMinutesStart()));
            return DailyMacroTargetResponse.from(target);
        } catch (DailyMacroTargetRuleNotFoundException exception) {
            throw new ResponseStatusException(HttpStatus.UNPROCESSABLE_ENTITY, exception.getMessage(), exception);
        } catch (IllegalArgumentException exception) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, exception.getMessage(), exception);
        }
    }

    /** 每日宏量营养素目标响应。 */
    public record DailyMacroTargetResponse(
            MacroRangeResponse proteinG,
            MacroRangeResponse carbsG,
            MacroRangeResponse fatG) {

        private static DailyMacroTargetResponse from(DailyMacroTarget target) {
            return new DailyMacroTargetResponse(
                    MacroRangeResponse.from(target.proteinG()),
                    MacroRangeResponse.from(target.carbsG()),
                    MacroRangeResponse.from(target.fatG()));
        }
    }

    /** 单项宏量营养素的每日克数范围。 */
    public record MacroRangeResponse(BigDecimal min, BigDecimal max) {

        private static MacroRangeResponse from(MacroRange range) {
            return new MacroRangeResponse(range.min(), range.max());
        }
    }
}
