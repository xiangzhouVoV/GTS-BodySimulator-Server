import { NextResponse } from "next/server";

import { getDatabase } from "@/lib/database";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

export async function GET(): Promise<NextResponse> {
  try {
    await getDatabase().query("SELECT 1");
    return NextResponse.json({ status: "UP" });
  } catch (error) {
    console.error("Health check failed", error);
    return NextResponse.json({ status: "DOWN" }, { status: 503 });
  }
}
