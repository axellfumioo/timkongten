import { supabase } from "@/app/lib/supabase";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth/next";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";
import { logActivity } from "@/app/lib/logActivity";

// GET: Ambil content by ID
export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user?.email) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const { data, error } = await supabase
    .from("content")
    .select("*")
    .eq("id", params.id)
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 404 });
  }

  return NextResponse.json(data);
}

// DELETE: Hapus content by ID
export async function DELETE(
  _: NextRequest,
  { params }: { params: { id: string } }
) {
  const session = await getServerSession(authOptions);
  const user = session?.user;

  if (!user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  // Ambil data content sebelum dihapus
  const { data: contentData, error: fetchError } = await supabase
    .from("content")
    .select("content_title, content_date")
    .eq("id", params.id)
    .single();

  if (fetchError || !contentData) {
    return NextResponse.json(
      { error: "Content not found before deletion" },
      { status: 404 }
    );
  }

  // Hapus data
  const { error: deleteError } = await supabase
    .from("content")
    .delete()
    .eq("id", params.id);

  if (deleteError) {
    return NextResponse.json({ error: deleteError.message }, { status: 500 });
  }

  // Log aktivitas setelah berhasil hapus
  await logActivity({
    user_name: user.name,
    user_email: user.email,
    activity_type: "content",
    activity_name: "Content Removed",
    activity_message: `Removed content titled "${contentData.content_title}" scheduled for ${contentData.content_date}`,
  });

  return NextResponse.json({ message: "Deleted successfully" });
}
