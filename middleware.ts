// middleware.ts
import { withAuth } from "next-auth/middleware";
import { NextResponse } from "next/server";

export default withAuth(
  function middleware(req) {
    const token = req.nextauth.token;
    const pathname = req.nextUrl.pathname;
    
    console.log("🔥 MIDDLEWARE EXECUTED:", {
      pathname,
      hasToken: !!token,
      userEmail: token?.email,
      userRole: token?.role,
      timestamp: new Date().toISOString()
    });
    
    // Jika tidak ada token, redirect ke login
    if (!token) {
      console.log("🚫 No token found - redirecting to login");
      const loginUrl = new URL("/", req.url);
      return NextResponse.redirect(loginUrl);
    }
    
    // Jika ada token, lanjutkan
    console.log("✅ Token found - access granted");
    return NextResponse.next();
  },
  {
    pages: {
      signIn: "/",
    },
    callbacks: {
      // Callback ini WAJIB return true agar middleware function di atas berjalan
      authorized({ token, req }) {
        const pathname = req.nextUrl.pathname;
        
        console.log("🔍 AUTHORIZATION CALLBACK:", {
          pathname,
          hasToken: !!token,
          userEmail: token?.email,
        });
        
        // PENTING: Return true agar middleware function selalu dijalankan
        // Logic redirect ada di middleware function, bukan di sini
        return true;
      },
    },
  }
);

export const config = {
  matcher: [
    "/dashboard/:path*",
    "/dashboard"
  ],
};
