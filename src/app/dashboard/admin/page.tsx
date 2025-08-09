'use client'
import React, { useState } from 'react'
import { Menu, User, Info, Eye, EyeOff, Activity } from 'lucide-react'
import { motion } from "framer-motion";
import Sidebar from '@/components/dashboard/common/Sidebar';
import UserManagement from '@/components/dashboard/admin/UserManagement';
import ActivityLog from '@/components/dashboard/admin/ActivityLog';
const settingsTabs = ['User Management', 'Point Approval', 'Activity Logs', 'Site Settings'];


function App() {
    const [sidebarOpen, setSidebarOpen] = useState(false)
    const [activeTab, setActiveTab] = useState('User Management')
    const [showPassword, setShowPassword] = useState(false)
    const [showCurrentPassword, setShowCurrentPassword] = useState(false)

    return (
        <div className="flex h-screen bg-[#0a0a0a] text-white font-inter">
            <Sidebar />

            <div className="flex flex-col flex-1 overflow-hidden">
                {/* Mobile Header */}
                <div className="md:hidden flex items-center justify-between px-5 py-4 border-b border-white/10 bg-[#0a0a0a] shadow-sm">
                    <h2 className="text-xl font-semibold tracking-tight text-white">
                        Tim Konten
                    </h2>
                    <button onClick={() => setSidebarOpen(true)} aria-label="Open menu">
                        <Menu size={28} className="text-white" />
                    </button>
                </div>

                {/* Main Content */}
                <main className="flex-1 overflow-y-auto px-4 sm:px-6 py-5">
                    <div className="max-w-7xl mx-auto w-full">
                        {/* Top Settings Tabs */}
                        <div className="flex gap-2 sm:gap-4 border-b border-white/10 mb-6 overflow-x-auto scrollbar-hide">
                            {settingsTabs.map((tab) => (
                                <button
                                    key={tab}
                                    onClick={() => setActiveTab(tab)}
                                    className={`mb-2 px-4 py-2 text-sm rounded-md ${activeTab === tab
                                        ? 'bg-white text-black font-semibold'
                                        : 'text-white/70 hover:bg-[#1f1f1f] transition'
                                        }`}
                                >
                                    {tab}
                                </button>
                            ))}
                        </div>

                        {/* Profile Content */}
                        {activeTab === 'User Management' && (
                            <UserManagement/>
                        )}
                        {activeTab === 'Activity Logs' && (
                            <ActivityLog/>
                        )}
                    </div>
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
    )
}

export default App
