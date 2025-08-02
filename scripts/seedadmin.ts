import { createClient } from "@supabase/supabase-js"

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

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
