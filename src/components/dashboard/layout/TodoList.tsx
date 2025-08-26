'use client'

import { useState, useEffect } from 'react'
import { UserIcon, SquarePen } from 'lucide-react'
import { useGlobalStore } from '@/app/lib/global-store'
import ContentModalCOC from './journal/contentModal/ContentModalCOC'

interface SelectedDate {
  day: number
  month: number // 0-11
  year: number
}

interface ContentEvent {
  content_title: string
  content_type: string
  content_caption: string
  content_date: string
  user_name: string
  users?: {
    name: string
  }
}

function getTodayDate(): SelectedDate {
  const today = new Date()
  return {
    day: today.getDate(),
    month: today.getMonth(),
    year: today.getFullYear(),
  }
}

export default function TodoList() {
  const [isLoading, setIsLoading] = useState(false)
  const [modalOpen, setModalOpen] = useState(false)
  const [events, setEvents] = useState<ContentEvent[]>([])
  const [selectedContent, setSelectedContent] = useState<ContentEvent | null>(null)
  const updated = useGlobalStore((state) => state.updated)
  const setUpdated = useGlobalStore((state) => state.setUpdated)
  const [selectedDate, setSelectedDate] = useState<SelectedDate>(getTodayDate)

  const selectedDateStr = `${selectedDate.year}-${String(selectedDate.month + 1).padStart(2, '0')}-${String(selectedDate.day).padStart(2, '0')}`

  useEffect(() => {
    const fetchEvents = async () => {
      setIsLoading(true)
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_BASE_URL}/api/content?date=${selectedDateStr}`)
        if (!res.ok) throw new Error('Failed to fetch events')

        const response = await res.json()

        // Ambil array dari data.data, fallback ke array kosong
        const eventsArray = response.data ?? []

        setEvents(eventsArray)
      } catch (error) {
        console.error('Error fetching events:', error)
        setEvents([])
      } finally {
        setUpdated(false)
        setIsLoading(false)
      }
    }


    fetchEvents()
  }, [updated, selectedDateStr, setUpdated])

  const filteredEvents = events.filter((e) => e.content_date === selectedDateStr)

  const formatted = new Date(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day
  ).toLocaleDateString('id-ID', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  })

  return (
    <div className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl p-6 w-full">
      <h2 className="text-xl font-bold mb-4 flex items-center gap-2">
        📝 Konten Hari Ini ({formatted})
      </h2>
      <ul className="space-y-4 text-sm">
        {isLoading ? (
          <div className="flex items-center justify-center px-4 py-8">
            <div className="text-center space-y-4">
              <div className="relative w-8 h-8 mx-auto">
                <div className="absolute inset-0 rounded-full border-[3px] border-white border-t-transparent animate-spin"></div>
              </div>
              <p className="text-sm font-medium text-white/70 animate-pulse">
                Memuat konten...
              </p>
            </div>
          </div>
        ) : filteredEvents.length === 0 ? (
          <p className="text-white/40 text-center italic">Belum ada konten</p>
        ) : (
          filteredEvents.map((task, i) => (
            <li
              key={i}
              className="bg-[#1a1a1a] p-4 rounded-xl border border-white/10 hover:border-white/20 transition-all duration-200 group relative"
            >
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <p className="text-white font-semibold mb-1">{task.content_title}</p>
                  <p className="text-white/50 mb-2">{task.content_caption}</p>
                  <div className="flex items-center gap-2 text-xs text-white/40">
                    <UserIcon size={14} />
                    <span>{task.user_name}</span>
                  </div>
                </div>
                <div className="relative">
                  <button
                    onClick={() => {
                      setSelectedContent(task)
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

      {/* Modal Konten */}
      <ContentModalCOC
        isOpen={modalOpen}
        selectedContent={selectedContent}
        onClose={() => setModalOpen(false)}
      />
    </div>
  )
}
