import { supabase } from "@/app/lib/supabase";
import { NextResponse } from "next/server";
import { uploadToR2 } from "@/app/lib/uploadToR2";
import { randomUUID } from "crypto";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/lib/auth"; // pastikan ini ada

import { logActivity } from "@/app/lib/logActivity";

export async function GET(req: Request) {
  const session = await getServerSession(authOptions);
  const userauth = session?.user;

  if (!userauth?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const { searchParams } = new URL(req.url);

  const user = searchParams.get("user");
  const date = searchParams.get("date");
  const month = searchParams.get("month");
  const year = searchParams.get("year");
  const find = searchParams.get("find");

  console.log("Filters active:", { user, date, month, year, find });

  let query = supabase.from("evidence").select("*", { count: "exact" });

  // Filter berdasarkan user_email
  if (user) {
    query = query.eq("user_email", user);
  }

  // Filter tanggal spesifik
  if (date) {
    const [day, monthStr, yearStr] = date.split("/");
    const startDate = new Date(
      `${yearStr}-${monthStr.padStart(2, "0")}-${day.padStart(
        2,
        "0"
      )}T00:00:00Z`
    );
    const endDate = new Date(startDate);
    endDate.setDate(endDate.getDate() + 1);

    query = query
      .gte("evidence_date", startDate.toISOString())
      .lt("evidence_date", endDate.toISOString());
  }

  // Filter bulan & tahun (untuk list data)
  if (month && year) {
    const monthNum = Number(month);
    const yearNum = Number(year);

    const startDate = new Date(yearNum, monthNum - 1, 1);
    const endDate = new Date(yearNum, monthNum, 1);

    query = query
      .gte("evidence_date", startDate.toISOString())
      .lt("evidence_date", endDate.toISOString());
  }

  // Filter pencarian keyword
  if (find && find.trim() !== "") {
    query = query.or(
      `evidence_title.ilike.%${find}%,evidence_description.ilike.%${find}%`
    );
  }

  // Eksekusi query utama
  const { data, error } = await query.order("created_at", { ascending: false });

  if (error) {
    console.error("GET /evidences error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  // Ambil total bulan ini (tanpa filter user/find/date)
  let evidenceTotal = 0;
  let acceptedEvidenceTotal = 0;

  if (month && year) {
    const monthNum = Number(month);
    const yearNum = Number(year);

    const startDate = new Date(yearNum, monthNum - 1, 1);
    const endDate = new Date(yearNum, monthNum, 1);

    // Total semua evidence bulan ini
    const { count: totalCount, error: countError } = await supabase
      .from("evidence")
      .select("*", { count: "exact", head: true })
      .gte("evidence_date", startDate.toISOString())
      .lt("evidence_date", endDate.toISOString());

    if (countError) {
      console.error("Count error:", countError);
    } else {
      evidenceTotal = totalCount ?? 0;
    }

    // Total accepted evidence bulan ini
    const { count: acceptedCount, error: acceptedCountError } = await supabase
      .from("evidence")
      .select("*", { count: "exact", head: true })
      .gte("evidence_date", startDate.toISOString())
      .lt("evidence_date", endDate.toISOString())
      .eq("evidence_status", "accepted");

    if (acceptedCountError) {
      console.error("Accepted Count error:", acceptedCountError);
    } else {
      acceptedEvidenceTotal = acceptedCount ?? 0;
    }
  }

  return NextResponse.json({ data, evidenceTotal, acceptedEvidenceTotal });
}

export async function POST(req: Request) {
  try {
    const formData = await req.formData();
    const session = await getServerSession(authOptions);
    const user = session?.user;

    if (!user?.email) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    if (!session) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }
    const user_email = session.user?.email;
    if (!user_email) {
      return NextResponse.json(
        { error: "User email tidak ditemukan" },
        { status: 400 }
      );
    }

    const evidence_title = formData.get("evidence_title") as string;
    const evidence_description = formData.get("evidence_description") as string;
    const evidence_date = formData.get("evidence_date") as string;
    const evidence_job = formData.get("evidence_job") as string;
    const evidence_status = "pending";
    const file = formData.get("completion_proof") as File | null;

    let fileUrl: string | null = null;
    if (file && file.name) {
      const fileExt = file.name.split(".").pop();
      const filename = `${randomUUID()}.${fileExt}`;
      fileUrl = await uploadToR2(file, filename, process.env.R2_BUCKET!);
      if (!fileUrl) {
        return NextResponse.json(
          { error: "Gagal mengunggah file ke R2" },
          { status: 500 }
        );
      }
    }

    const payload = {
      user_email,
      evidence_title,
      evidence_description,
      evidence_date,
      evidence_job,
      completion_proof: fileUrl, // bisa null kalau file tidak ada
      evidence_status,
    };

    console.log("Insert payload:", payload);

    const { data, error, status } = await supabase
      .from("evidence")
      .insert([payload]);

    if (error) {
      console.error("Supabase insert error:", error);
      return NextResponse.json(
        { error: error.message || "Insert gagal" },
        { status: 500 }
      );
    }

    await logActivity({
      user_name: session.user.name,
      user_email: user_email,
      activity_type: "evidence",
      activity_name: "Evidence Created",
      activity_message: `${session.user.name} created evidence "${evidence_title}"`,
    });

    return NextResponse.json(
      { message: "Evidence created successfully", url: fileUrl },
      { status: 201 }
    );
  } catch (err: any) {
    console.error("POST /evidences fatal error:", err);
    return NextResponse.json(
      { error: `Terjadi kesalahan pada server ${err}` },
      { status: 500 }
    );
  }
}
