'use client'

import React, { useState, useEffect } from 'react'
import { Menu, MoreVertical, SquarePen, UserIcon } from 'lucide-react'
import Sidebar from '@/components/dashboard/common/Sidebar'
import Calendar from '@/components/dashboard/layout/Calendar'
import AuthGuard from '@/components/AuthGuard'
import ContentModalCOC from '@/components/dashboard/layout/journal/contentModal/ContentModalCOC'
import { supabase } from '@/app/lib/supabase'
import { useGlobalStore } from '@/app/lib/global-store'


const App = () => {
    const [sidebarOpen, setSidebarOpen] = useState(false)
    return (
        <AuthGuard>
            <div className="flex h-screen bg-[#0a0a0a] text-white">
                {/* Sidebar Desktop */}
                <Sidebar />

                {/* Main Layout */}
                <div className="flex flex-col flex-1">

                    {/* Mobile Navbar */}
                    <div className="md:hidden flex items-center justify-between px-5 py-4 border-b border-white/10 bg-[#0a0a0a] shadow-sm">
                        <h2 className="text-xl font-semibold tracking-tight">Tim Konten</h2>
                        <button onClick={() => setSidebarOpen(true)} aria-label="Open menu">
                            <Menu size={28} />
                        </button>
                    </div>

                    {/* Main Content */}
                    <main className="flex-1 px-5 sm:px-10 pt-10 bg-[#0a0a0a] overflow-y-auto">
                        <div className="mb-6">
                            <h1 className="text-4xl font-extrabold mb-2">Content Writer</h1>
                            <p className="text-white/50 text-lg">Menulis storyboard untuk konten video</p>
                        </div>
                        <div className='container'>
                            <div className='bg-[#1a1a1a] justify-center rounded-lg'>
                                <form className='flex flex-col px-8 py-10'>
                                    <div className='flex flex-col mb-4'>
                                        <input
                                            className='w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-white/20 transition'
                                            placeholder='Masukan judul konten'
                                            minLength={5}
                                            required
                                            title='Judul harus minimal 5 karakter'
                                        />
                                    </div>
                                    <button className='bg-white text-[#0a0a0a] px-4 py-2 rounded-md font-semibold hover:bg-gray-200'>Buat storyboard</button>
                                </form>
                            </div>
                        </div>
                    </main>
                </div>

                {/* Sidebar Mobile */}
                <Sidebar isMobile isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />

                {/* Backdrop */}
                {sidebarOpen && (
                    <div
                        onClick={() => setSidebarOpen(false)}
                        className="fixed inset-0 bg-black/50 z-30 md:hidden"
                    />
                )}
            </div>
        </AuthGuard>
    )
}

export default App
