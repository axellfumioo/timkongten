"use client";

import { useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

interface AuthGuardProps {
  children: React.ReactNode;
}

export default function AuthGuard({ children }: AuthGuardProps) {
  const { data: session, status } = useSession();
  const router = useRouter();

  useEffect(() => {
    if (status === "unauthenticated") {
      router.replace("/"); // safety net
    }
  }, [status, router]);

  if (status === "loading") {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[#0a0a0a] text-white">
        <div className="text-center space-y-4">
          <div className="relative w-14 h-14 mx-auto">
            <div className="absolute inset-0 rounded-full border-4 border-white border-t-transparent animate-spin"></div>
            <div className="absolute inset-2 rounded-full bg-[#0a0a0a]"></div>
          </div>
          <p className="text-lg font-medium tracking-wide animate-pulse text-white/80">
            Loading, please wait...
          </p>
        </div>
      </div>
    );
  }

  return <>{children}</>;
}
