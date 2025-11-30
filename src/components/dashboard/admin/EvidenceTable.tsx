'use client'

import { useEffect, useState } from 'react'
import { Check, X, Search, Image as ImageIcon, DownloadCloud } from 'lucide-react'
import { supabase } from '@/app/lib/supabase'
import { useGlobalStore } from '@/app/lib/global-store'
import EvidenceModal from '../layout/journal/contentModal/EvidenceModal'

interface User {
  id: string
  email: string
  name: string
}

interface Evidence {
  id: string
  user_email: string
  evidence_title: string
  evidence_description: string
  evidence_date: string
  evidence_job?: string
  status: 'pending' | 'accepted' | 'declined'
  completion_proof?: string
  users?: {
    email: string
    name: string
    role: string
  } | null
}

export default function EvidenceTable() {
  const [evidences, setEvidences] = useState<Evidence[]>([])
  const [filtered, setFiltered] = useState<Evidence[]>([])
  const [searchTerm, setSearchTerm] = useState('')
  const [isLoading, setIsLoading] = useState(false)

  const [proofOpen, setProofOpen] = useState(false)
  const [selectedId, setSelectedId] = useState<string | null>(null)
  const [loadingId, setLoadingId] = useState<string | null>(null)
  const [loadingAction, setLoadingAction] = useState<'accepted' | 'declined' | null>(null)

  const updated = useGlobalStore((state) => state.updated)
  const setUpdated = useGlobalStore((state) => state.setUpdated)

  // ✅ state users bener
  const [users, setUsers] = useState<User[]>([])
  const [selectedUser, setSelectedUser] = useState<string>("")
  const [startDate, setStartDate] = useState("")
  const [endDate, setEndDate] = useState("")
  const [isUserRecap, setIsUserRecap] = useState(false)

  // fetch evidence
  const fetchEvidences = async () => {
    setIsLoading(true)
    const { data, error } = await supabase
      .from("evidence")
      .select(`
        *,
        users:user_email (
          email,
          name,
          role
        )
      `)
      .eq("evidence_status", "pending")
      .order("evidence_date", { ascending: false })

    if (error) {
      console.error("Error fetching evidences:", error)
      setIsLoading(false)
      return
    }

    setEvidences((data as Evidence[]) || [])
    setFiltered((data as Evidence[]) || [])
    setIsLoading(false)
  }

  useEffect(() => {
    fetchEvidences()
  }, [updated])

  // filter search
  useEffect(() => {
    const term = searchTerm.toLowerCase()
    setFiltered(
      evidences.filter(
        (ev) =>
          ev.evidence_title.toLowerCase().includes(term) ||
          ev.user_email.toLowerCase().includes(term) ||
          (ev.evidence_job?.toLowerCase() || '').includes(term)
      )
    )
  }, [searchTerm, evidences])

  // fetch users
  useEffect(() => {
    const fetchUsers = async () => {
      const { data, error } = await supabase
        .from("users")
        .select("id, email, name")
        .order("id", { ascending: true })

      if (error) {
        console.error("Error fetching users:", error)
      } else {
        setUsers(data as User[])
      }
    }

    fetchUsers()
  }, [])

  // ubah status evidence
  const handleStatusChange = async (id: string, newStatus: 'accepted' | 'declined') => {
    setLoadingId(id)
    setLoadingAction(newStatus)
    try {
      const res = await fetch(`/api/evidences/${id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status: newStatus })
      })

      const result = await res.json()
      if (!res.ok) {
        console.error(result.error || 'Gagal update status')
        setLoadingId(null)
        setLoadingAction(null)
        return
      }

      // Refresh table setelah berhasil update
      await fetchEvidences()
    } catch (err) {
      console.error('Error updating status:', err)
    } finally {
      setLoadingId(null)
      setLoadingAction(null)
    }
  }

  // download recap
  const handleDownload = () => {
    if (!startDate || !endDate) {
      alert("Pilih start date dan end date dulu!")
      return
    }

    let url = ""

    if (isUserRecap) {
      if (!selectedUser) {
        alert("Pilih user dulu untuk rekap siswa!")
        return
      }

      const formattedStart = new Date(startDate).toISOString().split("T")[0] // YYYY-MM-DD
      const formattedEnd = new Date(endDate).toISOString().split("T")[0]

      url = `${process.env.NEXT_PUBLIC_BASE_URL}/api/evidences/download/user?user=${encodeURIComponent(
        selectedUser
      )}&start_date=${formattedStart}&end_date=${formattedEnd}`
    } else {
      const formattedStart = new Date(startDate).toISOString().split("T")[0]
      const formattedEnd = new Date(endDate).toISOString().split("T")[0]

      url = `${process.env.NEXT_PUBLIC_BASE_URL}/api/evidences/download?start_date=${formattedStart}&end_date=${formattedEnd}`
    }

    window.open(url, "_blank")
  }

  return (
    <main className="flex-1 overflow-y-auto bg-[#0A0A0A] px-4 py-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-white">🪙 Manajemen Poin</h1>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        {/* Table Column */}
        <div className="lg:col-span-3 space-y-5">
          {/* Search */}
          <div className="relative">
            <input
              type="text"
              placeholder="Cari evidence..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full bg-white/5 backdrop-blur-lg border border-white/10 text-sm text-white rounded-2xl py-3 pl-12 pr-4"
            />
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-white/40" size={18} />
          </div>

          {/* Table */}
          <div className="overflow-x-auto rounded-2xl border border-white/10 bg-white/5 backdrop-blur-lg shadow-lg">
            {isLoading ? (
              <div className="text-sm text-white/60 animate-pulse px-4 py-6 text-center">
                Memuat data evidence...
              </div>
            ) : filtered.length === 0 ? (
              <div className="text-sm text-white/40 italic px-4 py-6 text-center">
                {searchTerm ? 'Tidak ada evidence yang cocok.' : 'Belum ada evidence pending.'}
              </div>
            ) : (
              <table className="w-full text-sm text-left text-white">
                <thead className="text-xs uppercase text-white/60 border-b border-white/10">
                  <tr>
                    <th className="px-4 py-3">Bukti</th>
                    <th className="px-4 py-3">Judul</th>
                    <th className="px-4 py-3">Deskripsi</th>
                    <th className="px-4 py-3">Job</th>
                    <th className="px-4 py-3">Tanggal</th>
                    <th className="px-4 py-3">User</th>
                    <th className="px-4 py-3 text-center">Aksi</th>
                  </tr>
                </thead>
                <tbody>
                  {filtered.map((ev) => (
                    <tr key={ev.id} className="border-b border-white/5 hover:bg-white/5 transition">
                      <td className="px-4 py-3">
                        {ev.completion_proof ? (
                          <div
                            className="relative w-16 h-16 rounded-lg overflow-hidden border border-white/10 cursor-pointer group"
                            onClick={() => {
                              setSelectedId(ev.id)
                              setProofOpen(true)
                            }}
                          >
                            <img
                              src={ev.completion_proof}
                              alt="Proof"
                              className="w-full h-full object-cover transition-transform duration-300 group-hover:scale-105"
                            />
                            <div className="absolute inset-0 flex items-center justify-center bg-black/40 opacity-0 group-hover:opacity-100 transition">
                              <Search className="w-5 h-5 text-white drop-shadow" />
                            </div>
                          </div>
                        ) : (
                          <div className="w-16 h-16 flex items-center justify-center bg-white/5 rounded-lg border border-white/10 text-white/40">
                            <ImageIcon size={18} />
                          </div>
                        )}
                      </td>
                      <td className="px-4 py-3 font-medium">{ev.evidence_title}</td>
                      <td className="px-4 py-3 text-white/60 line-clamp-2 max-w-xs">{ev.evidence_description}</td>
                      <td className="px-4 py-3 text-white/60">{ev.evidence_job || '-'}</td>
                      <td className="px-4 py-3 text-white/60">{ev.evidence_date}</td>
                      <td className="px-4 py-3 text-white/60">{ev.users?.name || '-'}</td>
                      <td className="px-4 py-3 text-center">
                        <div className="flex justify-center gap-2">
                          <button
                            onClick={() => handleStatusChange(ev.id, 'accepted')}
                            disabled={loadingId === ev.id}
                            className="px-3 py-1 rounded-lg bg-green-500/10 text-green-400 hover:bg-green-500/20 transition flex items-center gap-1 disabled:opacity-50 disabled:cursor-not-allowed"
                          >
                            {loadingId === ev.id && loadingAction === 'accepted' ? (
                              <div className="w-4 h-4 border-2 border-green-400 border-t-transparent rounded-full animate-spin" />
                            ) : (
                              <Check size={16} />
                            )}
                            <span className="hidden lg:inline">
                              {loadingId === ev.id && loadingAction === 'accepted' ? 'Loading...' : 'Terima'}
                            </span>
                          </button>
                          <button
                            onClick={() => handleStatusChange(ev.id, 'declined')}
                            disabled={loadingId === ev.id}
                            className="px-3 py-1 rounded-lg bg-red-500/10 text-red-400 hover:bg-red-500/20 transition flex items-center gap-1 disabled:opacity-50 disabled:cursor-not-allowed"
                          >
                            {loadingId === ev.id && loadingAction === 'declined' ? (
                              <div className="w-4 h-4 border-2 border-red-400 border-t-transparent rounded-full animate-spin" />
                            ) : (
                              <X size={16} />
                            )}
                            <span className="hidden lg:inline">
                              {loadingId === ev.id && loadingAction === 'declined' ? 'Loading...' : 'Tolak'}
                            </span>
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            )}
          </div>
        </div>

        {/* Stats Column */}
        <div className="space-y-5">
          <div className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl p-6">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-sm font-semibold text-white flex items-center gap-2">
                <DownloadCloud size={18} className="text-white/80" />
                Download Recap Evidence
              </h2>
            </div>

            {/* Checkbox Recap Type */}
            <div className="flex items-center gap-2 mb-4">
              <input
                type="checkbox"
                id="recapType"
                checked={isUserRecap}
                onChange={(e) => setIsUserRecap(e.target.checked)}
                className="w-4 h-4 accent-blue-500 cursor-pointer"
              />
              <label htmlFor="recapType" className="text-sm text-white/90 cursor-pointer">
                Rekap persiswa
              </label>
            </div>

            {/* User Dropdown */}
            {isUserRecap && (
              <div className="flex flex-col items-start pb-4 w-full">
                <label htmlFor="users" className="mb-1 text-sm font-medium text-white/90">
                  Select User
                </label>
                <select
                  id="users"
                  name="users"
                  value={selectedUser}
                  onChange={(e) => setSelectedUser(e.target.value)}
                  className="rounded-lg w-full border border-white/20 bg-white/10 text-white text-sm px-3 py-2"
                >
                  <option value="">-- Pilih User --</option>
                  {users.map((user) => (
                    <option key={user.id} value={user.email} className="bg-gray-800 text-white">
                      {user.name} ({user.email})
                    </option>
                  ))}
                </select>
              </div>
            )}

            {/* Start Date */}
            <div className="flex flex-col items-start pb-4 w-full">
              <label htmlFor="start_date" className="mb-1 text-sm font-medium text-white/90">
                Start Date
              </label>
              <input
                id="start_date"
                name="start_date"
                type="date"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
                className="rounded-lg w-full border border-white/20 bg-white/10 text-white text-sm px-3 py-2"
              />
            </div>

            {/* End Date */}
            <div className="flex flex-col items-start w-full">
              <label htmlFor="end_date" className="mb-1 text-sm font-medium text-white/90">
                End Date
              </label>
              <input
                id="end_date"
                name="end_date"
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
                className="rounded-lg w-full border border-white/20 bg-white/10 text-white text-sm px-3 py-2"
              />
            </div>

            {/* Download Button */}
            <button
              onClick={handleDownload}
              className="mt-4 w-full bg-white text-[#0a0a0a] cursor-pointer text-sm font-medium py-2 px-4 rounded-lg transition"
            >
              Download Recap
            </button>
          </div>
        </div>
      </div>

      {/* Modal */}
      <EvidenceModal
        proofOpen={proofOpen}
        selectedId={selectedId}
        setProofOpen={setProofOpen}
      />
    </main>
  )
}
