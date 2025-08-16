import { useState, useEffect } from 'react'
import { Check, Copy, Pencil, Save, TrashIcon, X } from 'lucide-react'
import ContentModal from '@/components/dashboard/layout/contentModal'
import Toast from 'typescript-toastify'
import { useGlobalStore } from '@/app/lib/global-store'

interface ContentModalProps {
    isOpen: boolean
    onClose: () => void
    selectedContent?: any
}

const ContentModalCOC = ({ isOpen, onClose, selectedContent }: ContentModalProps) => {
    const [formData, setFormData] = useState({
        content_category: "",
        content_type: "",
        content_title: "",
        content_caption: "",
        content_feedback: "",
        content_date: "",
    })
    const [isEditMode, setIsEditMode] = useState(false)
    const [copied, setCopied] = useState(false)
    const setUpdated = useGlobalStore(state => state.setUpdated);

    useEffect(() => {
        if (selectedContent) {
            setFormData({
                content_category: selectedContent.content_category || "",
                content_type: selectedContent.content_type || "",
                content_title: selectedContent.content_title || "",
                content_caption: selectedContent.content_caption || "",
                content_feedback: selectedContent.content_feedback || "",
                content_date: selectedContent.content_date || "",
            })
            setIsEditMode(false) // reset edit mode kalau konten baru dimuat
        } else {
            setFormData({
                content_category: "",
                content_type: "",
                content_title: "",
                content_caption: "",
                content_feedback: "",
                content_date: "",
            })
            setIsEditMode(true) // langsung edit mode kalau tambah baru
        }
    }, [selectedContent])

    function handleChange(e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) {
        const { name, value } = e.target
        setFormData(prev => ({ ...prev, [name]: value }))
    }

    const handleCopy = () => {
        navigator.clipboard.writeText(formData.content_caption || '-')
        setCopied(true)
        setTimeout(() => setCopied(false), 2000)
    }

    async function handleSubmit(e: React.FormEvent) {
        e.preventDefault()
        if (!selectedContent) {
            // Tambah baru (POST)
            const response = await fetch('/api/content', {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    ...formData,
                    created_at: new Date().toISOString(),
                }),
            })

            if (response.ok) {
                new Toast({
                    position: "top-right",
                    toastMsg: "Berhasil menambahkan konten baru!",
                    autoCloseTime: 3000,
                    showProgress: true,
                    pauseOnHover: true,
                    pauseOnFocusLoss: true,
                    type: "success",
                    theme: "dark",
                })
                onClose()
                setUpdated(true)
            } else {
                new Toast({
                    position: "top-right",
                    toastMsg: "Gagal menambahkan konten!",
                    autoCloseTime: 3000,
                    showProgress: true,
                    pauseOnHover: true,
                    pauseOnFocusLoss: true,
                    type: "error",
                    theme: "dark",
                })
            }
        } else {
            // Edit (PUT)
            const response = await fetch(`/api/content/${selectedContent.id}`, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    ...formData,
                    created_at: new Date().toISOString(),
                }),
            })

            if (response.ok) {
                new Toast({
                    position: "top-right",
                    toastMsg: "Berhasil menyimpan konten!",
                    autoCloseTime: 3000,
                    showProgress: true,
                    pauseOnHover: true,
                    pauseOnFocusLoss: true,
                    type: "success",
                    theme: "dark",
                })
                setIsEditMode(false)
                setUpdated(true)
            } else {
                new Toast({
                    position: "top-right",
                    toastMsg: "Gagal menyimpan perubahan!",
                    autoCloseTime: 3000,
                    showProgress: true,
                    pauseOnHover: true,
                    pauseOnFocusLoss: true,
                    type: "error",
                    theme: "dark",
                })
            }
        }
    }

    async function handleDelete(id: any) {
        const response = await fetch(`/api/content/${id}`, {
            method: "DELETE",
            headers: { "Content-Type": "application/json" },
        })

        if (response.ok) {
            new Toast({
                position: "top-right",
                toastMsg: "Berhasil menghapus!",
                autoCloseTime: 3000,
                showProgress: true,
                pauseOnHover: true,
                pauseOnFocusLoss: true,
                type: "success",
                theme: "dark",
            })
            onClose()
            setUpdated(true)
        } else {
            new Toast({
                position: "top-right",
                toastMsg: "Gagal menghapus!",
                autoCloseTime: 3000,
                showProgress: true,
                pauseOnHover: true,
                pauseOnFocusLoss: true,
                type: "warning",
                theme: "dark",
            })
        }
    }

    return (
        <ContentModal isOpen={isOpen} onClose={onClose}>
            <h2 className="text-2xl font-semibold mb-6">
                {selectedContent ? "Lihat & Edit Konten" : "Tambah Konten Baru"}
            </h2>

            <form
                className="grid grid-cols-1 md:grid-cols-2 gap-5 text-sm"
                onSubmit={handleSubmit}
            >
                {/* Kategori Konten */}
                <div>
                    <label className="block text-white font-medium mb-1">
                        Kategori Konten
                    </label>
                    <select
                        name="content_category"
                        value={formData.content_category}
                        onChange={handleChange}
                        disabled={!isEditMode}
                        className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20
            ${!isEditMode ? "opacity-70 cursor-default" : "focus:outline-none focus:ring-2 focus:ring-white/20"}`}
                    >
                        <option className="bg-black text-white" value="">
                            Pilih kategori
                        </option>
                        <option className="bg-black text-white" value="Edukasi dan Informasi">
                            Edukasi dan Informasi
                        </option>
                        <option className="bg-black text-white" value="Prestasi dan Penghargaan">
                            Prestasi dan Penghargaan
                        </option>
                        <option className="bg-black text-white" value="Teknologi dan Inovasi">
                            Teknologi dan Inovasi
                        </option>
                        <option className="bg-black text-white" value="Konten Kreatif dan Hiburan">
                            Konten Kreatif dan Hiburan
                        </option>
                        <option className="bg-black text-white" value="Lainnya">
                            Lainnya
                        </option>
                    </select>
                </div>

                {/* Jenis Konten */}
                <div>
                    <label className="block text-white font-medium mb-1">
                        Jenis Konten
                    </label>
                    <select
                        name="content_type"
                        value={formData.content_type}
                        onChange={handleChange}
                        disabled={!isEditMode}
                        className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20
            ${!isEditMode ? "opacity-70 cursor-default" : "focus:outline-none focus:ring-2 focus:ring-white/20"}`}
                    >
                        <option className="bg-black text-white" value="">
                            Pilih tipe
                        </option>
                        <option className="bg-black text-white" value="Flyer/Poster">
                            Flyer/Poster
                        </option>
                        <option className="bg-black text-white" value="Video">
                            Video
                        </option>
                        <option className="bg-black text-white" value="Foto">
                            Foto
                        </option>
                    </select>
                </div>

                {/* Judul Konten */}
                <div className="md:col-span-2">
                    <label className="block text-white font-medium mb-1">Judul Konten</label>
                    <input
                        name="content_title"
                        type="text"
                        value={formData.content_title}
                        onChange={handleChange}
                        disabled={!isEditMode}
                        placeholder="Masukkan judul konten"
                        className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20 placeholder-white/40
            ${!isEditMode ? "opacity-70 cursor-default" : "focus:outline-none focus:ring-2 focus:ring-white/20"}`}
                    />
                </div>

                {/* Caption + Copy */}
                <div className="md:col-span-2">
                    <div className="flex justify-between items-center">
                        <label className="block text-white font-medium mb-1">Caption</label>
                        {!isEditMode && (
                            <button
                                type="button"
                                onClick={handleCopy}
                                className="flex items-center gap-1 text-white text-sm hover:text-white/80 cursor-pointer"
                            >
                                {copied ? (
                                    <>
                                        <Check size={16} /> Berhasil disalin
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
                        name="content_caption"
                        value={formData.content_caption}
                        onChange={handleChange}
                        disabled={!isEditMode}
                        placeholder="Masukkan caption konten..."
                        className={`w-full rounded-lg border bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20 h-28 border-white/20 placeholder-white/40
            ${!isEditMode ? "opacity-70 cursor-default" : "focus:outline-none focus:ring-2 focus:ring-white/20"}`}
                    />
                </div>

                {/* Feedback */}
                <div>
                    <label className="block text-white font-medium mb-1">Feedback</label>
                    <select
                        name="content_feedback"
                        value={formData.content_feedback}
                        onChange={handleChange}
                        disabled={!isEditMode}
                        className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20
            ${!isEditMode ? "opacity-70 cursor-default" : "focus:outline-none focus:ring-2 focus:ring-white/20"}`}
                    >
                        <option className="bg-black text-white" value="">
                            Pilih feedback
                        </option>
                        <option className="bg-black text-white" value="Feed, Story, WhatsApp">
                            Feed, Story, WhatsApp
                        </option>
                        <option className="bg-black text-white" value="Video, Reels, Tiktok">
                            Video, Reels, Tiktok
                        </option>
                        <option className="bg-black text-white" value="Lainnya">
                            Lainnya
                        </option>
                    </select>
                </div>

                {/* Tanggal Upload */}
                <div>
                    <label className="block text-white font-medium mb-1">Tanggal Upload</label>
                    <input
                        name="content_date"
                        type="date"
                        value={formData.content_date}
                        onChange={handleChange}
                        disabled={!isEditMode}
                        className={`w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20
            ${!isEditMode ? "opacity-70 cursor-default" : "focus:outline-none focus:ring-2 focus:ring-white/20"}`}
                    />
                </div>

                {/* Actions */}
                <div className="md:col-span-2 flex items-center justify-between flex-row-reverse gap-3 pt-2">
                    {isEditMode ? (
                        <div className='flex items-center justify-end gap-3'>
                            <button
                                type="button"
                                onClick={() => {
                                    if (selectedContent) {
                                        setFormData({
                                            content_category: selectedContent.content_category || "",
                                            content_type: selectedContent.content_type || "",
                                            content_title: selectedContent.content_title || "",
                                            content_caption: selectedContent.content_caption || "",
                                            content_feedback: selectedContent.content_feedback || "",
                                            content_date: selectedContent.content_date || "",
                                        })
                                        setIsEditMode(false)
                                    } else {
                                        onClose()
                                    }
                                }}
                                className="flex items-center gap-2 px-5 py-2.5 rounded-lg text-sm font-medium bg-white/10 hover:bg-white/20 text-white transition"
                            >
                                Batal
                            </button>
                            <button
                                type="submit"
                                className="flex items-center gap-2 px-5 py-2.5 rounded-lg text-sm font-medium bg-white/20 hover:bg-white/30 text-white transition"
                            >
                                <Save size={16} /> Simpan
                            </button>
                        </div>
                    ) : (
                        <>
                            <button
                                type="button"
                                onClick={() => setIsEditMode(true)}
                                className="flex items-center gap-2 px-5 py-2.5 rounded-lg text-sm font-medium bg-white/20 hover:bg-white/30 text-white transition"
                            >
                                <Pencil size={16} /> Edit
                            </button>
                            <button
                                type="button"
                                onClick={() => handleDelete(selectedContent.id)}
                                className="flex items-center gap-2 bg-red-600 px-5 py-2.5 rounded-md text-sm font-medium hover:bg-red-700 text-white transition"
                            >
                                <TrashIcon size={16} /> Hapus
                            </button>
                        </>
                    )}

                </div>
            </form>
        </ContentModal>
    )
}

export default ContentModalCOC
