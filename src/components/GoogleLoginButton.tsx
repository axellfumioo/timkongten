'use client'

import { motion } from 'framer-motion'
import { signIn } from 'next-auth/react'
import { useState, useEffect } from "react";

export default function GoogleLoginButton() {
  const [loading, setLoading] = useState(false);
  const [online, setOnline] = useState(true)

  const checkConnection = async () => {
    try {
      const controller = new AbortController()
      const timeout = setTimeout(() => controller.abort(), 3000) // Timeout 3 detik

      const res = await fetch('https://accounts.google.com', {
        mode: 'no-cors',
        signal: controller.signal,
      })

      clearTimeout(timeout)
      setOnline(true)
    } catch (error) {
      setOnline(false)
    }
  }

  useEffect(() => {
    checkConnection()

    const interval = setInterval(() => {
      checkConnection()
    }, 3000) // Cek setiap 3 detik

    return () => clearInterval(interval)
  }, [])
  const handleGoogleSignIn = () => {
    if (online) {
      setLoading(true)
      signIn('google', {
        callbackUrl: `${process.env.NEXT_PUBLIC_BASE_URL}/api/auth/callback/google`,
        redirect: true
      })
    }
  }

  return (
    <>
      {online ?
        <motion.button
          whileTap={{ scale: 0.96 }}
          whileHover={{ scale: 1.015 }}
          transition={{ type: 'spring', stiffness: 300, damping: 20 }}
          className={`flex items-center justify-center gap-3 px-5 py-3 w-full border rounded-xl shadow-md hover:shadow-lg active:shadow-sm transition-shadow duration-200 ${loading ? "bg-zinc-800 border-zinc-700 cursor-default" : "bg-zinc-900 border-zinc-700 cursor-pointer"} text-zinc-100`}
          onClick={handleGoogleSignIn}
          disabled={loading ? true : false}
        >
          {loading ? "" : <img
            src="/google.svg"
            alt="Google"
            className="w-5 h-5"
          />}

          <span className="text-sm font-medium">
            {loading ? "Loading..." : "Masuk menggunakan Google"}
          </span>
        </motion.button>
        :
        <motion.button
          whileTap={{ scale: 0.96 }}
          whileHover={{ scale: 1.015 }}
          transition={{ type: 'spring', stiffness: 300, damping: 20 }}
          className="flex items-center justify-center gap-3 px-5 py-3 w-full border rounded-xl shadow-md hover:shadow-lg active:shadow-sm transition-shadow duration-200 cursor-pointer
        bg-white border-gray-200 text-gray-700
        dark:bg-zinc-900 dark:border-zinc-700 dark:text-zinc-100"
          onClick={checkConnection}
          disabled={true}
        >

          <span className="text-sm font-medium">
            No Internet (Click to reconnect)
          </span>
        </motion.button>
      }
    </>
  )
}
