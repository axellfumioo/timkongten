// app/api/activity-log/route.ts
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { authOptions } from "@/app/lib/authOptions";
import { query } from "@/app/lib/postgres";

// Helper function to fetch data
async function fetchData(
  search: string,
  type: string,
  page: number,
  pageSize: number
) {
  const offset = (page - 1) * pageSize;

  const clauses: string[] = [];
  const params: any[] = [];

  if (search) {
    const safeSearch = search.replace(/[%_\\]/g, "\\$&").substring(0, 50);
    const searchTerm = `%${safeSearch}%`;
    clauses.push(
      "(user_name ILIKE $1 ESCAPE '\\' OR activity_name ILIKE $1 ESCAPE '\\' OR activity_message ILIKE $1 ESCAPE '\\')"
    );
    params.push(searchTerm);
  }

  if (type) {
    clauses.push(`activity_type = $${params.length + 1}`);
    params.push(type);
  }

  const whereSql = clauses.length > 0 ? `WHERE ${clauses.join(" AND ")}` : "";

  const countResult = await query<{ count: string }>(
    `SELECT COUNT(*) as count FROM activity_logs ${whereSql}`,
    params
  );

  const total = Number(countResult.rows[0]?.count ?? 0);

  const dataParams = [...params, pageSize, offset];
  const dataResult = await query(
    `SELECT user_email, user_name, activity_type, activity_name, activity_message, activity_date FROM activity_logs ${whereSql} ORDER BY activity_date DESC LIMIT $${params.length + 1} OFFSET $${params.length + 2}`,
    dataParams
  );

  return {
    success: true,
    data: dataResult.rows,
    pagination: {
      page,
      pageSize,
      total,
      totalPages: Math.ceil(total / pageSize),
    },
  };
}

// POST - Insert activity log
export async function POST(req: NextRequest) {
  if (req.headers.get("x-api-key") !== process.env.INTERNAL_API_KEY) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const {
    user_email,
    user_name,
    activity_type,
    activity_name,
    activity_message,
    activity_method,
    activity_url,
    activity_agent,
  } = body;

  const timestamp = new Date().toISOString();

  try {
    // Insert the new activity log
    const result = await query(
      "INSERT INTO activity_logs (user_email, user_name, activity_type, activity_name, activity_message, activity_url, activity_agent, activity_method, activity_date) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING id",
      [
        user_email,
        user_name,
        activity_type,
        activity_name,
        activity_message,
        activity_url,
        activity_agent,
        activity_method,
        timestamp,
      ]
    );

    return NextResponse.json(
      { success: true, data: result.rows },
      { status: 201 }
    );
  } catch (err) {
    console.error("Unexpected error:", err);
    return NextResponse.json(
      { success: false, error: "Failed to log activity." },
      { status: 500 }
    );
  }
}

// GET - Fetch activity logs
export async function GET(req: NextRequest) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { searchParams } = new URL(req.url);

  const search = searchParams.get("search") || "";
  const type = searchParams.get("type") || "";
  const page = parseInt(searchParams.get("page") || "1");
  const pageSize = Math.min(parseInt(searchParams.get("pageSize") || "10"), 100);

  try {
    // Fetch data from database
    const response = await fetchData(search, type, page, pageSize);

    return NextResponse.json(response, { 
      status: 200,
      headers: {
        'Cache-Control': 'public, max-age=60',
      }
    });
  } catch (err) {
    console.error("Unexpected error:", err);
    return NextResponse.json(
      { success: false, error: "Failed to fetch activity logs." },
      { status: 500 }
    );
  }
}
