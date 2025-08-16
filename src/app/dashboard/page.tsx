'use client'

import React, { useState, useEffect } from 'react';
import {
  BookCheck,
  CalendarDays,
  CheckCircle,
  Menu,
} from 'lucide-react';
import Sidebar from '@/components/dashboard/common/Sidebar';
import TodoList from '@/components/dashboard/layout/TodoList';
import AuthGuard from '@/components/AuthGuard';

interface SelectedDate {
  day: number
  month: number
  year: number
}

interface ContentStats {
  total: number
  yours: number
  scheduled: number
}

function getTodayDate(): SelectedDate {
  const today = new Date()
  return {
    day: today.getDate(),
    month: today.getMonth(),
    year: today.getFullYear(),
  }
}

function App() {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [selectedDate, setSelectedDate] = useState<SelectedDate>(() => getTodayDate());
  const [stats, setStats] = useState<ContentStats>({
    total: 0,
    yours: 0,
    scheduled: 0
  });
  const [loading, setLoading] = useState(false);

  const formatted = new Date(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day
  ).toLocaleDateString('id-ID', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  });

  // Fetch ke API sesuai tanggal

  return (
    <AuthGuard>
      <div className="flex h-screen bg-[#0a0a0a] text-white">
        {/* Desktop Sidebar */}
        <Sidebar />

        {/* Mobile Layout */}
        <div className="flex flex-col flex-1">
          {/* Mobile Navbar */}
          <div className="md:hidden flex items-center justify-between px-5 py-4 border-b border-white/10 bg-[#0a0a0a] shadow-sm">
            <h2 className="text-xl font-semibold tracking-tight text-white">
              Tim Konten
            </h2>
            <button onClick={() => setSidebarOpen(true)} aria-label="Open menu">
              <Menu size={28} className="text-white" />
            </button>
          </div>

          {/* Main Content */}
          <main className="flex-1 px-5 sm:px-10 pt-10 bg-[#0a0a0a] mt-0 md:mt-0 overflow-y-auto">
            <div className="mb-6">
              <h1 className="text-4xl font-extrabold tracking-tight mb-2">Hey Axel! 😀</h1>
              <p className="text-white/50 text-lg">
                Lihat statistik lengkap kamu di halaman ini ({formatted})
              </p>
            </div>

            <section className="mb-12">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="p-6 bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl transition-all">
                  <CheckCircle className="text-green-400 mb-2" />
                  <p className="text-3xl font-bold">{loading ? "..." : stats.total}</p>
                  <p className="text-sm text-gray-400">Total Konten</p>
                </div>
                <div className="p-6 bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl transition-all">
                  <BookCheck className="text-indigo-400 mb-2" />
                  <p className="text-3xl font-bold">{loading ? "..." : stats.yours}</p>
                  <p className="text-sm text-gray-400">Konten Kamu</p>
                </div>
                <div className="p-6 bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl transition-all">
                  <CalendarDays className="text-yellow-400 mb-2" />
                  <p className="text-3xl font-bold">{loading ? "..." : stats.scheduled}</p>
                  <p className="text-sm text-gray-400">Konten Terjadwal</p>
                </div>
              </div>
            </section>

            {/* Folder Section */}
            <section className="w-full gap-8 mb-12">
              <TodoList />
            </section>
          </main>
        </div>

        {/* Mobile Sidebar */}
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
  );
}

export default App;
