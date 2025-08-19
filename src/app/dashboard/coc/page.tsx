'use client'

import React, { useState, useEffect } from 'react'
import { Menu, SquarePen, UserIcon } from 'lucide-react'
import Sidebar from '@/components/dashboard/common/Sidebar'
import Calendar from '@/components/dashboard/layout/Calendar'
import AuthGuard from '@/components/AuthGuard'
import ContentModalCOC from '@/components/dashboard/layout/journal/contentModal/ContentModalCOC'
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

  const dateFormatted = `${selectedDate.year}-${String(selectedDate.month + 1).padStart(2, '0')}-${String(
    selectedDate.day
  ).padStart(2, '0')}`

  const formattedDateString = new Date(selectedDate.year, selectedDate.month, selectedDate.day).toLocaleDateString(
    'id-ID',
    {
      weekday: 'long',
      day: 'numeric',
      month: 'long',
      year: 'numeric',
    }
  )

  // Fetch langsung dari API lokal
  const fetchEvents = async () => {
    setIsLoading(true)
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_BASE_URL}/api/content?date=${dateFormatted}`, {
        method: 'GET',
      })
      if (!res.ok) throw new Error('Gagal fetch konten')
      const data = await res.json()
      setEvents(Array.isArray(data) ? data : [data]) // handle kalau API ngasih object tunggal
    } catch (err) {
      console.error('Error fetching content:', err)
      setEvents([])
    } finally {
      setIsLoading(false)
    }
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
              <h1 className="text-4xl font-extrabold mb-2">Calendar Of Content</h1>
              <p className="text-white/50 text-lg">Lihat jadwal konten</p>
            </div>

            <section className="grid grid-cols-1 lg:grid-cols-[2fr_1fr] gap-8 mb-12">
              {/* Kiri: Kalender */}
              <div className="space-y-8">
                <Calendar selectedDate={selectedDate} setSelectedDate={setSelectedDate} />
              </div>

              {/* Kanan: Motivasi & Daftar Konten */}
              <div className="space-y-8">
                {/* Motivasi */}
                <div className="bg-gradient-to-br from-[#1f1f2b] to-[#121212] p-6 rounded-3xl shadow-xl border border-white/5">
                  <h2 className="text-xl font-bold mb-3">🔥 Motivasi Hari Ini</h2>
                  <p className="text-white/80 italic">SEMANGAT PAGI! 🔥👍🏻</p>
                  <div className="text-sm text-white/30 mt-4">#KELAZZKING</div>
                </div>

                {/* Konten Hari Ini */}
                <div className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl p-6">
                  <h2 className="text-xl font-bold mb-5">📅 {formattedDateString}</h2>

                  {isLoading ? (
                    <div className="text-center py-8">
                      <div className="relative w-8 h-8 mx-auto">
                        <div className="absolute inset-0 border-[3px] border-white border-t-transparent rounded-full animate-spin"></div>
                      </div>
                      <p className="text-sm font-medium text-white/70 animate-pulse mt-2">Memuat konten...</p>
                    </div>
                  ) : (
                    <ul className="space-y-4 text-sm text-white/80">
                      {events.length === 0 ? (
                        <p className="text-white/40 text-center italic">Belum ada konten</p>
                      ) : (
                        events.map((event, i) => (
                          <li
                            key={i}
                            className="bg-[#1a1a1a] p-4 rounded-xl border border-white/10 hover:border-white/20 transition-all group relative"
                          >
                            <div className="flex items-start justify-between">
                              <div className="flex-1">
                                <p className="text-white font-semibold mb-1">{(event.content_title || '-').slice(0, 25)}</p>
                                <p className="text-white/50 mb-2 text-clip">{(event.content_caption || '-').slice(0, 30)}</p>
                                <div className="flex items-center gap-2 text-xs text-white/40">
                                  <UserIcon />
                                  <span>{event.user_name || 'Tidak dikenal'}</span>
                                </div>
                              </div>

                              <div className="relative">
                                <button
                                  onClick={() => {
                                    setSelectedContent(event)
                                    setModalOpen(true)
                                  }}
                                  className="text-white/40 hover:bg-white/10 transition-transform hover:text-white p-2 rounded-full cursor-pointer"
                                >
                                  <SquarePen size={18} />
                                </button>
                              </div>
                            </div>
                          </li>
                        ))
                      )}
                    </ul>
                  )}
                </div>
              </div>
            </section>
          </main>

          {/* Modal Konten */}
          <ContentModalCOC isOpen={modalOpen} selectedContent={selectedContent} onClose={() => setModalOpen(false)} />
        </div>

        {/* Sidebar Mobile */}
        <Sidebar isMobile isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />

        {/* Backdrop */}
        {sidebarOpen && <div onClick={() => setSidebarOpen(false)} className="fixed inset-0 bg-black/50 z-30 md:hidden" />}
      </div>
    </AuthGuard>
  )
}

export default App
