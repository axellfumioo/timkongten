'use client';

import React, { useState, useEffect } from 'react';
import {
    Eye, Edit, TrashIcon, Search, CalendarDays, Plus, UploadCloud, BarChart2, Briefcase,
    Menu,
    Loader2,
    Save
} from 'lucide-react';
import Sidebar from '@/components/dashboard/common/Sidebar';
import AuthGuard from '@/components/AuthGuard';
import ConfirmationModal from '@/components/dashboard/layout/confirmationModal';
import ContentModal from '@/components/dashboard/layout/contentModal';
import Toast from 'typescript-toastify';
import { useGlobalStore } from '@/app/lib/global-store';
import { useSession } from "next-auth/react"
import ContentModalEvidence from '@/components/dashboard/layout/journal/contentModal/ContentModalEvidence';
import EvidenceModal from '@/components/dashboard/layout/journal/contentModal/EvidenceModal';

// tipe evidence
type EvidenceStatus = 'needaction' | 'accepted' | 'rejected' | 'pending';

interface Evidence {
    id: string;
    title: string;
    description: string;
    job: string;
    status: EvidenceStatus;
    date: string;
}

const monthNames = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
];

function EvidenceDashboard() {
    const [sidebarOpen, setSidebarOpen] = useState(false);
    const [selectedMonth, setSelectedMonth] = useState<number>(new Date().getMonth());
    const [selectedStatus, setSelectedStatus] = useState<string>('Semua');
    const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc');
    const [userToDelete, setUserToDelete] = useState<Evidence | null>(null);
    const [confirmOpen, setConfirmOpen] = useState(false);
    const [contentModalOpen, setContentModalOpen] = useState(false);
    const [searchTerm, setSearchTerm] = useState('');
    const [modalOpen, setModalOpen] = useState(false);
    const [proofOpen, setProofOpen] = useState(false);
    const { data: session, status } = useSession()
    const [acceptedEvidenceTotal, setAcceptedEvidenceTotal] = useState(0);
    const setUpdated = useGlobalStore((state) => state.setUpdated)
    const updated = useGlobalStore((state) => state.updated)
    const [evidenceData, setEvidenceData] = useState<Evidence[]>([]);
    const [loading, setLoading] = useState(false);
    const [selectedContent, setSelectedContent] = useState<any | null>(null)
    const [selectedYear, setSelectedYear] = useState(new Date().getFullYear());
    const [selectedId, setSelectedId] = useState('');
    const [loadingSubmit, setLoadingSubmit] = useState(false);
    const [loadingDelete, setLoadingDelete] = useState(false);
    const [contents, setContents] = useState<any[]>([]);
    const [loadingContents, setLoadingContents] = useState(false);

    // data form
    const [formData, setFormData] = useState({
        evidence_title: '',
        content_id: '',
        evidence_description: '',
        evidence_date: '',
        evidence_job: '',
    });
    const [selectedFile, setSelectedFile] = useState<File | null>(null);


    // ambil data dari API
    const fetchEvidences = async () => {
        try {
            setLoading(true);
            const user_email = session?.user?.email;
            if (!user_email) {
                setLoading(false);
                setEvidenceData([]);
                return;
            }

            const query = new URLSearchParams({
                user: user_email,
                month: String(selectedMonth + 1).padStart(2, '0'), // ✅ hanya kirim month
                find: searchTerm
            }).toString();

            const res = await fetch(`/api/evidences?${query}`);
            if (!res.ok) throw new Error('Gagal fetch data');
            const data = await res.json();

            const mapped: Evidence[] = (data.data || []).map((item: any) => ({
                id: item.id,
                title: item.evidence_title,
                description: item.evidence_description,
                job: item.evidence_job,
                status: item.evidence_status,
                date: item.evidence_date
            }));

            setEvidenceData(mapped);

            // API udah balikin acceptedEvidences
            setAcceptedEvidenceTotal(Number(data.acceptedEvidences));

        } catch (err) {
            console.error(err);
            setEvidenceData([]);
            setAcceptedEvidenceTotal(0);
        } finally {
            setLoading(false);
        }
    };

    // delete evidence
    const confirmDelete = async (id: any) => {
        setLoadingDelete(true);
        try {
            const res = await fetch(`/api/evidences/${id}`, {
                method: "DELETE",
            });

            if (res.ok) {
                setUserToDelete(null);
                fetchEvidences(); // bisa dipanggil di sini
                setConfirmOpen(false)
            } else {
                console.error("Gagal menghapus data");
            }
        } catch (error) {
            console.error("Error saat menghapus:", error);
        } finally {
            setLoadingDelete(false);
        }
    };

    // jalankan saat pertama load & updated = true
    useEffect(() => {
        fetchEvidences();
        setUpdated(false);
        if (updated) {
            fetchEvidences();
            setUpdated(false);
        }
    }, [status, selectedMonth, searchTerm, updated]);

    // helper: bikin grouping + sorting
    const groupedContents = contents.reduce((acc: Record<string, any[]>, item: any) => {
        const date = new Date(item.content_date);
        const month = monthNames[date.getMonth()];
        const year = date.getFullYear();
        const group = `${month} ${year}`;
        if (!acc[group]) acc[group] = [];
        acc[group].push(item);
        return acc;
    }, {});

    // urutin key by date terbaru → lama
    const sortedGroups = Object.keys(groupedContents).sort((a, b) => {
        const [monthA, yearA] = a.split(" ");
        const [monthB, yearB] = b.split(" ");
        const dateA = new Date(parseInt(yearA), monthNames.indexOf(monthA));
        const dateB = new Date(parseInt(yearB), monthNames.indexOf(monthB));
        return dateB.getTime() - dateA.getTime(); // desc
    });


    // filter & sort hasil fetch (opsional, kalau mau filter lagi di frontend)
    const statusOrder: Record<EvidenceStatus, number> = {
        needaction: 1,
        pending: 2,
        rejected: 3,
        accepted: 4, // urutan terakhir
    };

    const filteredEvidence = evidenceData
        .filter((item) => {
            const itemDate = new Date(item.date);
            const itemMonth = itemDate.getMonth();
            const itemYear = itemDate.getFullYear();

            const statusMatch =
                selectedStatus === 'Semua' || item.status === selectedStatus;

            const monthMatch = itemMonth === selectedMonth;
            const yearMatch =
                selectedYear === null || itemYear === selectedYear;

            return monthMatch && yearMatch && statusMatch;
        })
        .sort((a, b) => {
            const statusDiff = statusOrder[a.status] - statusOrder[b.status];
            if (statusDiff !== 0) return statusDiff;
            return sortOrder === 'asc'
                ? new Date(a.date).getTime() - new Date(b.date).getTime()
                : new Date(b.date).getTime() - new Date(a.date).getTime();
        });


    // handle input change
    const handleChange = (
        e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>
    ) => {
        const { name, value } = e.target;
        if (e.target instanceof HTMLInputElement && e.target.type === 'file') {
            const files = e.target.files;
            if (files && files[0]) {
                setSelectedFile(files[0]);
            }
        } else {
            setFormData({ ...formData, [name]: value });
        }
    };

    // submit evidence
    async function handleSubmit(e: React.FormEvent) {
        e.preventDefault();
        setLoadingSubmit(true);

        try {
            const isEmpty = Object.values(formData).some(
                (val) => typeof val === 'string' && val.trim() === ''
            );
            if (!selectedFile || isEmpty) {
                setModalOpen(false);
                setSelectedFile(null);
                new Toast({
                    position: 'top-right',
                    toastMsg: 'Semua field harus diisi!',
                    autoCloseTime: 3000,
                    showProgress: true,
                    type: 'error',
                    theme: 'dark',
                });
                return;
            }

            const formPayload = new FormData();
            formPayload.append('evidence_title', formData.evidence_title);
            formPayload.append('evidence_description', formData.evidence_description);
            formPayload.append('evidence_date', formData.evidence_date);
            formPayload.append('evidence_job', formData.evidence_job);
            formPayload.append('content_id', formData.content_id);
            formPayload.append('completion_proof', selectedFile);

            const response = await fetch('/api/evidences', { method: 'POST', body: formPayload });

            setModalOpen(false);
            if (response.ok) {
                setFormData({ evidence_title: '', content_id: '', evidence_description: '', evidence_date: '', evidence_job: '' });
                setSelectedFile(null);
                new Toast({
                    position: 'top-right',
                    toastMsg: 'Berhasil menyimpan!',
                    autoCloseTime: 3000,
                    type: 'success',
                    theme: 'dark',
                });
                fetchEvidences();
            } else {
                setSelectedFile(null);
                new Toast({
                    position: 'top-right',
                    toastMsg: 'Gagal menyimpan!',
                    autoCloseTime: 3000,
                    type: 'error',
                    theme: 'dark',
                });
            }
        } finally {
            setLoadingSubmit(false);
        }
    }

    return (
        <AuthGuard>
            <div className="flex h-screen bg-[#0a0a0a] text-white">
                <Sidebar />

                <div className="flex flex-1 flex-col md:flex-row overflow-hidden">
                    {/* Mobile Navbar */}
                    <div className="md:hidden flex items-center justify-between px-5 py-4 border-b border-white/10 bg-[#0a0a0a] shadow-sm">
                        <h2 className="text-xl font-semibold tracking-tight text-white">
                            Tim Konten
                        </h2>
                        <button onClick={() => setSidebarOpen(true)} aria-label="Open menu">
                            <Menu size={28} className="text-white" />
                        </button>
                    </div>
                    {/* Modals */}
                    <ContentModal
                        isOpen={modalOpen}
                        onClose={() => {
                            setSelectedFile(null); // Reset hanya file doang
                            setModalOpen(false);   // Tutup modal
                        }}
                    >
                        <h2 className="text-2xl font-semibold mb-6">Buat Evidence</h2>
                        <form
                            className="grid grid-cols-1 md:grid-cols-2 gap-5 text-sm"
                            onSubmit={handleSubmit}
                        >
                            {/* Judul Konten */}
                            <div className="">
                                <label className="block text-white font-medium mb-1">Evidence</label>
                                <input
                                    name="evidence_title"
                                    type="text"
                                    value={formData.evidence_title}
                                    onChange={handleChange}
                                    placeholder="Masukkan judul evidence"
                                    className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                                />
                            </div>

                            {/* Tanggal Konten */}
                            <div>
                                <label className="block text-white font-medium mb-1">Tanggal</label>
                                <input
                                    name="evidence_date"
                                    type="date"
                                    value={formData.evidence_date}
                                    onChange={handleChange}
                                    className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                                />
                            </div>

                            {/* Caption */}
                            <div className="md:col-span-2">
                                <label className="block text-white font-medium mb-1">Keterangan</label>
                                <textarea
                                    name="evidence_description"
                                    value={formData.evidence_description}
                                    onChange={handleChange}
                                    placeholder="Masukkan caption konten..."
                                    className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 h-28 placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-white/20 transition resize-none"
                                />
                            </div>
                            {/* Tanggal Konten */}
                            <div className="md:col-span-2">
                                <label className="block text-white font-medium mb-2">Bukti</label>

                                <div
                                    className={`relative flex items-center justify-between w-full rounded-lg border px-4 py-3 cursor-pointer transition group
        ${selectedFile
                                            ? "border-white/10 bg-white/5 hover:bg-white/10"
                                            : "border-white/20 bg-white/10 hover:bg-white/15"
                                        }`}
                                >
                                    {selectedFile ? (
                                        <span className="truncate text-white/70 group-hover:text-white">
                                            {selectedFile.name}
                                        </span>
                                    ) : (
                                        <span className="truncate text-white/60 group-hover:text-white/80">
                                            Klik untuk memilih file...
                                        </span>
                                    )}

                                    <UploadCloud
                                        className={`w-5 h-5 transition
            ${selectedFile
                                                ? "text-white/50 group-hover:text-white"
                                                : "text-white/60 group-hover:text-white/80"
                                            }`}
                                    />
                                    <input
                                        type="file"
                                        name="completion_proof"
                                        accept="image/*,.pdf"
                                        onChange={handleChange}
                                        className="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
                                    />
                                </div>

                            </div>

                            {/* Feedback */}
                            <div className=''>
                                <label className="block text-white font-medium mb-1">Calendar Of Content</label>
                                <select
                                    name="content_id"
                                    value={formData.content_id}
                                    onChange={handleChange}
                                    className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                                >
                                    <option className="bg-black text-white" disabled value="">
                                        {loadingContents ? "Memuat konten..." : "Pilih CoC"}
                                    </option>
                                    {sortedGroups.map((monthYear) => (
                                        <optgroup className="bg-black text-white" key={monthYear} label={monthYear}>
                                            {groupedContents[monthYear].map((item) => (
                                                <option
                                                    key={item.id}
                                                    value={item.id}
                                                    className="bg-black text-white"
                                                >
                                                    {item.content_title}
                                                </option>
                                            ))}
                                        </optgroup>
                                    ))}
                                </select>
                            </div>

                            {/* Feedback */}
                            <div>
                                <label className="block text-white font-medium mb-1">Tugas</label>
                                <select
                                    name="evidence_job"
                                    value={formData.evidence_job}
                                    onChange={handleChange}
                                    className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                                >
                                    <option className="bg-black text-white" value="" disabled>Pilih tugas</option>
                                    <option className="bg-black text-white" value="Edit/Design Konten">Edit/Design Konten (Feed, Story, WhatsApp)</option>
                                    <option className="bg-black text-white" value="Take Video">Take Video (Video, Reels, TikTok)</option>
                                    <option className="bg-black text-white" value="Content Production">Content Production (Ide, Skrip atau Caption)</option>
                                    <option className="bg-black text-white" value="Pemotretan, Dokumentasi">Pemotretan / Dokumentasi</option>
                                    <option className="bg-black text-white" value="Sosialisasi">(BA) Sosialisasi</option>
                                    <option className="bg-black text-white" value="Lainnya">Lainnya</option>
                                </select>
                            </div>

                            {/* Tombol Aksi */}
                            <div className="md:col-span-2 flex justify-end gap-3 pt-2">
                                <button
                                    type="button"
                                    onClick={() => setModalOpen(false)}
                                    className="px-5 py-2.5 rounded-lg text-sm font-medium bg-white/10 text-white hover:bg-white/20 transition"
                                >
                                    Batal
                                </button>
                                <button
                                    type="submit"
                                    disabled={loadingSubmit}
                                    className="px-5 py-2.5 rounded-lg text-sm font-medium bg-white/20 hover:bg-white/30 transition text-white flex items-center gap-2"
                                >
                                    {loadingSubmit ? (
                                        <>
                                            <Loader2 size={16} className="animate-spin" /> Menyimpan...
                                        </>
                                    ) : (
                                        <>
                                            <Save size={16} /> Simpan
                                        </>
                                    )}
                                </button>

                            </div>
                        </form>
                    </ContentModal>

                    <main className="flex-1 p-5 md:p-10 overflow-y-auto">
                        {/* Heading */}
                        <div className="mb-6">
                            <h1 className="text-4xl font-extrabold mb-2">Point Evidence</h1>
                            <p className="text-white/50 text-lg">Lihat atau tambahkan point evidence kamu</p>
                        </div>

                        {/* Main content wrapper */}
                        <div className="flex flex-col md:flex-row w-full gap-y-6 md:gap-x-6">
                            {/* Left section - Search & List */}
                            <div className="w-full md:flex-1">
                                {/* Search bar */}
                                <div className="relative w-full mb-4">
                                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-white/30" size={18} />
                                    <input
                                        type="text"
                                        value={searchTerm}
                                        onChange={(e) => setSearchTerm(e.target.value)}
                                        placeholder="Cari evidence..."
                                        className="w-full pl-10 pr-3 py-2 text-sm rounded-lg bg-[#1f1f1f] border border-white/10 text-white focus:outline-none focus:border-white/20"
                                    />
                                </div>

                                {loading === true ? (
                                    <div className="text-sm text-white/40 italic py-10 text-center border border-white/10 rounded-xl bg-[#1f1f1f]">
                                        <div className="text-center py-2">
                                            <div className="relative w-8 h-8 mx-auto">
                                                <div className="absolute inset-0 border-[3px] border-white border-t-transparent rounded-full animate-spin"></div>
                                            </div>
                                            <p className="text-sm font-medium text-white/70 animate-pulse mt-2">Memuat konten...</p>
                                        </div>
                                    </div>
                                ) : (
                                    <>
                                        {/* Evidence list */}
                                        {filteredEvidence.length === 0 ? (
                                            <div className="text-sm text-white/40 italic py-10 text-center border border-white/10 rounded-xl bg-[#1f1f1f]">
                                                Tidak ada evidence di bulan ini.
                                            </div>
                                        ) : (
                                            <div className="space-y-5">
                                                {filteredEvidence.map((item) => {
                                                    const statusClasses =
                                                        item.status === "accepted"
                                                            ? "text-green-400 bg-green-500/10 border-green-500/20"
                                                            : item.status === "rejected"
                                                                ? "text-red-400 bg-red-500/10 border-red-500/20"
                                                                : item.status === "needaction"
                                                                    ? "text-orange-400 bg-orange-500/10 border-orange-500/20"
                                                                    : "text-yellow-400 bg-yellow-500/10 border-yellow-500/20";

                                                    const statusLabels: Record<EvidenceStatus, string> = {
                                                        needaction: "Action Needed",
                                                        accepted: "Accepted",
                                                        rejected: "Rejected",
                                                        pending: "Pending"
                                                    };
                                                    return (
                                                        <div
                                                            key={item.id}
                                                            className={`group flex flex-col sm:flex-row justify-between sm:items-center gap-6 p-5
          bg-gradient-to-br from-white/[0.06] to-white/[0.02] backdrop-blur-xl
          rounded-2xl border border-white/10
          hover:border-white/20 hover:shadow-xl hover:shadow-black/30
          transition-all duration-300`}
                                                        >
                                                            {/* Left Side */}
                                                            <div className="flex-1 min-w-0 space-y-4">
                                                                {/* Title & Description */}
                                                                <div className="space-y-1">
                                                                    <h3 className="text-lg font-bold text-white truncate">
                                                                        {item.title.length > 80
                                                                            ? item.title.slice(0, 60) + "..."
                                                                            : item.title}
                                                                    </h3>
                                                                    <p className="text-sm text-white/70 line-clamp-2 leading-relaxed">
                                                                        {item.description.length > 92
                                                                            ? item.description.slice(0, 92) + "..."
                                                                            : item.description}
                                                                    </p>
                                                                </div>

                                                                {/* Meta Info (Premium Style) */}
                                                                <div className="grid grid-cols-3 sm:flex sm:flex-wrap sm:gap-4 text-sm font-medium">
                                                                    {/* Status */}
                                                                    <div className="flex items-center gap-2">
                                                                        <span
                                                                            className={`px-2.5 py-1 rounded-full border text-xs capitalize ${statusClasses}`}
                                                                        >
                                                                            {statusLabels[item.status] || item.status}
                                                                        </span>
                                                                    </div>

                                                                    {/* Job */}
                                                                    <div className="flex items-center gap-2 text-white/50">
                                                                        <Briefcase size={14} className="opacity-70" />
                                                                        {item.job || "Tidak ada job"}
                                                                    </div>

                                                                    {/* Date */}
                                                                    <div className="flex items-center gap-2 text-white/50">
                                                                        <CalendarDays size={14} className="opacity-60" />
                                                                        {item.date}
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            {/* Right Side: Actions */}
                                                            <div className="flex items-center gap-2 shrink-0">
                                                                {item.status !== "needaction" && (
                                                                    <button
                                                                        className="p-2 hover:bg-white/10 rounded-lg transition"
                                                                        title="Lihat"
                                                                        onClick={() => {
                                                                            setProofOpen(true);
                                                                            setSelectedId(item.id);
                                                                        }}
                                                                    >
                                                                        <Eye size={18} />
                                                                    </button>
                                                                )}
                                                                <button
                                                                    className="p-2 hover:bg-white/10 rounded-lg transition"
                                                                    title="Edit"
                                                                    onClick={() => {
                                                                        setSelectedContent(item);
                                                                        setContentModalOpen(true);
                                                                    }}
                                                                >
                                                                    <Edit size={18} />
                                                                </button>
                                                                <button
                                                                    onClick={() => {
                                                                        setUserToDelete(item);
                                                                        setConfirmOpen(true);
                                                                    }}
                                                                    className="p-2 hover:bg-red-500/10 text-red-400 hover:text-red-500 rounded-lg transition"
                                                                    title="Hapus"
                                                                >
                                                                    <TrashIcon size={18} />
                                                                </button>
                                                            </div>
                                                        </div>
                                                    );
                                                })}
                                            </div>
                                        )}
                                    </>
                                )}
                            </div>

                            {/* Right section */}
                            <div className="w-full md:w-64 md:sticky md:top-10 space-y-5">

                                {/* Tombol Buat Evidence */}
                                <button
                                    onClick={() => setModalOpen(true)}
                                    className="flex items-center justify-center gap-2 bg-white text-[#0a0a0a] px-4 py-2 rounded-lg font-semibold hover:bg-gray-200 text-sm w-full transition shadow-sm"
                                >
                                    <Plus size={18} /> Buat Evidence
                                </button>

                                {/* Statistik Evidence */}
                                <div className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl p-6">
                                    <div className="flex items-center justify-between mb-3">
                                        <h2 className="text-sm font-semibold text-white flex items-center gap-2">
                                            <BarChart2 size={18} className="text-white/80" />
                                            Total Evidence {monthNames[selectedMonth]} {selectedYear}
                                        </h2>
                                    </div>

                                    <div
                                        className={`flex items-end justify-center transition-filter duration-500 ease-in-out ${loading ? "filter blur-sm opacity-70" : "filter-none opacity-100"
                                            }`}
                                    >
                                        <p className="text-[2.5rem] font-bold text-white leading-none">
                                            {acceptedEvidenceTotal}
                                        </p>
                                    </div>

                                </div>

                                {/* Filter Tahun */}
                                <div className="mb-4">
                                    <select
                                        value={selectedYear}
                                        onChange={(e) => {
                                            const newYear = Number(e.target.value);
                                            console.log("Tahun dipilih:", newYear); // debug pas pilih tahun
                                            setSelectedYear(newYear);
                                        }}
                                        className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-2 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                                    >
                                        {Array.from({ length: 5 }, (_, i) => {
                                            const year = new Date().getFullYear() - 2 + i;
                                            return (
                                                <option key={year} value={year} className="bg-black text-white">
                                                    {year}
                                                </option>
                                            );
                                        })}
                                    </select>
                                </div>


                                {/* Filter Bulan */}
                                <div className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl p-5">
                                    <h2 className="text-sm font-semibold text-white mb-4 flex items-center gap-2">
                                        <CalendarDays size={16} className="text-white/80" />
                                        Filter Bulan ({selectedYear})
                                    </h2>
                                    <div className="grid grid-cols-2 gap-2">
                                        {monthNames.map((month, i) => {
                                            const isSelected = selectedMonth === i;
                                            return (
                                                <button
                                                    key={i}
                                                    onClick={() => setSelectedMonth(i)}
                                                    className={`w-full rounded-lg px-4 py-2 text-sm font-medium text-left transition-all duration-200 border
                            ${isSelected
                                                            ? 'bg-white/10 border-white/20 text-white shadow-md ring-1 ring-white/20'
                                                            : 'bg-[#121212] border-white/10 text-white/60 hover:bg-white/5 hover:text-white'}
                        `}
                                                >
                                                    {month}
                                                </button>
                                            );
                                        })}
                                    </div>
                                </div>
                            </div>

                        </div>
                        {/* Modal Konten */}
                        <ContentModalEvidence
                            isOpen={contentModalOpen}
                            selectedEvidence={selectedContent}
                            onClose={() => setContentModalOpen(false)}
                        />

                        {/* Modal Konten */}
                        <EvidenceModal
                            proofOpen={proofOpen}
                            selectedId={selectedId}
                            setProofOpen={setProofOpen}
                        />
                    </main>
                </div>

                {/* Sidebar mobile */}
                <Sidebar isMobile isOpen={sidebarOpen} onClose={() => setSidebarOpen(false)} />
                {sidebarOpen && (
                    <div
                        onClick={() => setSidebarOpen(false)}
                        className="fixed inset-0 bg-black/50 z-30 md:hidden"
                    />
                )}

                {/* Modal Konfirmasi */}
                <ConfirmationModal
                    isOpen={confirmOpen}
                    onClose={() => {
                        setConfirmOpen(false);
                        setUserToDelete(null);
                    }}
                    title="Hapus Evidence"
                    description={`Yakin ingin menghapus ${userToDelete?.title}? Aksi ini tidak bisa dibatalkan.`}
                    onConfirm={() => {
                        confirmDelete(userToDelete?.id)
                        setConfirmOpen(false)
                    }}
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
        </AuthGuard>
    );
}

export default EvidenceDashboard;
