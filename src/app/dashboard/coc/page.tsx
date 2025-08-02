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
import Calendar from '@/components/dashboard/layout/Calendar';
import TodoList from '@/components/dashboard/layout/TodoList';

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
                        <h1 className="text-4xl font-extrabold tracking-tight mb-2">Calender Of Content</h1>
                        <p className="text-white/50 text-lg">Lihat jadwal konten </p>
                    </div>
                    {/* Folder Section */}
                    <section className="grid grid-cols-1 lg:grid-cols-[2fr_1fr] gap-8 mb-12">

                        {/* LEFT SIDE */}
                        <div className="space-y-8">

                            {/* Calendar */}
                            <Calendar />

                            {/* To-Do List */}
                            <TodoList />
                        </div>

                        {/* RIGHT SIDE */}
                        <div className="space-y-8">

                            {/* Motivasi Hari Ini */}
                            <div className="bg-gradient-to-br from-[#1f1f2b] to-[#121212] p-6 rounded-3xl shadow-xl border border-white/5">
                                <h2 className="text-xl font-bold mb-3 flex items-center gap-2">🔥 Motivasi Hari Ini</h2>
                                <p className="text-white/80 text-base italic leading-relaxed">
                                    Jangan tunggu semangat, jalanin aja dulu. Karena hasil gak pernah ngkhianatin proses.
                                </p>
                                <div className="text-sm text-white/30 mt-4">#MentalJuara</div>
                            </div>

                            {/* Upcoming Events */}
                            <div className="bg-[#121212] p-6 rounded-3xl shadow-lg border border-white/5">
                                <h2 className="text-xl font-bold mb-4 flex items-center gap-2">📅 Upcoming To-Do List</h2>
                                <ul className="space-y-4 text-sm text-white/80">
                                    {[
                                        {
                                            title: '🧪 Ulangan Harian Kimia',
                                            date: '26 April 2025',
                                            detail: 'Bab: Ikatan Kimia & Reaksi Redoks'
                                        },
                                        {
                                            title: '📜 Tugas Sejarah',
                                            date: '28 April 2025',
                                            detail: 'Analisis peran pahlawan nasional'
                                        },
                                        {
                                            title: '🎤 Presentasi Bahasa Inggris',
                                            date: 'Jumat, 2 Mei 2025',
                                            detail: 'Topik: Global Warming'
                                        }
                                    ].map((event, i) => (
                                        <li key={i} className="bg-[#1a1a1a] p-4 rounded-xl border border-white/10">
                                            <p className="text-white font-semibold mb-1">{event.title}</p>
                                            <p className="text-white/60">Tanggal: {event.date}</p>
                                            <p className="text-white/50">{event.detail}</p>
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
    );
}

export default App;
