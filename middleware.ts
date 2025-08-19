import { withAuth } from "next-auth/middleware";
import { NextResponse } from "next/server";

export default withAuth(
  function middleware(req) {
    const token = req.nextauth.token;

    // 🚫 Kalau gak ada token → redirect ke login
    if (!token) {
      return NextResponse.redirect(new URL("/", req.url));
    }

    // ✅ Kalau ada token → lanjut
    return NextResponse.next();
  },
  {
    pages: {
      signIn: "/", // redirect ke login kalau belum auth
    },
    callbacks: {
      authorized({ token }) {
        // 🚀 return true biar middleware function tetap dipanggil
        return true;
      },
    },
  }
);

export const config = {
  matcher: [
    "/dashboard/:path*", // semua halaman dashboard dilindungi
    "/dashboard",
  ],
};
