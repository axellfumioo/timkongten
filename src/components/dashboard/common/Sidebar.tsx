import { X, Plus } from 'lucide-react';
import { Navigation } from '@/components/dashboard/common/utils/Navigation';
import { ProfileSection } from '@/components/dashboard/common/utils/ProfileSection';

interface SidebarProps {
    isMobile?: boolean;
    isOpen?: boolean;
    onClose?: () => void;
}

export default function Sidebar({ isMobile, isOpen, onClose }: SidebarProps) {
    const baseClasses = "bg-[#0b0b0b] border-r border-white/10 flex flex-col justify-between";

    const mobileClasses = `
    fixed top-0 left-0 h-full z-40 w-[85%] max-w-[320px]
    transition-transform duration-300 ease-in-out
    ${isOpen ? "translate-x-0" : "-translate-x-full"}
    p-5 sm:p-6
    overflow-y-auto
    shadow-2xl
  `;

    const desktopClasses = "hidden md:flex md:w-72 md:flex-col md:justify-between md:h-screen md:p-6 overflow-y-auto";

    return (
        <aside className={`${baseClasses} ${isMobile ? mobileClasses : desktopClasses}`}>

            <div>
                {isMobile && (
                    <div className="flex items-center justify-between mb-8 pb-4 border-b border-white/10">
                        <h2 className="text-xl font-bold tracking-tight text-white flex items-center gap-2">
                            Tim Konten
                        </h2>
                        <button
                            onClick={onClose}
                            className="p-2 hover:bg-white/10 rounded-lg transition-colors"
                            aria-label="Close menu"
                        >
                            <X size={20} className="text-white/70 hover:text-white" />
                        </button>
                    </div>
                )}

                {!isMobile && (
                    <h2 className="text-2xl font-extrabold tracking-tight text-white mb-10 flex items-center gap-2">
                        Tim Konten
                    </h2>
                )}

                <Navigation />
            </div>

            <ProfileSection />
        </aside>
    );
}