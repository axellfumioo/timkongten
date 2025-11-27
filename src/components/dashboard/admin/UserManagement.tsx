'use client'

import { useState, useCallback } from 'react'
import { UserPlus } from 'lucide-react'
import AuthGuard from '@/components/AuthGuard'
import UserModal from '@/components/dashboard/admin/UserModal'
import UserTable from '@/components/dashboard/admin/UserTable'

interface User {
    id: string
    name: string
    email: string
    role: string
}

export default function UserManagement() {
    const [modalOpen, setModalOpen] = useState(false)
    const [selectedUser, setSelectedUser] = useState<User | null>(null)

    const handleAddUser = useCallback(() => {
        setSelectedUser(null)
        setModalOpen(true)
    }, [])

    const handleEditUser = useCallback((user: User) => {
        setSelectedUser(user)
        setModalOpen(true)
    }, [])

    const handleCloseModal = useCallback(() => {
        setModalOpen(false)
        setSelectedUser(null)
    }, [])

    return (
        <AuthGuard>
            <main className="flex-1 overflow-y-auto bg-[#0A0A0A] px-4 py-6">
                {/* Header Section */}
                <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-8">
                    <div>
                        <h1 className="text-3xl font-bold text-white flex items-center gap-2">
                            👥 Manajemen Pengguna
                        </h1>
                        <p className="text-white/50 text-sm mt-1">
                            Kelola akses dan peran pengguna sistem
                        </p>
                    </div>
                    <button
                        onClick={handleAddUser}
                        className="flex items-center gap-2 bg-white text-black text-sm font-semibold px-5 py-2.5 rounded-lg hover:bg-gray-200 active:scale-95 transition-all shadow-lg hover:shadow-xl"
                        aria-label="Tambah pengguna baru"
                    >
                        <UserPlus size={18} />
                        <span>Tambah Pengguna</span>
                    </button>
                </div>

                {/* User Table */}
                <UserTable
                    setSelectedUser={handleEditUser}
                    setModalOpen={setModalOpen}
                />

                {/* User Modal */}
                <UserModal
                    isOpen={modalOpen}
                    onClose={handleCloseModal}
                    selectedUser={selectedUser}
                />
            </main>
        </AuthGuard>
    )
}
