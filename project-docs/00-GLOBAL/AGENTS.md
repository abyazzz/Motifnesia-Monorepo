# Instruksi global untuk AI Agent

MotifNesia adalah platform penjualan pakaian batik untuk Toko Viera. Monorepo ini berisi backend Laravel 12, client Web Laravel 12 dengan Blade/Vite, dan client Mobile Flutter/Dart. Kedua client memakai kontrak Server `/api/v1`. Server memegang keputusan autentikasi, izin, validasi, transaksi, inventaris, dan data. Client memegang presentasi, navigasi, input, dan umpan balik.

## Urutan kerja

1. Baca instruksi pemilik proyek yang terbaru, file ini, serta `AGENTS.md`, `SCOPE.md`, `RULES.md`, dan `REFERENCES-INDEX.md` dari scope yang terlibat.
2. Baca [matriks sumber](SOURCE-OF-TRUTH.md), [keterlacakan](TRACEABILITY-MATRIX.md), dan [gap](GAP-ANALYSIS.md) untuk UC yang dikerjakan. Periksa skenario normal dan alternatif dalam sumber sebelum menetapkan hasil.
3. Periksa Git status, route, guard, kontrak, serta source dan tes yang terkait. Lindungi perubahan lokal dan gunakan dokumen aktual sebagai panduan pencarian bukti.
4. Gunakan hierarki instruksi berikut. Pemilik proyek, AGENTS global, AGENTS scope, rules scope, lalu dokumen teknis dan referensi. Gunakan kode sebagai bukti AS-IMPLEMENTED. Catat konflik per domain dalam [log keputusan](DECISION-LOG.md).
5. Tandai informasi sebagai `AS-IMPLEMENTED`, `TARGET`, `PROPOSED`, atau `TBD`. Ambil ID dan isi kebutuhan dari sumber. Pertahankan kebutuhan yang belum diimplementasikan.

## Batas teknis dan koordinasi

- Pertahankan satu API bersama. Cocokkan bentuk input, respons, izin, error, pagination, dan dependensi kedua client sebelum mengubah kontrak.
- Terapkan Sanctum, Gate dan pemeriksaan kepemilikan di server. Client memakai akses untuk navigasi dan memberi umpan balik saat server menolak. Tangani token kedaluwarsa, invalidasi, dan kebijakan unggah sesuai kontrak.
- Gunakan transaksi untuk operasi atomik dan penanganan retry yang konsisten. Catat mutasi stok, status penting, perubahan poin serta bukti refund sesuai kebutuhan terverifikasi.
- Lindungi secret, token, konfigurasi lokal, dump, data pribadi, dan bukti transaksi. Gunakan data uji yang terisolasi dan hasil yang telah disanitasi.
- Koordinasikan perubahan lintas scope dengan anggota terkait. Dokumentasikan apa yang berubah, kaitan UC/KF, implikasi versi, dan pengujian untuk kedua client.
- Jalankan pengujian relevan untuk perubahan implementasi dan catat batas verifikasi. Pembaruan TO-BE, KF, UC atau API perlu diikuti pembaruan traceability dan gap.
- Dokumentasi menyediakan acuan kerja. Perubahan aplikasi, database, commit, dan push mengikuti wewenang tugas yang diberikan.

Panduan teknis ada di [GLOBAL-RULES](GLOBAL-RULES.md). Peta aplikasi dan acuan scope ada di [PROJECT-OVERVIEW](PROJECT-OVERVIEW.md).
