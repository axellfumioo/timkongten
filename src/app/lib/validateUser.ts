import { query } from "./postgres";

export async function validateUser(email: string): Promise<boolean> {
  const result = await query<{ id: string }>(
    "SELECT id FROM users WHERE email = $1 LIMIT 1",
    [email]
  );

  return (result.rowCount ?? 0) > 0;
}
