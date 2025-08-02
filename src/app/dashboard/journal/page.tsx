'use client'
import React, { useState } from 'react';
import {
    Search,
    Folder,
    Plus,
    UploadCloud,
    Star,
    Mail,
    Menu, BookCheck, Clock, CheckCircle, Layers, Flame,
    Check,
    CalendarDays,
} from 'lucide-react';
import Sidebar from '@/components/dashboard/common/Sidebar';
import Calendar from '@/components/dashboard/layout/journal/Calendar';
import TodoList from '@/components/dashboard/layout/TodoList';
import AuthGuard from '@/components/AuthGuard';

function App() {
    const [sidebarOpen, setSidebarOpen] = useState(false);
    const [folders, setFolders] = useState([
        { name: "Axel IPA", deleted: false },
        { name: "Physics Basics", deleted: false },
    ]);
    const [newFolderName, setNewFolderName] = useState("");

    const createFolder = () => {
        if (newFolderName.trim()) {
            setFolders([...folders, { name: newFolderName, deleted: false }]);
            setNewFolderName("");
        }
    };

    const softDeleteFolder = (index: number) => {
        const updatedFolders = folders.map((folder, idx) =>
            idx === index ? { ...folder, deleted: true } : folder
        );
        setFolders(updatedFolders);
    };

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
                            <h1 className="text-4xl font-extrabold tracking-tight mb-2">Journal Recap</h1>
                            <p className="text-white/50 text-lg">Tambahkan poin untuk siswa berbintang </p>
                        </div>
                        {/* Folder Section */}
                        <section className="grid grid-cols-1 lg:grid-cols-[2fr_1fr] gap-8 mb-12">

                            {/* LEFT SIDE */}
                            <div className="space-y-8">

                                {/* Calendar */}
                                <Calendar />
                            </div>

                            {/* RIGHT SIDE */}
                            <div className="space-y-8">
                                {/* Upcoming Events */}
                                <div className="bg-[#121212] p-6 rounded-3xl shadow-xl border border-white/5">
                                    <div className="flex items-center justify-between mb-6">
                                        <h2 className="text-xl font-semibold text-white flex items-center gap-2">
                                            <span className="text-2xl">📅</span> 2 Agustus 2025
                                        </h2>
                                        <button className="text-white bg-[#1f1f1f] hover:bg-[#2a2a2a] transition-all px-3 py-1 rounded-full text-lg">
                                            +
                                        </button>
                                    </div>
                                    <ul className="space-y-4 text-sm text-white/80">
                                        {[
                                            {
                                                title: '🧪 Ulangan Harian Kimia',
                                                date: '26 April 2025',
                                                detail: 'Bab: Ikatan Kimia & Reaksi Redoks',
                                            },
                                            {
                                                title: '📜 Tugas Sejarah',
                                                date: '28 April 2025',
                                                detail: 'Analisis peran pahlawan nasional',
                                            },
                                            {
                                                title: '🎤 Presentasi Bahasa Inggris',
                                                date: 'Jumat, 2 Mei 2025',
                                                detail: 'Topik: Global Warming',
                                            },
                                        ].map((event, i) => (
                                            <li
                                                key={i}
                                                className="bg-[#181818] p-5 rounded-xl border border-white/10 hover:scale-[1.015] hover:bg-[#222222] transition-all duration-300"
                                            >
                                                <p className="text-white font-semibold text-base mb-1">{event.title}</p>
                                                <p className="text-white/60 text-sm">🗓️ {event.date}</p>
                                                <p className="text-white/50 text-sm">{event.detail}</p>
                                            </li>
                                        ))}
                                    </ul>
                                </div>
                            </div>
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
