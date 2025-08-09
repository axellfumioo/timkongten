'use client'

import React, { useState, useEffect } from 'react'
import { Menu, MoreVertical, SquarePen, UserIcon } from 'lucide-react'
import Sidebar from '@/components/dashboard/common/Sidebar'
import Calendar from '@/components/dashboard/layout/Calendar'
import AuthGuard from '@/components/AuthGuard'
import ContentModalCOC from '@/components/dashboard/layout/journal/contentModal/ContentModalCOC'
import { supabase } from '@/app/lib/supabase'
import { useGlobalStore } from '@/app/lib/global-store'

interface SelectedDate {
    day: number
    month: number
    year: number
}

function getTodayDate(): SelectedDate {
    const today = new Date()
    return {
        day: today.getDate(),
        month: today.getMonth(),
        year: today.getFullYear(),
    }
}

const App = () => {
    const [sidebarOpen, setSidebarOpen] = useState(false)
    const [selectedDate, setSelectedDate] = useState<SelectedDate>(() => getTodayDate())
    const [events, setEvents] = useState<any[]>([])
    const [isLoading, setIsLoading] = useState(false)
    const [modalOpen, setModalOpen] = useState(false)
    const [selectedContent, setSelectedContent] = useState<any | null>(null)
    const setUpdated = useGlobalStore((state) => state.setUpdated)
    const updated = useGlobalStore((state) => state.updated)

    const dateFormatted = `${selectedDate.year}-${String(selectedDate.month + 1).padStart(2, '0')}-${String(selectedDate.day).padStart(2, '0')}`

    const formattedDateString = new Date(selectedDate.year, selectedDate.month, selectedDate.day).toLocaleDateString('id-ID', {
        weekday: 'long',
        day: 'numeric',
        month: 'long',
        year: 'numeric',
    })

    const fetchEvents = async () => {
        setIsLoading(true)
        const { data, error } = await supabase
            .from('content')
            .select('*, users(*)')
            .eq('content_date', dateFormatted)

        if (error) {
            console.error('Error fetching content + user:', error)
        } else {
            setEvents(data)
        }
        setIsLoading(false)
    }

    useEffect(() => {
        fetchEvents()
    }, [dateFormatted])

    useEffect(() => {
        if (updated) {
            fetchEvents()
            // setUpdated(false)
        }
    }, [updated, dateFormatted])

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
                            <h1 className="text-4xl font-extrabold mb-2">Drive Sort (Coming Soon)</h1>
                            <p className="text-white/50 text-lg">Sortir Foto dan VIdeo dari Google Drive</p>
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
