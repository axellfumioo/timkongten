// app/api/activity-log/route.ts
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { supabase } from "@/app/lib/supabase";
import { authOptions } from "@/app/lib/authOptions";

// Helper function to fetch data
async function fetchData(search: string, type: string, page: number, pageSize: number) {
  const offset = (page - 1) * pageSize;
  
  let query = supabase
    .from("activity_logs")
    .select(
      "user_email,user_name,activity_type,activity_name,activity_message,activity_date",
      { count: "exact" }
    )
    .order("activity_date", { ascending: false });

  if (search) {
    const safeSearch = search.replace(/[%_\\]/g, '\\$&').substring(0, 50);
    query = query.or(
      `user_name.ilike.%${safeSearch}%,activity_name.ilike.%${safeSearch}%,activity_message.ilike.%${safeSearch}%`
    );
  }

  if (type) {
    query = query.eq("activity_type", type);
  }

  query = query.range(offset, offset + pageSize - 1);

  const { data, error, count } = await query;

  if (error) {
    throw error;
  }

  return {
    success: true,
    data,
    pagination: {
      page,
      pageSize,
      total: count,
      totalPages: Math.ceil((count ?? 0) / pageSize),
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
    const { data, error } = await supabase.from("activity_logs").insert([
      {
        user_email,
        user_name,
        activity_type,
        activity_name,
        activity_message,
        activity_url,
        activity_agent,
        activity_method,
        activity_date: timestamp,
      },
    ]);

    if (error) {
      console.error("Supabase insert error:", error);
      return NextResponse.json(
        { success: false, error: error.message },
        { status: 500 }
      );
    }

    return NextResponse.json({ success: true, data }, { status: 201 });
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
    // Fetch data from Supabase
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
