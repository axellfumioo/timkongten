'use client'

import { useEffect, useState } from 'react'
import { useSearchParams } from 'next/navigation'
import { motion } from 'framer-motion'
import { AlertCircle, ArrowLeft } from 'lucide-react'

function escapeHTML(input: string): string {
  return input
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
}

const errorMessages: Record<string, string> = {
  AccessDenied:
    'Akun Anda tidak terdaftar sebagai anggota Tim Konten. Hubungi humas untuk mendapatkan akses.',
  Configuration:
    'Terjadi kesalahan konfigurasi sistem. Tim kami telah diberitahu.',
}

export const dynamic = "force-dynamic"; // <--- tambahin ini

export default function AuthErrorPage() {
  const searchParams = useSearchParams()
  const [errorMessage, setErrorMessage] = useState('')

  useEffect(() => {
    const rawError = searchParams.get('error') || ''
    const sanitizedError = escapeHTML(rawError)

    setErrorMessage(
      rawError in errorMessages
        ? errorMessages[rawError]
        : `Terjadi kesalahan saat proses otentikasi. Silakan coba lagi. (${sanitizedError})`
    )
  }, [searchParams])

  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-zinc-950 via-zinc-900 to-black px-4 relative overflow-hidden">
      {/* Floating Ornaments */}
      <div className="absolute w-80 h-80 bg-pink-500/10 rounded-full blur-3xl top-[-100px] left-[-100px] z-0"></div>
      <div className="absolute w-96 h-96 bg-blue-500/10 rounded-full blur-2xl bottom-[-120px] right-[-120px] z-0"></div>
      <div className="absolute w-60 h-60 bg-purple-500/10 rounded-full blur-2xl top-[50%] left-[45%] z-0 hidden md:block"></div>
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.4, ease: 'easeOut' }}
        className="w-full max-w-md"
      >
        <div className="bg-[#1a1a1a] rounded-xl shadow-2xl overflow-hidden border border-[#2a2a2a]">
          <div className="p-6">
            <div className="flex items-start mb-6">
              <div className="flex-shrink-0">
                <div className="flex items-center justify-center h-10 w-10 rounded-full bg-[#2a2a2a]">
                  <AlertCircle className="h-6 w-6 text-red-500" />
                </div>
              </div>
              <div className="ml-4">
                <h3 className="text-lg font-medium text-white">Error Autentikasi</h3>
                <div className="mt-2 text-sm text-gray-400">
                  <p>{errorMessage}</p>
                </div>
              </div>
            </div>

            <motion.div whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.98 }}>
              <a
                href="/"
                className="w-full inline-flex items-center justify-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-[#333] hover:bg-[#444] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors"
              >
                <ArrowLeft className="mr-2 h-4 w-4" />
                Kembali ke Halaman Login
              </a>
            </motion.div>
          </div>

          <div className="bg-[#1a1a1a] px-6 py-4 border-t border-[#2a2a2a]">
            <p className="text-xs text-gray-500 text-center">
              Butuh bantuan atau terjadi kesalahan?{' '}
              <span className="text-red-400">Hubungi Humas</span>
            </p>
          </div>
        </div>
      </motion.div>
    </div>
  )
}
