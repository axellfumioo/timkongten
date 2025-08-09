import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/lib/auth"; // pastikan ini ada
import { logActivity } from "@/app/lib/logActivity";

// GET: Ambil semua content
export async function GET() {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const { data, error } = await supabase
    .from("content")
    .select("*")
    .order("created_at", { ascending: false });

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json(data);
}

export async function POST(req: NextRequest) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const {
    content_category,
    content_type,
    content_title,
    content_caption,
    content_feedback,
    content_date,
  } = body;

  // Insert content baru
  const { data: contentData, error: contentError } = await supabase
    .from("content")
    .insert([
      {
        user_email: user.email,
        user_name: user.name,
        content_category,
        content_type,
        content_title,
        content_caption,
        content_feedback,
        content_date,
      },
    ])
    .select();

  if (contentError) {
    return NextResponse.json({ error: contentError.message }, { status: 500 });
  }

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "content",
    activity_name: "Content Create",
    activity_message: `Created new content titled "${content_title}" scheduled for ${content_date}`,
  });

  // Fetch evidence setelah insert content
  // Asumsikan /api/evidence endpoint bisa diakses di server dengan base url sama
  // Insert evidence ke table evidence di Supabase
  const { data: evidenceData, error: evidenceError } = await supabase
    .from("evidence")
    .insert([
      {
        evidence_title: `Membuat konten`,
        evidence_description: `Ditugaskan untuk membuat konten "${content_title}"`,
        evidence_date: content_date,
        evidence_job: `COC-${content_date}`,
        evidence_status: "needaction",
        user_email: user.email,
      },
    ])
    .select();

  if (evidenceError) {
    console.error(
      `Insert evidence failed: ${evidenceError.message}`
    );
    return NextResponse.json(
      {
        content: contentData,
        evidenceError: evidenceError.message,
      },
      { status: 500 }
    );
  }

    return NextResponse.json(
      {
        content: contentData,
        evidence: evidenceData,
      },
      { status: 201 }
    );
}
