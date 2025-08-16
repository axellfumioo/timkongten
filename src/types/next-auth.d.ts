import NextAuth, { DefaultSession, DefaultUser } from "next-auth";
import { DefaultJWT } from "next-auth/jwt";

declare module "next-auth" {
  interface Session extends DefaultSession {
    user: {
      name: string;
      email: string;
      image: string;
      role: string;
      allowed?: boolean; // tambahan custom flag
    };
  }

  interface User extends DefaultUser {
    name: string;
    email: string;
    role: string;
    image: string;
    role: string;
    allowed?: boolean; // tambahan custom flag
  }
}

declare module "next-auth/jwt" {
  interface JWT extends DefaultJWT {
    role: string;
    name: string;
    email: string;
    image: string;
    role: string;
    allowed?: boolean; // tambahan custom flag
  }
}
