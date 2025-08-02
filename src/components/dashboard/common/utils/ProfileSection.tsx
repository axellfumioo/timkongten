import { motion } from 'framer-motion'

export function ProfileSection() {
    return (
        <div className="border-t border-white/10 pt-6 mt-6">
            <motion.a
                whileHover={{ scale: 1.025 }}
                whileTap={{ scale: 0.97 }}
                className='cursor-pointer'
                href='/app/me'
                >
                <div className="flex items-center gap-3 px-3">

                    <div className="w-10 h-10 rounded-full bg-white/10 flex items-center justify-center text-white text-lg font-bold ring-2 ring-white/20">
                        A
                    </div>

                    <div>
                        <p className="text-white font-medium leading-tight">Axel Ananca</p>
                        <p className="text-white/50 text-sm">axel@studyzone.app</p>
                    </div>
                </div>
            </motion.a>
        </div>
    );
}