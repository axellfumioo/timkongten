import { validateUser } from "@/app/lib/validateUser";
import { supabase } from "@/app/lib/supabase";
import NextAuth, { NextAuthOptions } from "next-auth";
import GoogleProvider from "next-auth/providers/google";
import { logActivity } from "@/app/lib/logActivity";

export const authOptions: NextAuthOptions = {
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
      authorization: {
        params: {
          prompt: "consent",
          access_type: "offline",
          response_type: "code",
        },
      },
    }),
  ],
  session: {
    strategy: "jwt",
  },
  secret: process.env.NEXTAUTH_SECRET,

  callbacks: {
    async signIn({ profile }) {
      const email = profile?.email ?? "unknown";
      const name = profile?.name ?? "unknown";

      if (!profile?.email) {
        await logActivity({
          user_name: name,
          user_email: email,
          activity_type: "auth",
          activity_name: "Sign In Failed",
          activity_message: "Sign-in attempt without email.",
        });
        return false;
      }

      const { data: user, error } = await supabase
        .from("users")
        .select("role")
        .eq("email", profile.email)
        .single();

      if (error || !user) {
        await logActivity({
          user_name: name,
          user_email: email,
          activity_type: "auth",
          activity_name: "Sign In Failed",
          activity_message: `Sign-in failed for ${email}. User not found.`,
        });
        return false;
      }

      const isValid = await validateUser(email);
      if (!isValid) {
        await logActivity({
          user_name: name,
          user_email: email,
          activity_type: "auth",
          activity_name: "Sign In Failed",
          activity_message: `Sign-in failed for ${email}. Validation rejected.`,
        });
        return false;
      }

      await logActivity({
        user_name: name,
        user_email: email,
        activity_type: "auth",
        activity_name: "Sign In Success",
        activity_message: `User ${email} signed in successfully.`,
      });

      return true;
    },

    async jwt({ token, user }) {
      if (user?.email) {
        const { data: userData } = await supabase
          .from("users")
          .select("*")
          .eq("email", user.email)
          .single();

        token.role = userData?.role || "user";
        token.email = userData?.email || user.email;
        token.name = userData?.name || user.name;
        token.picture = user.image;
      }
      return token;
    },

    async session({ session, token }) {
      if (!token || !session.user) return session;

      const email = token.email as string;
      const name = token.name as string;

      const isValid = await validateUser(email);
      if (!isValid) {
        session.user.allowed = false;

        await logActivity({
          user_name: name,
          user_email: email,
          activity_type: "auth",
          activity_name: "Session Invalid",
          activity_message: `Session rejected for ${email}`,
        });

        return session;
      }

      session.user.role = token.role as string;
      session.user.email = email;
      session.user.name = name;
      session.user.image = token.picture as string;
      session.user.allowed = true;
      return session;
    },

    async redirect({ url, baseUrl }) {
      return `${baseUrl}/dashboard`;
    },
  },

  pages: {
    signIn: "/",
    error: "/auth/error",
  },

  debug: process.env.NODE_ENV === "development",
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
