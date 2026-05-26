import { query } from "@/app/lib/postgres"
async function seedAdmin() {
  try {
    const result = await query(
      "UPDATE users SET role = $1 WHERE email = $2 RETURNING id",
      ["admin", "541241032@student.smktelkom-pwt.sch.id"]
    )
    if (result.rowCount === 0) {
      console.error("Gagal update role admin: user tidak ditemukan")
      return
    }
    console.log("Berhasil assign role admin ke:", result.rows)
  } catch (error) {
    console.error("Gagal update role admin:", error)
  }
}

seedAdmin()
