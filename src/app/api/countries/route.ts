import { NextResponse } from "next/server";

import { withDatabase } from "@/lib/database";
import { errorResponse } from "@/lib/http";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

type CountryRow = {
  code: string;
  nameEn: string;
  nameLocal: string;
  locale: string;
};

export async function GET(): Promise<NextResponse> {
  try {
    const { rows } = await withDatabase((database) => database.query<CountryRow>(`
        SELECT
          country_code AS "code",
          name_en AS "nameEn",
          name_local AS "nameLocal",
          locale
        FROM public.countries
        WHERE is_active = TRUE
        ORDER BY name_en ASC
      `));

    return NextResponse.json(
      rows.map((country) => ({
        ...country,
        flagUrl: `https://flagcdn.com/${country.code.toLowerCase()}.svg`,
      })),
    );
  } catch (error) {
    console.error("Unable to load countries", error);
    return errorResponse("Unable to load countries", 500);
  }
}
