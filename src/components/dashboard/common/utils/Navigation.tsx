'use client'
import {
    LayoutDashboard,
    Icon,
    FolderArchive,
    Plus,
    CalendarCheck,
    NotebookPen,
    User2,
    CheckCircle2,
    ScrollText,
    FolderCheckIcon,
} from "lucide-react";
import { useSession } from 'next-auth/react'
import { useGlobalStore } from '@/app/lib/global-store';

const navigationItems = [
    { label: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
    { type: "divider", label: "Menu" },
    { label: "Calendar Of Content", href: "/dashboard/coc", icon: CalendarCheck },
    { label: "Point Evidence", href: "/dashboard/evidence", icon: NotebookPen },
    { type: "divider", label: "Utilitas" },
    { label: "Drive Sort", href: "/dashboard/drivesort", icon: FolderCheckIcon },
    { label: "File Assets", href: "/dashboard/assets", icon: FolderArchive },
];

export function Navigation() {
    const { data: session } = useSession()
    const setCocOpen = useGlobalStore((state) => state.setCocOpen);
    return (
        <>
            <nav className="flex flex-col gap-2">
                <button onClick={() => setCocOpen(true)} className="flex items-center justify-center gap-2 bg-white text-[#0a0a0a] px-4 py-2 rounded-md font-semibold hover:bg-gray-200 mb-2 text-sm">
                    <Plus size={18} /> Buat Calendar Of Content
                </button>
                    {navigationItems.map((item, index) => {
                        if (item.type === "divider") {
                            return (
                                <div
                                    key={`divider-${index}`}
                                    className="text-xs uppercase tracking-wide text-white/40 px-3 pt-4 pb-1"
                                >
                                    {item.label}
                                </div>
                            );
                        }
                const Icon = item.icon;
                return (
                <a
                    href={item.href}
                    key={item.label}
                    className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-white/80 hover:text-white hover:bg-white/10 transition-colors duration-200 text-sm"
                >
                    <Icon size={20} className="flex-shrink-0" />
                    <span className="font-medium">{item.label}</span>
                </a>
                );
                })}
                {session?.user.role === 'admin' && (
                    <>
                        <div
                            key={`divider-admin`}
                            className="text-xs uppercase tracking-wide text-white/40 px-3 pt-4 pb-1"
                        >
                            Admin
                        </div>

                        <a
                            href="/dashboard/admin"
                            key="User Management"
                            className="flex items-center gap-3 px-3 py-2.5 rounded-lg text-white/80 hover:text-white hover:bg-white/10 transition-colors duration-200 text-sm"
                        >
                            <User2 size={20} className="flex-shrink-0" />
                            <span className="font-medium">Settings</span>
                        </a>
                    </>
                )}
            </nav>
        </>
    );
}
