import { useEffect, useState } from 'react'
import { Menu } from 'lucide-react'
import Sidebar from '@/components/dashboard/common/Sidebar'
import AuthGuard from '@/components/AuthGuard'
import UserModal from '@/components/dashboard/admin/UserModal'
import UserTable from '@/components/dashboard/admin/UserTable'
import { useGlobalStore } from '@/app/lib/global-store'
import { supabase } from '@/app/lib/supabase'

interface User {
    id: string
    name: string
    email: string
    role: string
}

export default function UserManagement() {
    const [sidebarOpen, setSidebarOpen] = useState(false)
    const [users, setUsers] = useState<User[]>([])
    const [isLoading, setIsLoading] = useState(false)
    const [modalOpen, setModalOpen] = useState(false)
    const [selectedUser, setSelectedUser] = useState<User | null>(null)

    const updated = useGlobalStore((state) => state.updated)
    const setUpdated = useGlobalStore((state) => state.setUpdated)
    return (
        <AuthGuard>
            <main className="flex-1 overflow-y-auto bg-[#0A0A0A] px-4">
                <div className="flex justify-between items-center mb-6">
                    <h1 className="text-2xl font-bold">👥 Manajemen Pengguna</h1>
                    <button
                        onClick={() => {
                            setSelectedUser(null)
                            setModalOpen(true)
                        }}
                        className="bg-white text-black text-sm font-medium px-4 py-2 rounded hover:bg-gray-200 transition"
                    >
                        + Tambah Pengguna
                    </button>
                </div>

                <UserTable
                    setSelectedUser={setSelectedUser}
                    setModalOpen={setModalOpen}
                />

                <UserModal
                    isOpen={modalOpen}
                    onClose={() => setModalOpen(false)}
                    selectedUser={selectedUser}
                />
            </main>
        </AuthGuard>
    )
}
