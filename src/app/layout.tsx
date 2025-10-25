"use client"

import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { SessionProvider } from "next-auth/react";
import { useState } from "react";
import Toast from "typescript-toastify";
import { useGlobalStore } from "./lib/global-store";
import ContentModal from "@/components/dashboard/layout/contentModal";
import { Save, Loader2 } from "lucide-react";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {

  const [formData, setFormData] = useState({
    content_category: "",
    content_type: "",
    content_title: "",
    content_caption: "",
    content_feedback: "",
    content_date: "",
  });

  const [loading, setLoading] = useState(false);

  function handleChange(e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  }

  const setUpdated = useGlobalStore((state) => state.setUpdated);
  const isCocOpen = useGlobalStore((state) => state.cocOpen);
  const setCocOpen = useGlobalStore((state) => state.setCocOpen);
  const [modalOpen, setModalOpen] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setLoading(true);

    const isEmpty = Object.values(formData).some((val) => val.trim() === "");

    if (isEmpty) {
      setCocOpen(false);
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
      setLoading(false);
      return;
    }

    const response = await fetch("/api/content", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        ...formData,
        created_at: new Date().toISOString(),
      }),
    });

    if (response.ok) {
      setFormData({
        content_category: "",
        content_type: "",
        content_title: "",
        content_caption: "",
        content_feedback: "",
        content_date: "",
      });
      new Toast({
        position: "top-right",
        toastMsg: "Berhasil menyimpan!",
        autoCloseTime: 3000,
        showProgress: true,
        pauseOnHover: true,
        pauseOnFocusLoss: true,
        type: "success",
        theme: "dark"
      });
      setUpdated(true);
      setCocOpen(false);
    } else {
      setCocOpen(false);
      new Toast({
        position: "top-right",
        toastMsg: "Gagal menyimpan!",
        autoCloseTime: 3000,
        showProgress: true,
        pauseOnHover: true,
        pauseOnFocusLoss: true,
        type: "error",
        theme: "dark"
      });
    }

    setLoading(false);
  }

  return (
    <html lang="en" >
      <head>
        <title>Tim Konten Dashboard</title>
        <meta name="color-scheme" content="dark"></meta>
        <link rel="icon" href="/faviconlogo.ico" sizes="any" />
        <meta name="description" content="Dashboard untuk tim konten SMK Telkom Purwokerto" />
      </head>
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >

        <ContentModal isOpen={isCocOpen} onClose={() => setCocOpen(false)}>
          <h2 className="text-2xl font-semibold mb-6">Tambah Konten Baru</h2>

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
                className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20 transition"
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
                className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20 transition"
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
                placeholder="Masukkan judul konten"
                className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-white/20 transition"
              />
            </div>

            {/* Caption */}
            <div className="md:col-span-2">
              <label className="block text-white font-medium mb-1">Caption</label>
              <textarea
                name="content_caption"
                value={formData.content_caption}
                onChange={handleChange}
                placeholder="Masukkan caption konten..."
                className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 h-28 
                   placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-white/20 transition resize-none"
              />
            </div>

            {/* Feedback */}
            <div>
              <label className="block text-white font-medium mb-1">Feedback</label>
              <select
                name="content_feedback"
                value={formData.content_feedback}
                onChange={handleChange}
                className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20 transition"
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
                className="w-full rounded-lg border border-white/10 bg-white/5 text-white px-4 py-3 
                   focus:outline-none focus:ring-2 focus:ring-white/20 transition"
              />
            </div>

            {/* Tombol Aksi */}
            <div className="md:col-span-2 flex items-center justify-between gap-4 pt-2">
              <span className="text-sm text-white/80">
                *Point evidence akan otomatis terbuat
              </span>
              <div className="flex gap-3">
                <button
                  type="button"
                  onClick={() => setModalOpen(false)}
                  className="px-5 py-2.5 rounded-lg text-sm font-medium bg-white/10 text-white hover:bg-white/20 transition"
                  disabled={loading}
                >
                  Batal
                </button>
                <button
                  type="submit"
                  disabled={loading}
                  className={`flex gap-2 items-center px-5 py-2.5 rounded-lg text-sm font-medium text-white transition ${
                    loading
                      ? "bg-white/10 cursor-not-allowed"
                      : "bg-white/20 hover:bg-white/30"
                  }`}
                >
                  {loading ? (
                    <>
                      <Loader2 size={16} className="animate-spin" /> Menyimpan...
                    </>
                  ) : (
                    <>
                      <Save size={16} /> Simpan
                    </>
                  )}
                </button>
              </div>
            </div>
          </form>
        </ContentModal>

        <SessionProvider>
          {children}
        </SessionProvider>
      </body>
    </html>
  );
}
