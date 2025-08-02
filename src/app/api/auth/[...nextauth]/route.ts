import NextAuth, { NextAuthOptions } from "next-auth";
import GoogleProvider from "next-auth/providers/google";

export const authOptions: NextAuthOptions = {
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    }),
  ],
  // ✅ PERBAIKAN KRITIS: Hapus database adapter untuk pure JWT
  // adapter: SupabaseAdapter({
  //   url: process.env.SUPABASE_URL!,
  //   secret: process.env.SUPABASE_SERVICE_ROLE_KEY!,
  // }),
  
  // ✅ WAJIB: JWT strategy untuk middleware
  session: {
    strategy: "jwt",
  },
  secret: process.env.NEXTAUTH_SECRET,
  
  callbacks: {
    async jwt({ token, user, account }) {
      if (user) {
        // Simpan info user ke JWT token
        token.role = user.role || "user";
        token.email = user.email;
        token.name = user.name;
        token.picture = user.image;
      }
      return token;
    },

    async session({ session, token }) {
      if (token) {
        session.user.role = token.role as string;
        session.user.email = token.email as string;
        session.user.name = token.name as string;
        session.user.image = token.picture as string;
      }
      return session;
    },
  },
  
  pages: {
    signIn: "/", // Konsisten dengan middleware
  },
  
  // ✅ TAMBAHAN: Debug info
  debug: process.env.NODE_ENV === "development",
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
