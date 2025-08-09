import { motion } from 'framer-motion'
import { signOut } from 'next-auth/react'
import { useSession } from "next-auth/react";
import ContentModal from '../../layout/contentModal';

export function ProfileSection() {
    const { data: session, status } = useSession();

    if (status === "loading") return <p>Loading session...</p>;

    if (!session || session.user?.allowed === false) {
        return (
            <ContentModal isOpen={true} onClose={() => signOut({ callbackUrl: '/', redirect: true })}>
                <div className="max-w-md">
                    <h1 className="text-2xl font-bold mb-3">❌ Autentikasi Gagal</h1>
                    <p className="text-white/80">
                        Sesi kamu telah berakhir. Silakan login ulang.<br />
                        Jika masalah terus berlanjut, hubungi administrator.
                    </p>
                </div>
            </ContentModal>
        );
    }

    const user = session.user;
    var role = "";
    if (user?.role === "admin") {
        role = "Admin"
    } else if (user?.role === "ba") {
        role = "BA"
    } else if (user?.role === "timkonten") {
        role = "Konten"
    }

    const roleClass = {
        admin: 'bg-red-500/20 text-red-300 border-red-400/20',
        moderator: 'bg-yellow-400/20 text-yellow-300 border-yellow-400/30',
        user: 'bg-blue-500/20 text-blue-300 border-blue-400/20',
    }[role.toLowerCase()] || 'bg-gray-500/20 text-gray-300 border-gray-400/20';
    return (
        <div className="border-t border-white/10 pt-6 mt-6">
            <motion.a
                whileHover={{ scale: 1.025 }}
                whileTap={{ scale: 0.97 }}
                className='cursor-pointer'
                onClick={() => signOut({ callbackUrl: '/', redirect: true })}
            >
                <div className="flex items-center gap-3 px-3">

                    <div className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white text-lg font-bold ring-2 ring-white/20">
                        {session.user?.name?.charAt(0)}
                    </div>

                    <div>
                        <div className='flex justify-between'>
                            <p className="text-white font-medium leading-tight">
                                {session.user?.name?.substring(0, 12)}
                            </p>
                            <span className={`ml-2 text-xs px-2 py-0.5 rounded-full border ${roleClass}`}>
                                {role.charAt(0).toUpperCase() + role.slice(1)}
                            </span>
                        </div>

                        <p className="text-white/50 text-sm">Klik untuk Logout</p>
                    </div>
                </div>
            </motion.a>
        </div>
    );
}