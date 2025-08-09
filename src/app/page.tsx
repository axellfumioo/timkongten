'use client'

import { motion, MotionConfig } from 'framer-motion'
import Image from 'next/image'
import GoogleLoginButton from '@/components/GoogleLoginButton'
import { useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

export default function LoginPage() {
  const { data: session, status } = useSession();
  const router = useRouter();

  useEffect(() => {
    if (status === "authenticated") {
      router.push("/dashboard"); // redirect ke dashboard
    }
  }, [status, router]);

  if (status === "loading") {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[#0a0a0a] text-white">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-white mx-auto mb-4"></div>
          <p>Loading...</p>
        </div>
      </div>
    )
  }

  if (status === "authenticated") {
    return null; // Supaya tidak render UI saat redirect
  }
  return (
    <MotionConfig transition={{ duration: 0.6, ease: 'easeInOut' }}>
      <main className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-zinc-950 via-zinc-900 to-black px-4 relative overflow-hidden">
        {/* Floating Ornaments */}
        <div className="absolute w-80 h-80 bg-pink-500/10 rounded-full blur-3xl top-[-100px] left-[-100px] z-0"></div>
        <div className="absolute w-96 h-96 bg-blue-500/10 rounded-full blur-2xl bottom-[-120px] right-[-120px] z-0"></div>
        <div className="absolute w-60 h-60 bg-purple-500/10 rounded-full blur-2xl top-[50%] left-[45%] z-0 hidden md:block"></div>
        <motion.div
          initial={{ opacity: 0, y: 40, scale: 0.98 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          className="w-full max-w-md backdrop-blur-md bg-zinc-800/80 border border-zinc-700 shadow-2xl rounded-2xl p-8 space-y-6"
        >
          <div className="text-center space-y-3">
            <motion.div
              initial={{ rotate: -10, scale: 0.85, opacity: 0 }}
              animate={{ rotate: 0, scale: 1, opacity: 1 }}
              transition={{ delay: 0.2 }}
              className="mx-auto w-28 h-auto"
            >
              <Image
                src="/logosmk.png"
                alt="SMK Telkom Logo"
                width={120}
                height={120}
                priority
                className="mx-auto"
              />
            </motion.div>

            <motion.h1
              className="text-xl font-semibold text-white"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.3 }}
            >
              Brand Ambassador & Tim Konten
            </motion.h1>
          </div>

          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            transition={{ delay: 0.4 }}
          >
            <GoogleLoginButton />
          </motion.div>

          <p className="text-xs text-center text-zinc-400">
            Autentikasi menggunakan akun Google SMK Telkom Purwokerto <br />
            (@student.smktelkom-pwt.sch.id)
          </p>
        </motion.div>
        <motion.div
          initial={{ opacity: 0, y: 40, scale: 0.98 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          className='mt-2'
        >
          <p className='text-xs text-center text-zinc-400'>Website dibuat oleh Axel (XI PPLG 6)</p>
        </motion.div>
      </main>
    </MotionConfig>
  )
}
