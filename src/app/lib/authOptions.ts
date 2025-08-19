import { NextAuthOptions } from "next-auth";
import GoogleProvider from "next-auth/providers/google";
import { supabase } from "@/app/lib/supabase";
import { validateUser } from "@/app/lib/validateUser";
import { logActivity } from "@/app/lib/logActivity";
import redis from "@/app/lib/redis";

const CACHE_TTL = 60 * 30; // 10 menit
const redisKey = (email: string) => `user:${email}`;

async function getCachedUserData(email: string) {
  try {
    const cached = await redis.get(redisKey(email));
    return cached ? JSON.parse(cached) : null;
  } catch {
    return null;
  }
}

async function setCachedUserData(email: string, data: any) {
  try {
    await redis.set(redisKey(email), JSON.stringify(data), "EX", CACHE_TTL);
  } catch {}
}

async function getUserFromDB(email: string) {
  const { data } = await supabase
    .from("users")
    .select("role, email, name")
    .eq("email", email)
    .single();

  if (!data) return null;
  return {
    role: data.role,
    email: data.email,
    name: data.name,
  };
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

      let userData = await getCachedUserData(email);

      if (!userData) {
        const dbData = await getUserFromDB(email);
        if (!dbData) return false;

        const isValid = await validateUser(email);
        if (!isValid) return false;

        userData = { ...dbData, picture: profile.image || "" };
        await setCachedUserData(email, userData);
      }

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
        const cached = await getCachedUserData(user.email);
        if (cached) {
          token.role = cached.role;
          token.email = cached.email;
          token.name = cached.name;
          token.picture = cached.picture || user.image;
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
