import { useState, useEffect, useRef } from "react";
import { Search, Filter, X } from "lucide-react";

const NotesHeader = () => {
    return (
        <div className="relative">
            {/* Simple Search Bar with Filter Button */}
            <div className="mb-6">
                <div className="relative flex items-center bg-[#1a1a1a] rounded-xl border border-white/10 overflow-hidden shadow-lg">
                    <div className="flex-none pl-4 text-white/40">
                        <Search size={18} />
                    </div>
                    <input
                        type="text"
                        placeholder="Cari assets..."
                        className="w-full px-3 py-3 bg-transparent text-white placeholder-white/40 focus:outline-none"
                    />
                </div>

                {/* Simplified Filter Panel with ref for click detection */}
            </div>
        </div>
    );
};

export default NotesHeader;