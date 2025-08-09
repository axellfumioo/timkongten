// app/api/evidences/[id]/route.ts
import { supabase } from "@/app/lib/supabase";
import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/lib/auth";
import { logActivity } from "@/app/lib/logActivity";

export async function GET(_: Request, { params }: { params: { id: string } }) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const { data, error } = await supabase
    .from("evidences")
    .select("*")
    .eq("id", params.id)
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 404 });
  }

  // Log activity hanya kalau user login
  if (user) {
    await logActivity({
      user_name: user.name,
      user_email: user.email,
      activity_type: "evidence",
      activity_name: "Evidence Viewed",
      activity_message: `${user.name} viewed evidence "${data.evidence_title}"`,
    });
  }

  return NextResponse.json(data);
}

export async function PUT(
  req: Request,
  { params }: { params: { id: string } }
) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await req.json();
  const { evidence_title } = body;

  const { error } = await supabase
    .from("evidences")
    .update(body)
    .eq("id", params.id);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Updated",
    activity_message: `${user.name} updated evidence "${evidence_title}"`,
  });

  return NextResponse.json({ message: "Evidence updated successfully" });
}

export async function DELETE(
  _: Request,
  { params }: { params: { id: string } }
) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  // Ambil title dulu sebelum dihapus (buat log yang jelas)
  const { data: evidenceData } = await supabase
    .from("evidence")
    .select("evidence_title")
    .eq("id", params.id)
    .single();

  const { error } = await supabase
    .from("evidence")
    .delete()
    .eq("id", params.id);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "evidence",
    activity_name: "Evidence Deleted",
    activity_message: `${user.name} deleted evidence "${
      evidenceData?.evidence_title || params.id
    }"`,
  });

  return NextResponse.json({ message: "Evidence deleted successfully" });
}
