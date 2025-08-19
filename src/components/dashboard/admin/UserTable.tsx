'use client'

import { useEffect, useState } from 'react'
import { TrashIcon, SquarePen, MailIcon, UserIcon, Search } from 'lucide-react'
import { supabase } from '@/app/lib/supabase'
import { useGlobalStore } from '@/app/lib/global-store'
import ConfirmationModal from '@/components/dashboard/layout/confirmationModal'

interface User {
  id: string
  name: string
  email: string
  role: string
}

export default function UserTable({ setSelectedUser, setModalOpen }: any) {
  const [users, setUsers] = useState<User[]>([])
  const [filteredUsers, setFilteredUsers] = useState<User[]>([])
  const [searchTerm, setSearchTerm] = useState('')
  const [isLoading, setIsLoading] = useState(false)
  const [userToDelete, setUserToDelete] = useState<User | null>(null)
  const [confirmOpen, setConfirmOpen] = useState(false)
  const [loadingDelete, setLoadingDelete] = useState(false);

  const updated = useGlobalStore((state) => state.updated)
  const setUpdated = useGlobalStore((state) => state.setUpdated)

  const confirmDelete = async () => {
    setLoadingDelete(true);
    if (!userToDelete) return
    try {
      await supabase.from('users').delete().eq('id', userToDelete.id)
      setUpdated(true)
      setUserToDelete(null)
    } finally {
      setLoadingDelete(false);
    }
  }

  useEffect(() => {
    const fetchUsers = async () => {
      setIsLoading(true)
      const { data, error } = await supabase.from('users').select('*')
      if (!error) {
        setUsers(data || [])
        setFilteredUsers(data || [])
      }
      setIsLoading(false)
      setUpdated(false)
    }

    fetchUsers()
  }, [updated])

  useEffect(() => {
    const term = searchTerm.toLowerCase()
    const filtered = users.filter(
      (user) =>
        user.name.toLowerCase().includes(term) ||
        user.email.toLowerCase().includes(term)
    )
    setFilteredUsers(filtered)
  }, [searchTerm, users])

  return (
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
          Memuat data pengguna...
        </div>
      ) : filteredUsers.length === 0 ? (
        <div className="text-sm text-white/40 italic px-4 py-6 bg-[#1f1f1f] rounded-xl border border-white/10 text-center">
          {searchTerm ? 'Tidak ada pengguna yang cocok dengan pencarian.' : 'Belum ada pengguna'}
        </div>
      ) : (
        filteredUsers.map((user) => (
          <div
            key={user.id}
            className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl px-4 py-4 flex justify-between items-center hover:border-white/20 transition"
          >
            <div>
              <p className="font-semibold text-white">{user.name}</p>
              <div className="text-sm text-white/60 flex items-center gap-2 mt-1">
                <MailIcon size={16} className="text-white/50" />
                <span>{user.email}</span>
              </div>
              <div className="text-sm text-white/50 flex items-center gap-2 mt-0.5">
                <UserIcon size={16} className="text-white/40" />
                <span className="capitalize">{user.role}</span>
              </div>
            </div>

            <div className="flex gap-2">
              <button
                onClick={() => {
                  setSelectedUser(user)
                  setModalOpen(true)
                }}
                className="p-2 rounded hover:bg-white/10 transition"
                title="Edit"
              >
                <SquarePen size={18} />
              </button>
              <button
                onClick={() => {
                  setUserToDelete(user)
                  setConfirmOpen(true)
                }}
                className="p-2 rounded hover:bg-red-500/10 text-red-400 hover:text-red-500 transition"
                title="Hapus"
              >
                <TrashIcon size={18} />
              </button>

            </div>
          </div>
        ))
      )}
      <ConfirmationModal
        isOpen={confirmOpen}
        onClose={() => {
          setConfirmOpen(false)
          setUserToDelete(null)
        }}
        title="Hapus pengguna"
        description={`Yakin ingin menghapus ${userToDelete?.name}? Aksi ini tidak bisa dibatalkan.`}
        onConfirm={confirmDelete}
        confirmLabel={
          loadingDelete ? (
            <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
          ) : (
            "Hapus"
          )
        }
        cancelLabel="Batal"
      />

    </div>
  )
}
