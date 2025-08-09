import { supabase } from "@/app/lib/supabase"
async function seedAdmin() {
  const { data, error } = await supabase
    .from("users")
    .update({ role: "admin" })
    .eq("email", "541241032@student.smktelkom-pwt.sch.id")

  if (error) {
    console.error("Gagal update role admin:", error)
  } else {
    console.log("Berhasil assign role admin ke:", data)
  }
}

seedAdmin()
