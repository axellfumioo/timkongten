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
      router.replace("/"); // extra safety, user yg bypass client
    }
  }, [status, router]);

  if (status === "loading") {
    // ⚡ optional, bisa dihilangin kalau mau no flash
    return null;
  }

  return <>{children}</>;
}
