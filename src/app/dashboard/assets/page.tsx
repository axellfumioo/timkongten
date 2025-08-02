'use client'
import React, { useState } from 'react';
import {
    Plus,
    Menu,
    DownloadCloud,
    Download,
} from 'lucide-react';
import Sidebar from '@/components/dashboard/common/Sidebar';
import NotesHeader from '@/components/dashboard/layout/NoteHeader';
import AuthGuard from '@/components/AuthGuard';

function App() {
    const [sidebarOpen, setSidebarOpen] = useState(false);
    var notes = [
        { title: "aselole", description: "awokawokwa", url: "/logosmk.png", urlDownload: "https://google.com" }
    ]
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
                            <h1 className="text-4xl font-extrabold tracking-tight mb-2">File Assets</h1>
                            <p className="text-white/50 text-lg">Assets yang mungkin dibutuhkan</p>
                        </div>
                        {/* Folder Section */}
                        <section className="bg-[#121212] p-6 rounded-3xl shadow-lg border border-white/5">
                            <div className="flex items-center justify-between mb-5">
                                <h2 className="text-xl font-bold gap-2">📂 File Assets</h2>
                                <button
                                    className="flex-none flex items-center justify-center px-4 py-3 bg-white/10 hover:bg-white/15 text-white rounded-xl border border-white/10 transition-colors"
                                    aria-label="Buat catatan baru"
                                >
                                    <Plus size={18} className="mr-0 md:mr-2" />
                                    <span className="font-medium text-sm hidden md:inline">Tambah Assets</span>
                                </button>
                            </div>
                            <NotesHeader />


                            {notes.length === 0 ? (
                                <p className="text-white/40 italic">Belum ada assets ditambahkan.</p>
                            ) : (
                                <ul className="space-y-3">
                                    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                                        {notes.map((note, index) => (
                                            <div
                                                key={index}
                                                className="bg-[#121212] border border-white/10 rounded-2xl p-4 flex flex-col shadow-sm hover:shadow-md transition-all"
                                            >
                                                {/* Gambar thumbnail */}
                                                <div className="w-full h-40 bg-gray-950 rounded-lg overflow-hidden mb-3">
                                                    <img
                                                        src={note.url || '/placeholder.png'} // fallback placeholder
                                                        alt={note.title}
                                                        className="object-contain w-full h-full"
                                                    />
                                                </div>

                                                {/* Judul note */}
                                                <div className='mb-4'>
                                                    <h1 className={`leading-relaxed text-white font-bold uppercase`}>
                                                        {note.title}
                                                    </h1>
                                                    <p className="text-sm">{note.description}</p>
                                                </div>
                                                {/* Tombol download */}
                                                <div className="mt-auto">
                                                    {note.urlDownload ? (
                                                        <button className="flex items-center justify-center gap-2 bg-white text-[#0a0a0a] w-full px-4 py-2 rounded-md font-semibold hover:bg-gray-200 mb-2 text-sm">
                                                            <Download size={18} /> Download
                                                        </button>
                                                    ) : (
                                                        <button disabled className="w-full block text-center px-4 py-2 text-sm font-medium text-white/50 bg-gray-800 rounded-lg cursor-not-allowed">
                                                            Tidak tersedia
                                                        </button>
                                                    )}
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                </ul>
                            )}
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
