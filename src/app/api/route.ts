import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
    return NextResponse.json({
      success: true,
      message: "API Tim Konten & Brand Ambassador SMK Telkom Purwokerto",
    });
}
