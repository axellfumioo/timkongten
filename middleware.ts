// middleware.ts
import { withAuth } from "next-auth/middleware";

export default withAuth({
  pages: {
    signIn: "/", // custom login page
  },
  callbacks: {
    authorized({ token }) {
      console.log("✅ Middleware triggered", token); // <<< ini wajib muncul
      return !!token; // cuma bisa lanjut kalau token ada
    },
  },
});

export const config = {
  matcher: ["/dashboard/:path*", "/dashboard"], // tambahin "/dashboard"
};
