'use client';

import React, { useState, useEffect } from 'react';
import {
    Eye, Edit, TrashIcon, Search, CalendarDays, Plus, UploadCloud, BarChart2, Briefcase,
    Menu,
    Loader2,
    Save, CheckCircle2, ChevronDown, ChevronUp, X, File as FileIcon,
    Link
} from 'lucide-react';
import Sidebar from '@/components/dashboard/common/Sidebar';
import AuthGuard from '@/components/AuthGuard';
import ConfirmationModal from '@/components/dashboard/layout/confirmationModal';
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
    content_id?: string;
}

const monthNames = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
];

// Fungsi kompresi gambar dengan target maksimal 300KB
const compressImage = async (file: File): Promise<File> => {
    const MAX_FILE_SIZE = 300 * 1024; // 300KB dalam bytes

    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = (event) => {
            const img = new Image();
            img.src = event.target?.result as string;
            img.onload = async () => {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');

                if (!ctx) {
                    reject(new Error('Gagal membuat canvas context'));
                    return;
                }

                // Mulai dengan dimensi yang lebih kecil untuk hasil yang lebih baik
                let MAX_WIDTH = 1280;
                let MAX_HEIGHT = 1280;
                let width = img.width;
                let height = img.height;

                if (width > height) {
                    if (width > MAX_WIDTH) {
                        height = (height * MAX_WIDTH) / width;
                        width = MAX_WIDTH;
                    }
                } else {
                    if (height > MAX_HEIGHT) {
                        width = (width * MAX_HEIGHT) / height;
                        height = MAX_HEIGHT;
                    }
                }

                canvas.width = width;
                canvas.height = height;
                ctx.drawImage(img, 0, 0, width, height);

                const compressWithQuality = (quality: number): Promise<Blob | null> => {
                    return new Promise((res) => {
                        canvas.toBlob((blob) => res(blob), 'image/jpeg', quality);
                    });
                };

                let quality = 0.85;
                let blob: Blob | null = null;
                let attempts = 0;
                const maxAttempts = 10;

                while (attempts < maxAttempts) {
                    blob = await compressWithQuality(quality);
                    if (!blob || blob.size <= MAX_FILE_SIZE) break;

                    quality -= 0.1;
                    attempts++;

                    if (quality < 0.4 && blob.size > MAX_FILE_SIZE) {
                        width = Math.floor(width * 0.8);
                        height = Math.floor(height * 0.8);
                        canvas.width = width;
                        canvas.height = height;
                        ctx.drawImage(img, 0, 0, width, height);
                        quality = 0.7;
                    }
                }

                if (blob) {
                    const compressedFile = new File([blob], file.name, {
                        type: 'image/jpeg',
                        lastModified: Date.now(),
                    });
                    resolve(compressedFile);
                } else {
                    reject(new Error('Gagal kompresi gambar'));
                }
            };
            img.onerror = () => reject(new Error('Gagal memuat gambar'));
        };
        reader.onerror = () => reject(new Error('Gagal membaca file'));
    });
};


// Komponen Batch Upload untuk CoC Checklist
function QuickAddRow({ content, onUpload }: { content: any, onUpload: (content: any, entries: any[], job: string) => Promise<boolean> }) {
    const [entries, setEntries] = useState([{ id: Date.now(), date: content.content_date, link: '' }]);
    const [job, setJob] = useState('');
    const [loading, setLoading] = useState(false);

    const handleUpload = async () => {
        const validEntries = entries.filter(e => e.date);
        if (validEntries.length === 0 || !job) {
            new Toast({ position: 'top-right', toastMsg: 'Pilih tugas dan minimal lengkapi 1 baris tanggal!', type: 'error', theme: 'dark' });
            return;
        }
        setLoading(true);
        const success = await onUpload(content, validEntries, job);
        setLoading(false);
        if (success) {
            setEntries([{ id: Date.now(), date: content.content_date, link: '' }]);
            setJob('');
        }
    };

    const addEntry = () => setEntries([...entries, { id: Date.now(), date: content.content_date, link: '' }]);
    const removeEntry = (id: number) => setEntries(entries.filter(e => e.id !== id));
    const updateEntry = (id: number, field: string, value: any) => {
        setEntries(entries.map(e => e.id === id ? { ...e, [field]: value } : e));
    };

    return (
        <div className="group flex flex-col gap-5 p-6 bg-gradient-to-br from-white/[0.05] to-transparent backdrop-blur-lg border border-white/10 hover:border-white/20 rounded-3xl transition-all duration-500 shadow-xl hover:shadow-2xl hover:shadow-white/5">
            <div className="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-4 pb-4 border-b border-white/10">
                <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                        <span className="px-2.5 py-0.5 rounded-full bg-blue-500/10 text-blue-400 text-[10px] font-bold uppercase tracking-wider border border-blue-500/20">
                            {content.content_type || 'Konten'}
                        </span>
                        <span className="text-xs text-white/50 font-medium flex items-center gap-1">
                            <CalendarDays size={12} /> {content.content_date}
                        </span>
                    </div>
                    <h4 className="font-extrabold text-xl text-white line-clamp-1 tracking-tight">{content.content_title}</h4>
                </div>

                <div className="w-full lg:w-auto relative">
                    <Briefcase size={16} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/40" />
                    <select
                        value={job}
                        onChange={(e) => setJob(e.target.value)}
                        className="appearance-none bg-black/40 border border-white/10 hover:border-white/20 rounded-xl pl-11 pr-10 py-3 text-sm font-medium text-white focus:outline-none focus:ring-2 focus:ring-white/20 w-full lg:w-auto min-w-[220px] transition-all cursor-pointer"
                    >
                        <option value="" disabled className="text-white/50">Pilih tugas spesifik...</option>
                        <option value="Edit/Design Konten" className="bg-[#121212]">Edit/Design Konten</option>
                        <option value="Take Video" className="bg-[#121212]">Take Video</option>
                        <option value="Content Production" className="bg-[#121212]">Content Production</option>
                        <option value="Pemotretan, Dokumentasi" className="bg-[#121212]">Pemotretan / Dokumentasi</option>
                        <option value="Sosialisasi" className="bg-[#121212]">Sosialisasi</option>
                        <option value="Lainnya" className="bg-[#121212]">Lainnya</option>
                    </select>
                    <ChevronDown size={16} className="absolute right-4 top-1/2 -translate-y-1/2 text-white/40 pointer-events-none" />
                </div>
            </div>

            <div className="space-y-3">
                <div className="flex items-center justify-between mb-3 px-1">
                    <span className="text-xs font-bold text-white/40 uppercase tracking-widest">Daftar Evidence</span>
                    <button type="button" onClick={addEntry} className="text-xs bg-white/5 hover:bg-white/15 text-white px-3 py-1.5 rounded-lg font-semibold flex items-center gap-1.5 transition-all border border-white/10 hover:border-white/20">
                        <Plus size={14} /> Tambah Baris
                    </button>
                </div>

                <div className="space-y-3">
                    {entries.map((entry, index) => (
                        <div key={entry.id} className="group/row flex flex-col sm:flex-row gap-3 items-start sm:items-center bg-black/20 p-2 rounded-2xl border border-white/5 hover:border-white/10 transition-colors">
                            <div className="relative w-full sm:w-[160px]">
                                <CalendarDays size={16} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/40" />
                                <input
                                    type="date"
                                    max={new Date().toISOString().split('T')[0]}
                                    value={entry.date}
                                    onChange={(e) => updateEntry(entry.id, 'date', e.target.value)}
                                    className="bg-transparent border border-white/10 rounded-xl pl-11 pr-4 py-3 text-sm text-white focus:outline-none focus:ring-2 focus:ring-white/20 w-full hover:bg-white/5 transition-all"
                                />
                            </div>

                            <div className="relative border border-white/10 rounded-xl px-4 py-3 bg-white/5 hover:bg-white/10 text-sm flex items-center gap-3 flex-1 w-full transition-all group-hover/row:border-white/20">
                                <div className={`p-1.5 rounded-lg ${entry.link ? 'bg-green-500/20 text-green-400' : 'bg-white/10 text-white/50'}`}>
                                    <UploadCloud size={16} />
                                </div>
                                <input
                                    type="url"
                                    placeholder="Masukkan link bukti (Opsional)"
                                    value={entry.link}
                                    onChange={(e) => updateEntry(entry.id, 'link', e.target.value)}
                                    className="bg-transparent border-none text-white focus:outline-none w-full"
                                />
                            </div>

                            {entries.length > 1 && (
                                <button onClick={() => removeEntry(entry.id)} className="p-3 text-white/30 hover:text-red-400 hover:bg-red-400/10 rounded-xl transition-all border border-transparent hover:border-red-400/20">
                                    <TrashIcon size={18} />
                                </button>
                            )}
                        </div>
                    ))}
                </div>
            </div>

            <div className="flex justify-end pt-2">
                <button
                    onClick={handleUpload}
                    disabled={loading || !job || entries.filter(e => e.date).length === 0}
                    className="bg-white text-black hover:bg-gray-200 rounded-xl px-8 py-3 text-sm font-bold transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2 shadow-lg shadow-white/10 hover:shadow-white/20 hover:-translate-y-0.5 active:translate-y-0"
                >
                    {loading ? (
                        <span className="flex items-center gap-2"><Loader2 size={18} className="animate-spin text-black" /> Memproses...</span>
                    ) : (
                        <span className="flex items-center gap-2"><Save size={18} className="text-black" /> Simpan {entries.filter(e => e.date).length > 0 ? entries.filter(e => e.date).length : ''} Evidence</span>
                    )}
                </button>
            </div>
        </div>
    )
}

// Komponen Batch Upload Manual
function QuickAddManualForm({ onUploadManual }: { onUploadManual: (formData: any, entries: any[]) => Promise<boolean> }) {
    const [entries, setEntries] = useState([{ id: Date.now(), date: '', link: '' }]);
    const [formData, setFormData] = useState({
        evidence_title: '',
        evidence_description: '',
        evidence_job: ''
    });
    const [loading, setLoading] = useState(false);
    const [isOpen, setIsOpen] = useState(false);

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const addEntry = () => setEntries([...entries, { id: Date.now(), date: '', link: '' }]);
    const removeEntry = (id: number) => setEntries(entries.filter(e => e.id !== id));
    const updateEntry = (id: number, field: string, value: any) => {
        setEntries(entries.map(e => e.id === id ? { ...e, [field]: value } : e));
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        const validEntries = entries.filter(e => e.date);

        if (!formData.evidence_title || !formData.evidence_job || validEntries.length === 0) {
            new Toast({ position: 'top-right', toastMsg: 'Lengkapi judul, tugas, dan minimal 1 baris tanggal!', type: 'error', theme: 'dark' });
            return;
        }
        setLoading(true);
        const success = await onUploadManual(formData, validEntries);
        setLoading(false);
        if (success) {
            setFormData({ evidence_title: '', evidence_description: '', evidence_job: '' });
            setEntries([{ id: Date.now(), date: '', link: '' }]);
            setIsOpen(false);
        }
    };

    return (
        <div className={`bg-gradient-to-br from-white/[0.04] to-transparent border border-white/10 rounded-3xl overflow-hidden mb-8 transition-all duration-500 shadow-xl ${isOpen ? 'shadow-white/5 ring-1 ring-white/10' : 'hover:bg-white/[0.06] hover:border-white/20'}`}>
            <button
                onClick={() => setIsOpen(!isOpen)}
                className="w-full flex items-center justify-between p-6 transition-all group"
            >
                <div className="flex items-center gap-4">
                    <div className={`p-2.5 rounded-xl transition-all duration-300 ${isOpen ? 'bg-white text-black rotate-45 shadow-lg shadow-white/20' : 'bg-white/10 text-white group-hover:bg-white/20'}`}>
                        <Plus size={20} />
                    </div>
                    <div className="text-left">
                        <h3 className="text-base font-bold text-white tracking-tight">Buat Evidence Manual</h3>
                        <p className="text-xs text-white/40 mt-0.5">Catat pekerjaan yang tidak ada di Calendar of Content (Mendukung Batch Upload)</p>
                    </div>
                </div>
                {isOpen ? <ChevronUp size={24} className="text-white/40" /> : <ChevronDown size={24} className="text-white/40 group-hover:text-white/60 transition-colors" />}
            </button>

            <div className={`transition-all duration-500 ease-in-out origin-top ${isOpen ? 'max-h-[2000px] opacity-100' : 'max-h-0 opacity-0 pointer-events-none'}`}>
                <div className="p-6 pt-0 border-t border-white/5">
                    <form className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6" onSubmit={handleSubmit}>
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-white/50 uppercase tracking-widest pl-1">Judul Pekerjaan</label>
                            <input name="evidence_title" type="text" value={formData.evidence_title} onChange={handleChange} placeholder="Ketik judul singkat dan jelas..." className="w-full rounded-xl border border-white/10 bg-black/30 text-white px-5 py-3.5 text-sm focus:outline-none focus:ring-2 focus:ring-white/20 transition-all placeholder:text-white/20" />
                        </div>
                        <div className="space-y-2 relative">
                            <label className="text-xs font-bold text-white/50 uppercase tracking-widest pl-1">Kategori Tugas</label>
                            <div className="relative">
                                <Briefcase size={16} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/40" />
                                <select name="evidence_job" value={formData.evidence_job} onChange={handleChange} className="appearance-none w-full rounded-xl border border-white/10 bg-black/30 text-white pl-11 pr-10 py-3.5 text-sm focus:outline-none focus:ring-2 focus:ring-white/20 transition-all cursor-pointer">
                                    <option className="bg-[#121212] text-white/50" value="" disabled>Pilih kategori...</option>
                                    <option className="bg-[#121212] text-white" value="Edit/Design Konten">Edit/Design Konten</option>
                                    <option className="bg-[#121212] text-white" value="Take Video">Take Video</option>
                                    <option className="bg-[#121212] text-white" value="Content Production">Content Production</option>
                                    <option className="bg-[#121212] text-white" value="Pemotretan, Dokumentasi">Pemotretan / Dokumentasi</option>
                                    <option className="bg-[#121212] text-white" value="Sosialisasi">Sosialisasi</option>
                                    <option className="bg-[#121212] text-white" value="Lainnya">Lainnya</option>
                                </select>
                                <ChevronDown size={16} className="absolute right-4 top-1/2 -translate-y-1/2 text-white/40 pointer-events-none" />
                            </div>
                        </div>
                        <div className="md:col-span-2 space-y-2">
                            <label className="text-xs font-bold text-white/50 uppercase tracking-widest pl-1">Keterangan Tambahan</label>
                            <textarea name="evidence_description" value={formData.evidence_description} onChange={handleChange} placeholder="Ceritakan detail pengerjaan atau cantumkan link relevan..." className="w-full rounded-xl border border-white/10 bg-black/30 text-white px-5 py-4 h-24 text-sm resize-none focus:outline-none focus:ring-2 focus:ring-white/20 transition-all placeholder:text-white/20" />
                        </div>

                        <div className="md:col-span-2 mt-4 p-5 bg-black/20 rounded-2xl border border-white/5">
                            <div className="flex items-center justify-between mb-5 px-1">
                                <label className="text-xs font-bold text-white/50 uppercase tracking-widest">Daftar Baris Evidence</label>
                                <button type="button" onClick={addEntry} className="text-xs bg-white/5 hover:bg-white/15 text-white px-3 py-2 rounded-lg font-bold flex items-center gap-1.5 transition-all border border-white/10 hover:border-white/20">
                                    <Plus size={14} /> Tambah Baris
                                </button>
                            </div>

                            <div className="space-y-3">
                                {entries.map((entry, index) => (
                                    <div key={entry.id} className="group/row flex flex-col sm:flex-row gap-3 items-start sm:items-center bg-white/[0.02] p-2 rounded-2xl border border-white/5 hover:border-white/10 transition-colors">
                                        <div className="relative w-full sm:w-[170px]">
                                            <CalendarDays size={16} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/40" />
                                            <input
                                                type="date"
                                                max={new Date().toISOString().split('T')[0]}
                                                value={entry.date}
                                                onChange={(e) => updateEntry(entry.id, 'date', e.target.value)}
                                                className="bg-black/30 border border-white/10 rounded-xl pl-11 pr-4 py-3 text-sm text-white focus:outline-none focus:ring-2 focus:ring-white/20 w-full hover:bg-white/5 transition-all"
                                            />
                                        </div>

                                        <div className="relative border border-white/10 rounded-xl px-4 py-3 bg-white/5 hover:bg-white/10 text-sm flex items-center gap-3 flex-1 w-full transition-all group-hover/row:border-white/20">
                                            <div className={`p-1.5 rounded-lg ${entry.link ? 'bg-green-500/20 text-green-400' : 'bg-white/10 text-white/50'}`}>
                                                <Link size={16} />
                                            </div>
                                            <input
                                                type="url"
                                                placeholder="Masukkan link bukti (Opsional)"
                                                value={entry.link}
                                                onChange={(e) => updateEntry(entry.id, 'link', e.target.value)}
                                                className="bg-transparent border-none text-white focus:outline-none w-full"
                                            />
                                        </div>

                                        {entries.length > 1 && (
                                            <button type="button" onClick={() => removeEntry(entry.id)} className="p-3 text-white/30 hover:text-red-400 hover:bg-red-400/10 rounded-xl transition-all border border-transparent hover:border-red-400/20">
                                                <TrashIcon size={18} />
                                            </button>
                                        )}
                                    </div>
                                ))}
                            </div>
                        </div>

                        <div className="md:col-span-2 flex justify-end gap-3 pt-4 border-t border-white/5 mt-2">
                            <button type="submit" disabled={loading} className="bg-white text-black hover:bg-gray-200 rounded-xl px-8 py-3.5 text-sm font-extrabold transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2 shadow-lg shadow-white/10 hover:shadow-white/20 hover:-translate-y-0.5 active:translate-y-0">
                                {loading ? (
                                    <span className="flex items-center gap-2"><Loader2 size={18} className="animate-spin text-black" /> Memproses...</span>
                                ) : (
                                    <span className="flex items-center gap-2"><Save size={18} className="text-black" /> Simpan Semua Evidence</span>
                                )}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    )
}

function EvidenceDashboard() {
    const [sidebarOpen, setSidebarOpen] = useState(false);
    const [selectedMonth, setSelectedMonth] = useState<number>(new Date().getMonth());
    const [selectedStatus, setSelectedStatus] = useState<string>('Semua');
    const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc');
    const [userToDelete, setUserToDelete] = useState<Evidence | null>(null);
    const [confirmOpen, setConfirmOpen] = useState(false);
    const [contentModalOpen, setContentModalOpen] = useState(false);
    const [searchTerm, setSearchTerm] = useState('');
    const [proofOpen, setProofOpen] = useState(false);
    const { data: session, status } = useSession()
    const [acceptedEvidenceTotal, setAcceptedEvidenceTotal] = useState(0);
    const triggerUpdate = useGlobalStore((state) => state.triggerUpdate)
    const updateTrigger = useGlobalStore((state) => state.updateTrigger)
    const [evidenceData, setEvidenceData] = useState<Evidence[]>([]);
    const [loading, setLoading] = useState(false);
    const [selectedContent, setSelectedContent] = useState<any | null>(null)
    const [selectedYear, setSelectedYear] = useState(new Date().getFullYear());
    const [selectedId, setSelectedId] = useState('');
    const [loadingDelete, setLoadingDelete] = useState(false);
    const [contents, setContents] = useState<any[]>([]);
    const [loadingContents, setLoadingContents] = useState(false);

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
                month: String(selectedMonth + 1).padStart(2, '0'),
                find: searchTerm
            }).toString();

            const res = await fetch(`/api/evidences?${query}`);
            if (!res.ok) throw new Error('Gagal fetch data');
            const data = await res.json();

            const mapped: Evidence[] = (data.data || []).map((item: any) => ({
                id: item.id,
                title: item.evidence_title || '',
                description: item.evidence_description || '',
                job: item.evidence_job || '',
                status: item.evidence_status || 'pending',
                date: item.evidence_date || '',
                content_id: item.content_id
            }));

            setEvidenceData(mapped);
            setAcceptedEvidenceTotal(Number(data.acceptedEvidences));
        } catch (err) {
            console.error(err);
            setEvidenceData([]);
            setAcceptedEvidenceTotal(0);
        } finally {
            setLoading(false);
        }
    };

    // fetch contents dari API
    const fetchContents = async () => {
        try {
            setLoadingContents(true);
            const user_email = session?.user?.email;
            if (!user_email) {
                setLoadingContents(false);
                setContents([]);
                return;
            }

            const res = await fetch(`/api/content?user=${user_email}`);
            if (!res.ok) throw new Error('Gagal fetch content');
            const data = await res.json();

            setContents(data.data || []);
        } catch (err) {
            console.error(err);
            setContents([]);
        } finally {
            setLoadingContents(false);
        }
    };

    // jalankan saat pertama load & updateTrigger bertambah
    useEffect(() => {
        fetchEvidences();
        fetchContents();
    }, [status, selectedMonth, selectedYear, searchTerm, updateTrigger]);

    // delete evidence
    const confirmDelete = async (id: any) => {
        setLoadingDelete(true);
        try {
            const res = await fetch(`/api/evidences/${id}`, {
                method: "DELETE",
            });

            if (res.ok) {
                setUserToDelete(null);
                fetchEvidences();
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

    // Batch Upload Evidence CoC
    const handleUploadEvidence = async (content: any, entries: any[], job: string): Promise<boolean> => {
        try {
            let successCount = 0;
            const batchSize = 3;

            for (let i = 0; i < entries.length; i += batchSize) {
                const batch = entries.slice(i, i + batchSize);
                const uploadPromises = batch.map(async (entry) => {
                    const formPayload = new FormData();
                    formPayload.append('evidence_title', content.content_title);
                    formPayload.append('evidence_description', content.content_caption || '-');
                    formPayload.append('evidence_date', entry.date); // Gunakan tanggal dari entry!
                    formPayload.append('evidence_job', job);
                    formPayload.append('content_id', content.id);
                    if (entry.link) {
                        formPayload.append('completion_proof', entry.link);
                    }

                    const response = await fetch('/api/evidences', { method: 'POST', body: formPayload });
                    return response.ok;
                });

                const results = await Promise.all(uploadPromises);
                successCount += results.filter(ok => ok).length;
            }

            if (successCount === entries.length) {
                new Toast({ position: 'top-right', toastMsg: `${successCount} Evidence berhasil disimpan!`, type: 'success', theme: 'dark' });
                fetchEvidences();
                return true;
            } else if (successCount > 0) {
                new Toast({ position: 'top-right', toastMsg: `Sebagian evidence gagal. Berhasil: ${successCount}`, type: 'warning', theme: 'dark' });
                fetchEvidences();
                return true;
            } else {
                new Toast({ position: 'top-right', toastMsg: 'Gagal menyimpan evidence!', type: 'error', theme: 'dark' });
                return false;
            }
        } catch (error) {
            console.error(error);
            new Toast({ position: 'top-right', toastMsg: 'Terjadi kesalahan sistem!', type: 'error', theme: 'dark' });
            return false;
        }
    };

    // Batch Upload Manual
    const handleUploadManual = async (formData: any, entries: any[]): Promise<boolean> => {
        try {
            let successCount = 0;
            const batchSize = 3;

            for (let i = 0; i < entries.length; i += batchSize) {
                const batch = entries.slice(i, i + batchSize);
                const uploadPromises = batch.map(async (entry) => {
                    const formPayload = new FormData();
                    formPayload.append('evidence_title', formData.evidence_title);
                    formPayload.append('evidence_description', formData.evidence_description);
                    formPayload.append('evidence_date', entry.date); // Gunakan tanggal dari entry!
                    formPayload.append('evidence_job', formData.evidence_job);
                    formPayload.append('content_id', '');
                    if (entry.link) {
                        formPayload.append('completion_proof', entry.link);
                    }

                    const response = await fetch('/api/evidences', { method: 'POST', body: formPayload });
                    return response.ok;
                });

                const results = await Promise.all(uploadPromises);
                successCount += results.filter(ok => ok).length;
            }

            if (successCount === entries.length) {
                new Toast({ position: 'top-right', toastMsg: `${successCount} Evidence berhasil disimpan!`, type: 'success', theme: 'dark' });
                fetchEvidences();
                return true;
            } else if (successCount > 0) {
                new Toast({ position: 'top-right', toastMsg: `Sebagian evidence gagal. Berhasil: ${successCount}`, type: 'warning', theme: 'dark' });
                fetchEvidences();
                return true;
            } else {
                new Toast({ position: 'top-right', toastMsg: 'Gagal menyimpan evidence!', type: 'error', theme: 'dark' });
                return false;
            }
        } catch (error) {
            console.error(error);
            new Toast({ position: 'top-right', toastMsg: 'Terjadi kesalahan sistem!', type: 'error', theme: 'dark' });
            return false;
        }
    };

    const statusOrder: Record<EvidenceStatus, number> = {
        needaction: 1,
        pending: 2,
        rejected: 3,
        accepted: 4,
    };

    const filteredEvidence = evidenceData
        .filter((item) => {
            const itemDate = new Date(item.date);
            const itemMonth = itemDate.getMonth();
            const itemYear = itemDate.getFullYear();

            const statusMatch = selectedStatus === 'Semua' || item.status === selectedStatus;
            const monthMatch = itemMonth === selectedMonth;
            const yearMatch = selectedYear === null || itemYear === selectedYear;

            return monthMatch && yearMatch && statusMatch;
        })
        .sort((a, b) => {
            const statusDiff = statusOrder[a.status] - statusOrder[b.status];
            if (statusDiff !== 0) return statusDiff;
            return sortOrder === 'asc'
                ? new Date(a.date).getTime() - new Date(b.date).getTime()
                : new Date(b.date).getTime() - new Date(a.date).getTime();
        });

    // Check un-evidenced contents for checklist
    const pendingContents = contents.filter((c) => {
        const cDate = new Date(c.content_date);
        if (cDate.getMonth() !== selectedMonth || cDate.getFullYear() !== selectedYear) return false;
        // Cek apakah sudah ada di evidenceData
        const hasEvidence = evidenceData.some((e) => e.content_id === c.id);
        return !hasEvidence; // Tetap di-hide setelah upload pertama kali supaya tidak penuh. Jika butuh lebih banyak, mereka harus upload sekaligus (batch).
    });

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

                    <main className="flex-1 p-5 md:p-10 overflow-y-auto">
                        {/* Heading */}
                        <div className="mb-6">
                            <h1 className="text-4xl font-extrabold mb-2 tracking-tight">Point Evidence</h1>
                            <p className="text-white/50 text-lg">Kelola dan kumpulkan bukti pekerjaan harianmu.</p>
                        </div>

                        {/* Main content wrapper */}
                        <div className="flex flex-col md:flex-row w-full gap-y-6 md:gap-x-8">
                            {/* Left section - Search & List */}
                            <div className="w-full md:flex-1">

                                {/* Quick Add Checklist Section */}
                                <div className="mb-8">
                                    <h2 className="text-lg font-semibold text-white mb-4 flex items-center gap-2">
                                        <CheckCircle2 size={20} className="text-green-400" /> Checklist Calendar of Content
                                    </h2>
                                    {loadingContents || loading ? (
                                        <div className="text-sm text-white/40 py-6 text-center border border-white/10 rounded-xl bg-white/5">
                                            Memuat checklist...
                                        </div>
                                    ) : pendingContents.length > 0 ? (
                                        <div className="space-y-4">
                                            {pendingContents.map(content => (
                                                <QuickAddRow key={content.id} content={content} onUpload={handleUploadEvidence} />
                                            ))}
                                        </div>
                                    ) : (
                                        <div className="text-sm text-white/50 py-6 text-center border border-white/10 rounded-xl bg-white/5 italic">
                                            Semua Calendar of Content bulan ini sudah dilengkapi evidence! 🎉
                                        </div>
                                    )}
                                </div>

                                <QuickAddManualForm onUploadManual={handleUploadManual} />

                                {/* Divider */}
                                <div className="h-px bg-white/10 w-full mb-6 mt-2"></div>
                                <h2 className="text-lg font-semibold text-white mb-4 flex items-center gap-2">
                                    <FileIcon size={20} className="text-white/80" /> Daftar Evidence
                                </h2>

                                {/* Search bar */}
                                <div className="relative w-full mb-4">
                                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-white/30" size={18} />
                                    <input
                                        type="text"
                                        value={searchTerm}
                                        onChange={(e) => setSearchTerm(e.target.value)}
                                        placeholder="Cari evidence yang sudah terunggah..."
                                        className="w-full pl-10 pr-3 py-3 text-sm rounded-xl bg-[#1f1f1f] border border-white/10 text-white focus:outline-none focus:border-white/20 transition-all shadow-inner"
                                    />
                                </div>

                                {loading === true ? (
                                    <div className="text-sm text-white/40 italic py-10 text-center border border-white/10 rounded-xl bg-[#1f1f1f]">
                                        <div className="text-center py-2">
                                            <div className="relative w-8 h-8 mx-auto">
                                                <div className="absolute inset-0 border-[3px] border-white border-t-transparent rounded-full animate-spin"></div>
                                            </div>
                                            <p className="text-sm font-medium text-white/70 animate-pulse mt-3">Memuat data evidence...</p>
                                        </div>
                                    </div>
                                ) : (
                                    <>
                                        {/* Evidence list */}
                                        {filteredEvidence.length === 0 ? (
                                            <div className="text-sm text-white/40 italic py-10 text-center border border-white/10 rounded-xl bg-[#1f1f1f]">
                                                Belum ada evidence di bulan ini.
                                            </div>
                                        ) : (
                                            <div className="space-y-4">
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
                            <div className="w-full md:w-64 md:sticky md:top-10 space-y-6">
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
                                        <p className="text-[3rem] font-black text-white leading-none tracking-tight">
                                            {acceptedEvidenceTotal}
                                        </p>
                                    </div>

                                </div>

                                {/* Filter Tahun */}
                                <div className="mb-4">
                                    <select
                                        value={selectedYear}
                                        onChange={(e) => setSelectedYear(Number(e.target.value))}
                                        className="w-full rounded-xl border border-white/10 bg-white/5 text-white px-4 py-3 font-medium focus:outline-none focus:ring-2 focus:ring-white/20 transition-all"
                                    >
                                        {Array.from({ length: 5 }, (_, i) => {
                                            const year = new Date().getFullYear() - 2 + i;
                                            return (
                                                <option key={year} value={year} className="bg-black text-white">
                                                    Tahun {year}
                                                </option>
                                            );
                                        })}
                                    </select>
                                </div>


                                {/* Filter Bulan */}
                                <div className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl p-5">
                                    <h2 className="text-sm font-semibold text-white mb-4 flex items-center gap-2">
                                        <CalendarDays size={16} className="text-white/80" />
                                        Filter Bulan
                                    </h2>
                                    <div className="grid grid-cols-2 gap-2">
                                        {monthNames.map((month, i) => {
                                            const isSelected = selectedMonth === i;
                                            return (
                                                <button
                                                    key={i}
                                                    onClick={() => setSelectedMonth(i)}
                                                    className={`w-full rounded-lg px-4 py-2.5 text-sm font-medium text-center transition-all duration-300 border
                            ${isSelected
                                                            ? 'bg-white/10 border-white/20 text-white shadow-lg ring-1 ring-white/20'
                                                            : 'bg-black/20 border-white/5 text-white/50 hover:bg-white/5 hover:text-white'}
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
