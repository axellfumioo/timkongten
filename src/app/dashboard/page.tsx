'use client'

import React, { useCallback, useEffect, useState } from 'react';
import {
  BookCheck,
  CheckCircle,
  Menu,
  ScrollText,
} from 'lucide-react';
import Sidebar from '@/components/dashboard/common/Sidebar';
import TodoList from '@/components/dashboard/layout/TodoList';
import AuthGuard from '@/components/AuthGuard';
import { useSession } from "next-auth/react";

interface SelectedDate {
  day: number
  month: number
  year: number
}

interface ContentStats {
  content: number
  evidence: number
  scheduled: number
  user_evidences: number
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
  const { data: session } = useSession();
  const user = session?.user;
  const [stats, setStats] = useState<ContentStats>({
    content: 0,
    evidence: 0,
    scheduled: 0,
    user_evidences: 0
  });
  const [loading, setLoading] = useState(false);
  const [lastUpdated, setLastUpdated] = useState<string | null>(null);

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

  const fetchStats = useCallback(async () => {
    if (!user?.email) return;

    setLoading(true);
    try {
      const response = await fetch(`/api/stats?email=${encodeURIComponent(user.email)}`);
      if (!response.ok) throw new Error("Failed to fetch stats");
      const data = await response.json();

      setStats({
        content: data.stats?.total_contents || 0,
        evidence: data.stats?.total_evidences || 0,
        scheduled: 0,
        user_evidences: data.stats?.user_evidences || 0
      });
      setLastUpdated(
        new Date().toLocaleTimeString('id-ID', {
          hour: '2-digit',
          minute: '2-digit',
        })
      );
    } catch (error) {
      console.error("Error fetching stats:", error);
    } finally {
      setLoading(false);
    }
  }, [user?.email]);

  useEffect(() => {
    fetchStats();
  }, [fetchStats]);

  return (
    <AuthGuard>
      <div className="flex h-screen bg-[#0a0a0a] text-white">
        <Sidebar />

        <div className="flex flex-col flex-1">
          <div className="md:hidden flex items-center justify-between px-5 py-4 border-b border-white/10 bg-[#0a0a0a] shadow-sm">
            <h2 className="text-xl font-semibold tracking-tight text-white">
              Tim Konten
            </h2>
            <button onClick={() => setSidebarOpen(true)} aria-label="Open menu">
              <Menu size={28} className="text-white" />
            </button>
          </div>

          <main className="flex-1 px-5 sm:px-10 pt-10 bg-[#0a0a0a] mt-0 md:mt-0 overflow-y-auto">
            <div className="mb-6">
              <h1 className="text-4xl font-extrabold tracking-tight mb-2">Hey {user?.name?.substring(0, 12)}! 😀</h1>
              <div className="flex flex-wrap items-center gap-3 text-white/50 text-lg">
                <span>Statistik konten SMK Telkom Purwokerto</span>
                <button
                  onClick={fetchStats}
                  disabled={loading}
                  className="text-xs px-3 py-1 rounded-full border border-white/10 text-white/70 hover:text-white hover:border-white/20 transition disabled:opacity-50"
                >
                  Refresh
                </button>
                {lastUpdated && (
                  <span className="text-xs text-white/40">Update {lastUpdated}</span>
                )}
              </div>
            </div>

            <section className="mb-12">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="p-6 bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl transition-all">
                  <ScrollText className="text-green-400 mb-2" />
                  <p className={`text-3xl font-bold ${loading ? "text-white/40 animate-pulse" : ""}`}>
                    {loading ? "—" : stats.user_evidences}
                  </p>
                  <p className="text-sm text-gray-400">Poin Saya</p>
                </div>
                <div className="p-6 bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl transition-all">
                  <CheckCircle className="text-green-400 mb-2" />
                  <p className={`text-3xl font-bold ${loading ? "text-white/40 animate-pulse" : ""}`}>
                    {loading ? "—" : stats.evidence}
                  </p>
                  <p className="text-sm text-gray-400">Total Poin (semua siswa)</p>
                </div>
                <div className="p-6 bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl transition-all">
                  <BookCheck className="text-indigo-400 mb-2" />
                  <p className={`text-3xl font-bold ${loading ? "text-white/40 animate-pulse" : ""}`}>
                    {loading ? "—" : stats.content}
                  </p>
                  <p className="text-sm text-gray-400">Total Konten (semua siswa)</p>
                </div>
              </div>
            </section>

            <section className="w-full gap-8 mb-12">
              <TodoList />
            </section>
          </main>
        </div>

        <Sidebar isMobile isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />

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
