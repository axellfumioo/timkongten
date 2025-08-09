'use client'

import { useEffect, useState } from 'react'
import { Menu } from 'lucide-react'
import Sidebar from '@/components/dashboard/common/Sidebar'
import AuthGuard from '@/components/AuthGuard'
import UserModal from '@/components/dashboard/admin/UserModal'
import UserTable from '@/components/dashboard/admin/UserTable'
import { useGlobalStore } from '@/app/lib/global-store'
import { supabase } from '@/app/lib/supabase'
import ActivityLogList from '@/components/dashboard/layout/ActivityLogList'

interface User {
  id: string
  name: string
  email: string
  role: string
}

export default function ActivityLog() {
  const [sidebarOpen, setSidebarOpen] = useState(false)
  const [users, setUsers] = useState<User[]>([])
  const [isLoading, setIsLoading] = useState(false)
  const [modalOpen, setModalOpen] = useState(false)
  const [selectedUser, setSelectedUser] = useState<User | null>(null)

  const updated = useGlobalStore((state) => state.updated)
  const setUpdated = useGlobalStore((state) => state.setUpdated)

  useEffect(() => {
    const fetchUsers = async () => {
      setIsLoading(true)
      setUpdated(false)
    }

    fetchUsers()
  }, [updated])

  return (
    <AuthGuard>
      {/* Main Content */}
      <div className="flex flex-col flex-1">
        {/* Page Content */}
        <main className="flex-1 overflow-y-auto bg-[#0A0A0A] px-4">
          <div className="flex justify-between items-center mb-6">
            <h1 className="text-2xl font-bold">📃 Aktivitas Pengguna</h1>
          </div>
          <div className='mb-14'>
            <ActivityLogList></ActivityLogList>
          </div>
        </main>
      </div>
    </AuthGuard>
  )
}
