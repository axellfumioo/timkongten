import { NextAuthOptions } from "next-auth";
import GoogleProvider from "next-auth/providers/google";
import { validateUser } from "@/app/lib/validateUser";
import { logActivity } from "@/app/lib/logActivity";
import { query } from "@/app/lib/postgres";

async function getUserFromDB(email: string) {
  try {
    const result = await query<{
      role: string;
      email: string;
      name: string;
    }>("SELECT role, email, name FROM users WHERE email = $1 LIMIT 1", [
      email,
    ]);

    const data = result.rows[0];
    if (!data) return null;
    return {
      role: data.role,
      email: data.email,
      name: data.name,
    };
  } catch (error) {
    console.error("Failed loading user from database:", error);
    return null;
  }
}

export const authOptions: NextAuthOptions = {
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    }),
  ],
  session: { strategy: "jwt" },
  secret: process.env.NEXTAUTH_SECRET,

  callbacks: {
    async signIn({ profile }) {
      if (!profile?.email) return false;

      const email = profile.email;
      const name = profile.name || "unknown";

      const dbData = await getUserFromDB(email);
      if (!dbData) return false;

      const isValid = await validateUser(email);
      if (!isValid) return false;

      await logActivity({
        user_name: name,
        user_email: email,
        activity_type: "auth",
        activity_name: "Sign In Success",
        activity_message: `User ${email} signed in.`,
      });

      return true;
    },

    async jwt({ token, user }) {
      if (user?.email) {
        const userData = await getUserFromDB(user.email);
        if (userData) {
          token.role = userData.role;
          token.email = userData.email;
          token.name = userData.name;
          token.picture = user.image;
        }
      }
      return token;
    },

    async session({ session, token }) {
      if (!token?.email || !session.user) return session;

      session.user = {
        email: token.email,
        role: token.role,
        name: token.name,
        image: token.picture as string,
        allowed: true,
      };

      return session;
    },
  },

  pages: {
    signIn: "/",
    error: "/auth/error",
  },
};
