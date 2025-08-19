import { useState, useEffect } from 'react'
import { Save, Pencil, TrashIcon, UploadCloud, Check, Copy, Image, Loader2 } from 'lucide-react'
import ContentModal from '@/components/dashboard/layout/contentModal'
import Toast from 'typescript-toastify'
import { useGlobalStore } from '@/app/lib/global-store'

interface Props {
    isOpen: boolean
    onClose: () => void
    selectedEvidence?: { id: string } | null
}

const ContentModalEvidence = ({ isOpen, onClose, selectedEvidence }: Props) => {
    const [formData, setFormData] = useState({
        evidence_title: '',
        evidence_description: '',
        evidence_job: '',
        evidence_date: '',
        completion_proof: null as File | null,
    })
    const [isEditMode, setIsEditMode] = useState(false)
    const [copied, setCopied] = useState(false)
    const [selectedFile, setSelectedFile] = useState<File | null>(null)
    const [loading, setLoading] = useState(false)
    const [proofUrl, setProofUrl] = useState<string | null>(null)
    const [isSubmitting, setIsSubmitting] = useState(false) // untuk submit
    const [isDeleting, setIsDeleting] = useState(false) // untuk delete
    const setUpdated = useGlobalStore(state => state.setUpdated)


    useEffect(() => {
        if (!selectedEvidence) {
            onClose()
            return
        }

        setLoading(true)
        fetch(`/api/evidences/${selectedEvidence.id}`)
            .then(res => {
                if (!res.ok) throw new Error('Gagal mengambil data evidence')
                return res.json()
            })
            .then(data => {
                setFormData({
                    evidence_title: data.evidence_title || '',
                    evidence_description: data.evidence_description || '',
                    evidence_job: data.evidence_job || '',
                    evidence_date: data.evidence_date || '',
                    completion_proof: null, // File diinput manual kalau edit
                })
                setProofUrl(data.completion_proof || null)
                setSelectedFile(null)
                setIsEditMode(false)
            })
            .catch(err => {
                console.error(err)
                onClose()
            })
            .finally(() => setLoading(false))
    }, [selectedEvidence])

    function handleChange(e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) {
        const { name, value, files } = e.target as HTMLInputElement
        if (files) {
            setSelectedFile(files[0])
            setFormData(prev => ({ ...prev, completion_proof: files[0] }))
        } else {
            setFormData(prev => ({ ...prev, [name]: value }))
        }
    }

    const handleCopy = () => {
        navigator.clipboard.writeText(formData.evidence_description || '-')
        setCopied(true)
        setTimeout(() => setCopied(false), 2000)
    }

    async function handleSubmit(e: React.FormEvent) {
        e.preventDefault()
        setIsSubmitting(true)

        const form = new FormData()
        Object.entries(formData).forEach(([key, value]) => {
            if (value) form.append(key, value as any)
        })

        const method = selectedEvidence ? 'PUT' : 'POST'
        const url = selectedEvidence ? `/api/evidences/${selectedEvidence.id}` : '/api/evidences'

        try {
            const response = await fetch(url, { method, body: form })

            if (response.ok) {
                new Toast({
                    position: 'top-right',
                    toastMsg: selectedEvidence ? 'Berhasil menyimpan evidence!' : 'Berhasil menambahkan evidence!',
                    autoCloseTime: 3000,
                    showProgress: true,
                    pauseOnHover: true,
                    pauseOnFocusLoss: true,
                    type: 'success',
                    theme: 'dark',
                })
                setIsEditMode(false)
                setUpdated(true)
                onClose()
            } else {
                throw new Error('Gagal menyimpan')
            }
        } catch (err) {
            console.error(err)
            new Toast({
                position: 'top-right',
                toastMsg: selectedEvidence ? 'Gagal menyimpan perubahan!' : 'Gagal menambahkan evidence!',
                autoCloseTime: 3000,
                showProgress: true,
                pauseOnHover: true,
                pauseOnFocusLoss: true,
                type: 'error',
                theme: 'dark',
            })
        } finally {
            setIsSubmitting(false)
        }
    }


    async function handleDelete(id: any) {
        if (!id) return
        setIsDeleting(true)

        try {
            const response = await fetch(`/api/evidences/${id}`, { method: 'DELETE' })
            if (response.ok) {
                new Toast({
                    position: 'top-right',
                    toastMsg: 'Berhasil menghapus!',
                    autoCloseTime: 3000,
                    showProgress: true,
                    pauseOnHover: true,
                    pauseOnFocusLoss: true,
                    type: 'success',
                    theme: 'dark',
                })
                setUpdated(true)
                onClose()
            } else {
                throw new Error('Gagal menghapus')
            }
        } catch (err) {
            console.error(err)
            new Toast({
                position: 'top-right',
                toastMsg: 'Gagal menghapus!',
                autoCloseTime: 3000,
                showProgress: true,
                pauseOnHover: true,
                pauseOnFocusLoss: true,
                type: 'warning',
                theme: 'dark',
            })
        } finally {
            setIsDeleting(false)
        }
    }


    return (
        <ContentModal isOpen={isOpen} onClose={onClose}>
            <h2 className="text-2xl font-semibold mb-6">
                {selectedEvidence ? 'Lihat & Edit Evidence' : 'Tambah Evidence Baru'}
            </h2>
            {loading ? (
                <p className="text-white/60">Loading data...</p>
            ) : (
                <form className="grid grid-cols-1 md:grid-cols-2 gap-5 text-sm" onSubmit={handleSubmit}>
                    {/* Judul */}
                    <div className="md:col-span-2">
                        <label className="block text-white font-medium mb-1">Evidence</label>
                        <input
                            name="evidence_title"
                            type="text"
                            value={formData.evidence_title}
                            onChange={handleChange}
                            disabled={!isEditMode}
                            placeholder="Masukkan judul konten"
                            className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-white/20 ${!isEditMode && 'opacity-70 cursor-default'
                                }`}
                        />
                    </div>

                    {/* Deskripsi + Copy */}
                    <div className="md:col-span-2">
                        <div className="flex justify-between items-center">
                            <label className="block text-white font-medium mb-1">Keterangan</label>
                            {!isEditMode && (
                                <button
                                    type="button"
                                    onClick={handleCopy}
                                    className="flex items-center gap-1 text-white text-sm hover:text-white/80"
                                >
                                    {copied ? (
                                        <>
                                            <Check size={16} /> Disalin
                                        </>
                                    ) : (
                                        <>
                                            <Copy size={16} /> Salin
                                        </>
                                    )}
                                </button>
                            )}
                        </div>
                        <textarea
                            name="evidence_description"
                            value={formData.evidence_description}
                            onChange={handleChange}
                            disabled={!isEditMode}
                            placeholder="Masukkan keterangan..."
                            className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 h-28 placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-white/20 resize-none ${!isEditMode && 'opacity-70 cursor-default'
                                }`}
                        />
                    </div>

                    {/* File */}
                    <div className="md:col-span-2">
                        <label className="block text-white font-medium mb-2">Bukti</label>

                        {proofUrl && !isEditMode ? (
                            <div
                                className={`relative flex items-center justify-between w-full rounded-lg border px-4 py-3 cursor-pointer transition group border-white/10 bg-white/5 ${isEditMode && `opacity-70 cursor-default`}`}
                            >
                                <span className="truncate text-white/60 ">
                                    Klik "Edit" untuk mengubah bukti...
                                </span>
                                <UploadCloud
                                    className={`w-5 h-5 transition ${selectedFile ? 'text-white/50 group-hover:text-white' : 'text-white/60 '
                                        }`}
                                />
                                <input
                                    type="file"
                                    name="completion_proof"
                                    accept="image/*,.pdf"
                                    onChange={handleChange}
                                    disabled={!isEditMode}
                                    className="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
                                />
                            </div>
                        ) : (
                            <div
                                className={`relative flex items-center justify-between w-full rounded-lg border px-4 py-3 cursor-pointer transition group ${isEditMode
                                    ? 'border-white/20 bg-white/10 hover:bg-white/15'
                                    : 'border-white/10 bg-white/5'
                                    }`}
                            >
                                {selectedFile ? (
                                    <span className="truncate text-white/70">{selectedFile.name}</span>
                                ) : (
                                    <span className="truncate text-white/60">
                                        Klik untuk memilih file...
                                    </span>
                                )}
                                <UploadCloud
                                    className={`w-5 h-5 transition ${selectedFile ? 'text-white/50 group-hover:text-white' : 'text-white/60 '
                                        }`}
                                />
                                <input
                                    type="file"
                                    name="completion_proof"
                                    accept="image/*,.pdf"
                                    onChange={handleChange}
                                    disabled={!isEditMode}
                                    className="absolute inset-0 w-full h-full opacity-0 cursor-pointer"
                                />
                            </div>
                        )}
                    </div>

                    {/* Job */}
                    <div>
                        <label className="block text-white font-medium mb-1">Tugas</label>
                        <select
                            name="evidence_job"
                            value={formData.evidence_job}
                            onChange={handleChange}
                            disabled={!isEditMode}
                            className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 focus:outline-none focus:ring-2 focus:ring-white/20 ${!isEditMode && 'opacity-70 cursor-default'
                                }`}
                        >
                            <option className="bg-black text-white" value="">
                                Pilih tugas
                            </option>
                            <option className="bg-black text-white" value="Edit/Design Konten">
                                Edit/Design Konten
                            </option>
                            <option className="bg-black text-white" value="Take Video">
                                Take Video
                            </option>
                            <option className="bg-black text-white" value="Content Production">
                                Content Production
                            </option>
                            <option className="bg-black text-white" value="Pemotretan, Dokumentasi">
                                Pemotretan / Dokumentasi
                            </option>
                            <option className="bg-black text-white" value="Sosialisasi">
                                (BA) Sosialisasi
                            </option>
                            <option className="bg-black text-white" value="Lainnya">
                                Lainnya
                            </option>
                        </select>
                    </div>

                    {/* Date */}
                    <div>
                        <label className="block text-white font-medium mb-1">Tanggal</label>
                        <input
                            name="evidence_date"
                            type="date"
                            value={formData.evidence_date}
                            onChange={handleChange}
                            disabled={!isEditMode}
                            className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 ${!isEditMode && 'opacity-70 cursor-default'
                                }`}
                        />
                    </div>

                    {/* Actions */}
                    <div className="md:col-span-2 flex justify-between flex-row-reverse gap-3 pt-2">
                        {isEditMode ? (
                            <div className="flex gap-3">
                                <button
                                    type="button"
                                    onClick={() => {
                                        if (selectedEvidence) {
                                            setIsEditMode(false)
                                        } else {
                                            onClose()
                                        }
                                    }}
                                    className="px-5 py-2.5 rounded-lg text-sm font-medium bg-white/10 text-white hover:bg-white/20"
                                >
                                    Batal
                                </button>
                                <button
                                    type="submit"
                                    disabled={isSubmitting}
                                    className="px-5 py-2.5 rounded-lg text-sm font-medium bg-white/20 text-white hover:bg-white/30 flex items-center gap-2"
                                >
                                    {isSubmitting ? <><Loader2 size={16} className="animate-spin" /> Menyimpan...</> : <><Save size={16} /> Simpan</>}
                                </button>
                            </div>
                        ) : (
                            <>
                                <button
                                    type="button"
                                    onClick={() => setIsEditMode(true)}
                                    className="px-5 py-2.5 rounded-lg text-sm font-medium bg-white/20 text-white hover:bg-white/30 flex items-center gap-2"
                                >
                                    <Pencil size={16} /> Edit
                                </button>
                                <button
                                    type="button"
                                    onClick={() => handleDelete(selectedEvidence?.id)}
                                    disabled={isDeleting}
                                    className="px-5 py-2.5 rounded-lg text-sm font-medium bg-red-600 text-white hover:bg-red-700 flex items-center gap-2"
                                >
                                    {isDeleting ? <><Loader2 size={16} className="animate-spin" /> Menghapus...</> : <><TrashIcon size={16} /> Hapus</>}
                                </button>
                            </>
                        )}
                    </div>
                </form>
            )}
        </ContentModal>
    )
}

export default ContentModalEvidence
