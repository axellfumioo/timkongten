'use client';

import { useEffect, useState } from 'react';
import { UserIcon, Loader2, Search, ChevronLeft, ChevronRight } from 'lucide-react';

type ActivityLog = {
  id: string;
  user_email: string | null;
  user_name: string | null;
  activity_type: string | null;
  activity_name: string | null;
  activity_message: string | null;
  activity_url: string | null;
  activity_agent: string | null;
  activity_date: string | null;
};

export default function ActivityLogList() {
  const [logs, setLogs] = useState<ActivityLog[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [search, setSearch] = useState('');
  const [filterType, setFilterType] = useState('');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  const fetchLogs = async () => {
    setIsLoading(true);
    try {
      const res = await fetch(
        `/api/activity-log?search=${encodeURIComponent(search)}&type=${encodeURIComponent(filterType)}&page=${page}&pageSize=5`
      );

      if (!res.ok) {
        throw new Error(`HTTP error! Status: ${res.status}`);
      }

      const data = await res.json();
      const logsData = Array.isArray(data.data) ? data.data : [];

      setLogs(logsData);
      setTotalPages(Number(data.pagination?.totalPages) || 1);
    } catch (error) {
      console.error('Gagal fetch logs:', error);
      setLogs([]);
      setTotalPages(1);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchLogs();
  }, [search, filterType, page]);

  return (
    <div className="bg-white/3 rounded-2xl border border-white/10 shadow-xl p-6 w-full text-white">
      {/* Filter & Search */}
      <div className="flex flex-col md:flex-row items-stretch md:items-center justify-between gap-3 mb-6">
        <div className="flex items-center w-full md:w-auto bg-[#1a1a1a] border border-white/10 rounded-lg overflow-hidden">
          <div className="p-2 pl-3">
            <Search size={16} className="text-white/40" />
          </div>
          <input
            type="text"
            placeholder="Cari pesan aktivitas..."
            className="bg-transparent w-full py-2 pr-3 text-sm text-white placeholder-white/30 outline-none"
            value={search}
            onChange={(e) => {
              setSearch(e.target.value);
              setPage(1);
            }}
          />
        </div>

        <select
          className="bg-[#1a1a1a] border border-white/10 text-sm text-white px-4 py-2 rounded-lg"
          value={filterType}
          onChange={(e) => {
            setFilterType(e.target.value);
            setPage(1);
          }}
        >
          <option value="">Semua Tipe</option>
          <option value="auth">Auth</option>
          <option value="content">Content</option>
          <option value="evidence">Point Evidence</option>
        </select>
      </div>

      {/* Loading */}
      {isLoading ? (
        <div className="flex justify-center py-10">
          <Loader2 className="animate-spin text-white/50 w-6 h-6" />
        </div>
      ) : !Array.isArray(logs) || logs.length === 0 ? (
        <p className="text-white/40 text-center italic py-10">Tidak ada log ditemukan.</p>
      ) : (
        <ul className="space-y-4 text-sm">
          {logs.map((log) => (
            <li
              key={log.id}
              className="bg-gradient-to-b from-white/5 to-white/0 rounded-2xl border border-white/10 shadow-xl py-4 px-4 transition-all duration-200 group"
            >
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <p className="text-white font-semibold mb-1">
                    {log.activity_name || 'Aktivitas Tidak Dikenal'}
                  </p>
                  <p className="text-white/50 mb-2 text-sm">{log.activity_message || '-'}</p>
                  <div className="flex flex-col sm:flex-row sm:items-center gap-2 text-xs text-white/40">
                    <div className="flex items-center gap-1">
                      <UserIcon size={14} />
                      <span>{log.user_name || 'Anonim'}</span>
                    </div>
                    <span>• {log.activity_type}</span>
                    <span>• {new Date(log.activity_date || '').toLocaleString('id-ID')}</span>
                  </div>
                </div>
              </div>
            </li>
          ))}
        </ul>
      )}

      {/* Pagination */}
      {!isLoading && totalPages > 1 && (
        <div className="flex justify-center items-center gap-3 mt-6">
          <button
            className="px-3 py-2 border border-white text-white rounded-md disabled:opacity-40"
            onClick={() => setPage((p) => p - 1)}
            disabled={page === 1}
          >
            <ChevronLeft size={16} />
          </button>
          <span className="text-sm text-white/60">
            Halaman {page} dari {totalPages}
          </span>
          <button
            className="px-3 py-2 border border-white text-white rounded-md disabled:opacity-40"
            onClick={() => setPage((p) => p + 1)}
            disabled={page === totalPages}
          >
            <ChevronRight size={16} />
          </button>
        </div>
      )}
    </div>
  );
}
