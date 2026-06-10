'use client'

import { useEffect, useState } from 'react'
import { Trophy, Medal, Search, MailIcon, UserIcon } from 'lucide-react'
import AuthGuard from '@/components/AuthGuard'

interface LeaderboardUser {
  id: string
  name: string
  email: string
  role: string
  points: number
  rank: number
}

export default function Leaderboard() {
  const [users, setUsers] = useState<LeaderboardUser[]>([])
  const [filteredUsers, setFilteredUsers] = useState<LeaderboardUser[]>([])
  const [searchTerm, setSearchTerm] = useState('')
  const [isLoading, setIsLoading] = useState(false)

  useEffect(() => {
    const fetchLeaderboard = async () => {
      setIsLoading(true)
      try {
        const res = await fetch('/api/admin/leaderboard')
        const data = await res.json()
        if (res.ok) {
          const withRank = (data || []).map((u: any, idx: number) => ({ ...u, rank: idx + 1 }))
          setUsers(withRank)
          setFilteredUsers(withRank)
        } else {
          console.error("Failed to fetch leaderboard:", data?.error)
        }
      } catch (err) {
        console.error("Error fetching leaderboard:", err)
      } finally {
        setIsLoading(false)
      }
    }

    fetchLeaderboard()
  }, [])

  useEffect(() => {
    const term = searchTerm.toLowerCase()
    const filtered = users.filter(
      (user) =>
        user.name.toLowerCase().includes(term) ||
        user.email.toLowerCase().includes(term)
    )
    setFilteredUsers(filtered)
  }, [searchTerm, users])

  const getRankDisplay = (rank: number) => {
    if (rank === 1) return <Trophy className="text-yellow-400" size={28} />
    if (rank === 2) return <Medal className="text-gray-300" size={28} />
    if (rank === 3) return <Medal className="text-amber-600" size={28} />
    return <span className="text-white/40 font-bold text-xl w-7 text-center">{rank}</span>
  }

  const formatRole = (role: string) => {
    if (role === 'ba') return 'Brand Ambassador'
    if (role === 'timkonten') return 'Tim Konten'
    if (role === 'admin') return 'Admin'
    return role
  }

  return (
    <div className="space-y-4">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
        <div>
          <h1 className="text-3xl font-bold text-white flex items-center gap-2">
            🏆 Peringkat
          </h1>
          <p className="text-white/50 text-sm mt-1">
            Peringkat pengguna berdasarkan poin terbanyak hingga terendah
          </p>
        </div>
      </div>

      <div className="space-y-4">
        {/* Search Bar */}
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-white/40" size={18} />
          <input
            type="text"
            placeholder="Cari pengguna berdasarkan nama atau email..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full bg-[#1f1f1f] border border-white/10 text-sm text-white rounded-xl py-2 pl-10 pr-4 focus:outline-none focus:border-white/20 transition"
          />
        </div>

        {isLoading ? (
          <div className="text-sm text-white/60 animate-pulse px-4 py-6 bg-[#1f1f1f] rounded-xl border border-white/10 text-center">
            Memuat data peringkat...
          </div>
        ) : filteredUsers.length === 0 ? (
          <div className="text-sm text-white/40 italic px-4 py-6 bg-[#1f1f1f] rounded-xl border border-white/10 text-center">
            {searchTerm ? 'Tidak ada pengguna yang cocok dengan pencarian.' : 'Belum ada data peringkat'}
          </div>
        ) : (
          filteredUsers.map((user) => (
            <div
              key={user.id}
              className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl px-4 py-4 flex justify-between items-center hover:border-white/20 transition"
            >
              <div className="flex items-center gap-4 sm:gap-6">
                <div className="flex items-center justify-center w-8 sm:w-12">
                  {getRankDisplay(user.rank)}
                </div>
                <div>
                  <p className="font-semibold text-white text-lg">{user.name}</p>
                  <div className="text-sm text-white/60 flex items-center gap-2 mt-1">
                    <MailIcon size={14} className="text-white/50" />
                    <span>{user.email}</span>
                  </div>
                  <div className="text-sm text-white/50 flex items-center gap-2 mt-0.5">
                    <UserIcon size={14} className="text-white/40" />
                    <span>{formatRole(user.role)}</span>
                  </div>
                </div>
              </div>

              <div className="flex flex-col items-end justify-center px-2 sm:px-4">
                <span className="text-3xl font-bold text-green-400">{user.points}</span>
                <span className="text-xs text-white/50 font-medium">Poin</span>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  )
}
