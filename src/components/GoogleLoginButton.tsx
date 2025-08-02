'use client'

import { motion } from 'framer-motion'

export default function GoogleLoginButton() {
  return (
    <motion.button
      whileTap={{ scale: 0.96 }}
      whileHover={{ scale: 1.015 }}
      transition={{ type: 'spring', stiffness: 300, damping: 20 }}
      className="flex items-center justify-center gap-3 px-5 py-3 w-full border rounded-xl shadow-md hover:shadow-lg active:shadow-sm transition-shadow duration-200 cursor-pointer
        bg-white border-gray-200 text-gray-700
        dark:bg-zinc-900 dark:border-zinc-700 dark:text-zinc-100"
      onClick={() => alert('Redirect to Google login')}
    >
      <img
        src="/google.svg"
        alt="Google"
        className="w-5 h-5"
      />
      <span className="text-sm font-medium">
        Sign in with Google
      </span>
    </motion.button>
  )
}
