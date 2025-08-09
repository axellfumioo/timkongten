import { createClient } from "@supabase/supabase-js";
import { supabase } from "./supabase";

export async function validateUser(email: string): Promise<boolean> {  
  const { data, error } = await supabase
    .from("users")
    .select("id")
    .eq("email", email)
    .single();

  if (error || !data) {
    return false;
  }

  return true; // Email ditemukan
}
