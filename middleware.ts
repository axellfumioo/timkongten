// middleware.ts
import { withAuth } from "next-auth/middleware";

export default withAuth({
  pages: {
    signIn: "/", // redirect otomatis kalau belum login
  },
  callbacks: {
    authorized: ({ token }) => !!token, // true = lanjut, false = redirect
  },
});

export const config = {
  matcher: ["/dashboard/:path*", "/dashboard"],
};
