import NextAuth from "next-auth";
import { authOptions } from "@/app/lib/authOptions";

// Handler NextAuth
const handler = NextAuth(authOptions);

// WAJIB untuk App Router → GET & POST
export { handler as GET, handler as POST };
