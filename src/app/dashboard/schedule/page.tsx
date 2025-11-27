'use client'

import React, { useState, useEffect } from 'react'
import { Menu, MoreVertical, SquarePen, UserIcon } from 'lucide-react'
import Sidebar from '@/components/dashboard/common/Sidebar'
import AuthGuard from '@/components/AuthGuard'

const App = () => {
    const [sidebarOpen, setSidebarOpen] = useState(false)
    return (
        <AuthGuard>
            <div className="flex h-screen bg-[#0a0a0a] text-white">
                {/* Sidebar Desktop */}
                <Sidebar />

                {/* Main Layout */}
                <div className="flex flex-col flex-1">

                    {/* Mobile Navbar */}
                    <div className="md:hidden flex items-center justify-between px-5 py-4 border-b border-white/10 bg-[#0a0a0a] shadow-sm">
                        <h2 className="text-xl font-semibold tracking-tight">Tim Konten</h2>
                        <button onClick={() => setSidebarOpen(true)} aria-label="Open menu">
                            <Menu size={28} />
                        </button>
                    </div>

                    {/* Main Content */}
                    <main className="flex-1 px-5 sm:px-10 pt-10 bg-[#0a0a0a] overflow-y-auto">
                        <div className="mb-6">
                            <h1 className="text-4xl font-extrabold mb-2">Schedule</h1>
                            <p className="text-white/50 text-lg">Jadwal penugasan Tim Konten & Brand Ambassador</p>
                        </div>
                        <div>
                            <div className="p-6 space-y-10 bg-[#0a0a0a] min-h-screen text-white">

                                {/* TABEL 1 */}
                                <h2 className="text-2xl font-bold mb-2">Tabel Jadwal Visual Creative Design</h2>

                                <div className="overflow-x-auto bg-[#111] shadow rounded-xl">
                                    <table className="min-w-full border border-gray-700 text-white">
                                        <thead className="bg-[#1a1a1a] text-gray-300">
                                            <tr>
                                                <th className="border border-gray-700 p-3">Minggu</th>
                                                <th className="border border-gray-700 p-3">Senin</th>
                                                <th className="border border-gray-700 p-3">Selasa</th>
                                                <th className="border border-gray-700 p-3">Kamis</th>
                                                <th className="border border-gray-700 p-3">Minggu</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td className="border border-gray-700 p-3">1</td>
                                                <td className="border border-gray-700 p-3">Azqi</td>
                                                <td className="border border-gray-700 p-3">Yihan</td>
                                                <td className="border border-gray-700 p-3">Queen</td>
                                                <td className="border border-gray-700 p-3">Bima</td>
                                            </tr>
                                            <tr>
                                                <td className="border border-gray-700 p-3">2</td>
                                                <td className="border border-gray-700 p-3">Hamizano</td>
                                                <td className="border border-gray-700 p-3">Azqi</td>
                                                <td className="border border-gray-700 p-3">Yihan</td>
                                                <td className="border border-gray-700 p-3">Queen</td>
                                            </tr>
                                            <tr>
                                                <td className="border border-gray-700 p-3">3</td>
                                                <td className="border border-gray-700 p-3">Bima</td>
                                                <td className="border border-gray-700 p-3">Hamizano</td>
                                                <td className="border border-gray-700 p-3">Azqi</td>
                                                <td className="border border-gray-700 p-3">Yihan</td>
                                            </tr>
                                            <tr>
                                                <td className="border border-gray-700 p-3">4</td>
                                                <td className="border border-gray-700 p-3">Queen</td>
                                                <td className="border border-gray-700 p-3">Bima</td>
                                                <td className="border border-gray-700 p-3">Hamizano</td>
                                                <td className="border border-gray-700 p-3">Azqi</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                {/* Brand Ambassador */}
                                <h3 className="text-xl font-semibold mt-6">Pembagian Shooting Brand Ambassador</h3>

                                <div className="bg-[#111] shadow rounded-xl p-4 text-gray-300">
                                    <div className="space-y-2">
                                        <p><span className="font-bold text-white">Minggu Ke-1:</span> Keisya, Tiyas, Enzo, Syafira, Glenvio</p>
                                        <p><span className="font-bold text-white">Minggu Ke-2:</span> Syahidan, Hafizh, Devan, Hulwa, Griselda</p>
                                        <p><span className="font-bold text-white">Minggu Ke-3:</span> Raffi, Agustin, Nashwa, Hanif, Lulu</p>
                                        <p><span className="font-bold text-white">Minggu Ke-4:</span> Arbi, Shaskia, Rafi Rabani, Cressendo, Keyla</p>
                                    </div>
                                </div>

                                {/* TABEL 2 */}
                                <h2 className="text-2xl font-bold mt-10">Tabel Jadwal Video Content Production</h2>

                                <div className="overflow-x-auto bg-[#111] shadow rounded-xl">
                                    <table className="min-w-full border border-gray-700 text-white">
                                        <thead className="bg-[#1a1a1a] text-gray-300">
                                            <tr>
                                                <th className="border border-gray-700 p-3">Minggu</th>
                                                <th className="border border-gray-700 p-3">Senin (Tips)</th>
                                                <th className="border border-gray-700 p-3">SPMB</th>
                                                <th className="border border-gray-700 p-3">Kaleidoskop</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td className="border border-gray-700 p-3">1</td>
                                                <td className="border border-gray-700 p-3">Billy</td>
                                                <td className="border border-gray-700 p-3">Axel</td>
                                                <td className="border border-gray-700 p-3">Isa</td>
                                            </tr>
                                            <tr>
                                                <td className="border border-gray-700 p-3">2</td>
                                                <td className="border border-gray-700 p-3">Agung</td>
                                                <td className="border border-gray-700 p-3">Isa</td>
                                                <td className="border border-gray-700 p-3">Hafiz + Axel</td>
                                            </tr>
                                            <tr>
                                                <td className="border border-gray-700 p-3">3</td>
                                                <td className="border border-gray-700 p-3">Rasya + Hanif</td>
                                                <td className="border border-gray-700 p-3">Billy</td>
                                                <td className="border border-gray-700 p-3">Axel</td>
                                            </tr>
                                            <tr>
                                                <td className="border border-gray-700 p-3">4</td>
                                                <td className="border border-gray-700 p-3">Hanif</td>
                                                <td className="border border-gray-700 p-3">Agung</td>
                                                <td className="border border-gray-700 p-3">Isa</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </main>
                </div>

                {/* Sidebar Mobile */}
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
    )
}

export default App
