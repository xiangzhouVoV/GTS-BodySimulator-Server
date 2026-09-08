import Decimal from "decimal.js";

const TRAINING_LEVEL_MINUTES: Record<number, number> = {
  1: 0,
  2: 120,
  3: 240,
  4: 360,
  5: 480,
};

export function parseMacroRequest(searchParams: URLSearchParams): {
  weightKg: Decimal;
  gender: "male" | "female";
  weeklyTrainingMinutes: number;
  countryCode: string;
} {
  const weightRaw = searchParams.get("weightKg");
  const genderRaw = searchParams.get("gender")?.toLowerCase();
  const trainingLevel = Number(searchParams.get("trainingLevel"));
  const countryRaw = searchParams.get("country");

  if (!weightRaw) {
    throw new Error("weightKg is required");
  }

  let weightKg: Decimal;
  try {
    weightKg = new Decimal(weightRaw);
  } catch {
    throw new Error("weightKg must be greater than zero");
  }
  if (!weightKg.isFinite() || weightKg.lte(0)) {
    throw new Error("weightKg must be greater than zero");
  }
  if (genderRaw !== "male" && genderRaw !== "female") {
    throw new Error("gender must be male or female");
  }
  if (!Number.isInteger(trainingLevel) || !(trainingLevel in TRAINING_LEVEL_MINUTES)) {
    throw new Error("trainingLevel must be between 1 and 5");
  }

  return {
    weightKg,
    gender: genderRaw,
    weeklyTrainingMinutes: TRAINING_LEVEL_MINUTES[trainingLevel],
    countryCode: countryRaw?.trim().toUpperCase() || "US",
  };
}

export function scaleForWeight(value: string, weightKg: Decimal): number {
  return new Decimal(value)
    .mul(weightKg)
    .div(100)
    .toDecimalPlaces(1, Decimal.ROUND_HALF_UP)
    .toNumber();
}
