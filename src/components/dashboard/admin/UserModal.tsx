'use client'

import { useEffect, useState } from 'react'
import { supabase } from '@/app/lib/supabase'
import { useGlobalStore } from '@/app/lib/global-store'
import { X } from 'lucide-react'
import Toast from 'typescript-toastify'

export default function UserModal({ isOpen, onClose, selectedUser }: any) {
    const [name, setName] = useState('')
    const [email, setEmail] = useState('')
    const [role, setRole] = useState('')
    const setUpdated = useGlobalStore((state) => state.setUpdated)

    useEffect(() => {
        if (isOpen) {
            if (selectedUser) {
                setName(selectedUser.name)
                setEmail(selectedUser.email)
                setRole(selectedUser.role)
            } else {
                setName('')
                setEmail('')
                setRole('user') // ini harus kepanggil pas modal dibuka
            }
        }
    }, [isOpen, selectedUser])

    const handleSave = async () => {
        if (!name || !email || !role) {
            onClose();
            new Toast({
                position: "top-right",
                toastMsg: "Semua field harus diisi!",
                autoCloseTime: 3000,
                showProgress: true,
                pauseOnHover: true,
                pauseOnFocusLoss: true,
                type: "error",
                theme: "dark"
            });
            return;
        }

        const dataToSave = { name, email, role };

        let res;

        if (selectedUser) {
            res = await supabase.from('users').update(dataToSave).eq('id', selectedUser.id);
        } else {
            res = await supabase.from('users').insert([dataToSave]);
        }

        if (!email.endsWith('@student.smktelkom-pwt.sch.id')) {
            onClose();
            new Toast({
                position: "top-right",
                toastMsg: "Email harus pakai domain sekolah!",
                autoCloseTime: 3000,
                type: "error",
                theme: "dark"
            });
            return;
        }


        if (res.error) {
            console.error("❌ Supabase Error:", res.error.message);
            alert("Gagal menyimpan data: " + res.error.message);
            return;
        }

        setUpdated(true);
        onClose();
    };


    if (!isOpen) return null

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm">
            <div className="relative w-full max-w-lg mx-auto bg-[#1c1c1c] border border-white/10 rounded-2xl p-6 shadow-xl animate-fadeIn">
                <button
                    onClick={onClose}
                    className="absolute top-4 right-4 text-white/50 hover:text-white transition"
                >
                    <X size={20} />
                </button>

                <h2 className="text-2xl font-bold text-white mb-6">
                    {selectedUser ? 'Edit Pengguna' : 'Tambah Pengguna'}
                </h2>

                <form className="space-y-4">
                    <div>
                        <label className="text-sm text-white/70 mb-1 block">Nama</label>
                        <input
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                            placeholder="Nama lengkap"
                            className="w-full px-4 py-2 rounded-lg bg-[#121212] text-white border border-white/10 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                        />
                    </div>

                    <div>
                        <label className="text-sm text-white/70 mb-1 block">Email</label>
                        <input
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            placeholder="Wajib email sekolah (@student.smktelkom-pwt.sch.id)"
                            className="w-full px-4 py-2 rounded-lg bg-[#121212] text-white border border-white/10 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                        />
                    </div>

                    <div>
                        <label className="text-sm text-white/70 mb-1 block">Role</label>
                        <select
                            value={role}
                            onChange={(e) => setRole(e.target.value)}
                            className="w-full px-4 py-2 rounded-lg bg-[#121212] text-white border border-white/10 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
                        >
                            <option value={"admin"}>Admin</option>
                            <option value={"ba"}>Brand Ambassador</option>
                            <option value={"timkonten"}>Tim Konten</option>
                        </select>
                    </div>

                    <div className="flex justify-end gap-3 pt-6">
                        <button
                            type="button"
                            onClick={onClose}
                            className="px-4 py-2 text-white/60 hover:text-white transition"
                        >
                            Batal
                        </button>
                        <button
                            type="button"
                            onClick={handleSave}
                            className="px-5 py-2 bg-white text-black rounded-md font-semibold hover:bg-gray-200 transition"
                        >
                            Simpan
                        </button>
                    </div>
                </form>
            </div>
        </div>
    )
}
