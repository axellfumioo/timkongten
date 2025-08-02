'use client'

import { motion, MotionConfig } from 'framer-motion'
import Image from 'next/image'
import GoogleLoginButton from '@/components/GoogleLoginButton'

export default function LoginPage() {
  return (
    <MotionConfig transition={{ duration: 0.6, ease: 'easeInOut' }}>
      <main className="min-h-screen flex items-center justify-center bg-gradient-to-br from-zinc-900 to-black px-4">
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
              className="text-2xl font-semibold text-white"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: 0.3 }}
            >
              Masuk ke Dashboard
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
            Autentikasi menggunakan akun Google SMK Telkom Purwokerto
          </p>
        </motion.div>
      </main>
    </MotionConfig>
  )
}
