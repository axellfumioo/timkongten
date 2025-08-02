import {
    LayoutDashboard,
    ChartArea,
    FolderArchive,
    Plus,
    CalendarCheck,
    NotebookPen,
    TimerReset,
    Settings,
    Trophy,
    File,
    FolderArchiveIcon,
} from "lucide-react";

const navigationItems = [
    { label: "Dashboard", href: "/dashboard", icon: LayoutDashboard },
    { type: "divider", label: "Menu" },
    { label: "Calendar Of Content", href: "/coc", icon: CalendarCheck },
    { label: "Journal Recap", href: "/journal", icon: NotebookPen },
    { label: "File Assets", href: "/assets", icon: FolderArchive },
    { type: "divider", label: "AI Helper" },
    { label: "Chat with AI", href: "/journal", icon: NotebookPen },
];

export function Navigation() {
    return (
        <nav className="flex flex-col gap-2">
            <button className="flex items-center justify-center gap-2 bg-white text-[#0a0a0a] px-4 py-2 rounded-md font-semibold hover:bg-gray-200 mb-2 text-sm">
                <Plus size={18} /> Create New Space
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
        </nav>
    );
}
