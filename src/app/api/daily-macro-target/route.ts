import { NextRequest, NextResponse } from "next/server";

import { getDatabase } from "@/lib/database";
import { errorResponse } from "@/lib/http";
import { parseMacroRequest, scaleForWeight } from "@/lib/macro";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

const FOODS_PER_MACRO_ROLE = 3;
const DEFAULT_COUNTRY_CODE = "US";
const MACRO_ROLES = ["protein", "carbs", "fat"] as const;

type MacroRole = (typeof MACRO_ROLES)[number];

type RuleRow = {
  proteinMin: string;
  proteinMax: string;
  carbsMin: string;
  carbsMax: string;
  fatMin: string;
  fatMax: string;
};

type FoodRow = {
  id: string;
  slug: string;
  nameEn: string;
  nameZh: string | null;
  foodGroup: string;
  proteinG: string;
  carbsG: string;
  fatG: string;
  energyKcal: string;
};

type FoodResponse = Omit<FoodRow, "nameZh" | "proteinG" | "carbsG" | "fatG" | "energyKcal"> & {
  displayName: string;
  nameZh: string | null;
  proteinG: number;
  carbsG: number;
  fatG: number;
  energyKcal: number;
};

async function findRule(gender: "male" | "female", weeklyTrainingMinutes: number) {
  const { rows } = await getDatabase().query<RuleRow>(
    `
      SELECT
        protein_g_min::text AS "proteinMin",
        protein_g_max::text AS "proteinMax",
        carbs_g_min::text AS "carbsMin",
        carbs_g_max::text AS "carbsMax",
        fat_g_min::text AS "fatMin",
        fat_g_max::text AS "fatMax"
      FROM public.daily_macro_target_rules
      WHERE gender = $1
        AND training_minutes_min <= $2
        AND (training_minutes_max IS NULL OR $2 < training_minutes_max)
      LIMIT 1
    `,
    [gender, weeklyTrainingMinutes],
  );
  return rows[0];
}

async function recommendedFoods(countryCode: string, macroRole: MacroRole): Promise<FoodResponse[]> {
  const { rows } = await getDatabase().query<FoodRow>(
    `
      SELECT
        food.id::text AS "id",
        food.slug,
        food.name_en AS "nameEn",
        food.name_zh AS "nameZh",
        food.food_group AS "foodGroup",
        food.protein_g::text AS "proteinG",
        food.carbs_g::text AS "carbsG",
        food.fat_g::text AS "fatG",
        food.energy_kcal::text AS "energyKcal"
      FROM public.country_food_recommendations recommendation
      JOIN public.countries country ON country.country_code = recommendation.country_code
      JOIN public.foods food ON food.id = recommendation.food_id
      WHERE recommendation.country_code = $1
        AND recommendation.macro_role = $2
        AND country.is_active = TRUE
      ORDER BY random()
      LIMIT $3
    `,
    [countryCode, macroRole, FOODS_PER_MACRO_ROLE],
  );

  return rows.map((food) => ({
    ...food,
    displayName: food.nameZh?.trim() || food.nameEn,
    proteinG: Number(food.proteinG),
    carbsG: Number(food.carbsG),
    fatG: Number(food.fatG),
    energyKcal: Number(food.energyKcal),
  }));
}

async function findAllRecommendedFoods(countryCode: string) {
  const [protein, carbs, fat] = await Promise.all(
    MACRO_ROLES.map((role) => recommendedFoods(countryCode, role)),
  );
  return { protein, carbs, fat };
}

function areRecommendationsComplete(foods: Awaited<ReturnType<typeof findAllRecommendedFoods>>): boolean {
  return MACRO_ROLES.every((role) => foods[role].length === FOODS_PER_MACRO_ROLE);
}

export async function GET(request: NextRequest): Promise<NextResponse> {
  let input: ReturnType<typeof parseMacroRequest>;
  try {
    input = parseMacroRequest(request.nextUrl.searchParams);
  } catch (error) {
    return errorResponse(error instanceof Error ? error.message : "Invalid request", 400);
  }

  try {
    const [rule, requestedFoods] = await Promise.all([
      findRule(input.gender, input.weeklyTrainingMinutes),
      findAllRecommendedFoods(input.countryCode),
    ]);

    if (!rule) {
      return errorResponse("No daily macro target rule matches this request", 422);
    }

    const countryCode = areRecommendationsComplete(requestedFoods)
      ? input.countryCode
      : DEFAULT_COUNTRY_CODE;
    const foods = countryCode === input.countryCode
      ? requestedFoods
      : await findAllRecommendedFoods(countryCode);

    return NextResponse.json({
      proteinG: {
        min: scaleForWeight(rule.proteinMin, input.weightKg),
        max: scaleForWeight(rule.proteinMax, input.weightKg),
      },
      carbsG: {
        min: scaleForWeight(rule.carbsMin, input.weightKg),
        max: scaleForWeight(rule.carbsMax, input.weightKg),
      },
      fatG: {
        min: scaleForWeight(rule.fatMin, input.weightKg),
        max: scaleForWeight(rule.fatMax, input.weightKg),
      },
      recommendedFoods: {
        countryCode,
        ...foods,
      },
    });
  } catch (error) {
    console.error("Unable to calculate daily macro target", error);
    return errorResponse("Unable to calculate daily macro target", 500);
  }
}
