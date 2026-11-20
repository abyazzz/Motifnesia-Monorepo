# Validasi audit dan rancangan

| Pemeriksaan | Hasil |
| --- | --- |
| Struktur dan tautan | Empat scope dokumentasi, berkas instruksi, tautan internal dan anchor diperiksa. Indeks menautkan desain setiap aplikasi dan bukti pada source. |
| Referensi | Sebelas salinan sama byte demi byte dengan sumber. Hash setiap sumber diperiksa ulang. Metadata lock editor diaudit sebagai artefak sementara. |
| Cakupan kebutuhan | 7 proses, 19 alur, 18 KF, 64 UC dan 64 skenario. Delapan relasi UC/KF berbeda arah dan tercatat di matriks. |
| Registrasi route | Laravel `route:list --json` berhasil untuk Server dan Web. Audit juga memeriksa 43 route Flutter dan padanan 43 route layar Web. |
| ERD | 42 tabel aktual dan 53 FK fisik disusun dari migration serta dibedakan dari 14 entitas usulan. Relasi Eloquent dicatat terpisah dalam kamus data. |
| Class | 101 class aktual dan 374 metode yang dideklarasikan di `app/`, termasuk seluruh 41 controller. Ada 18 class usulan. |
| Mermaid | 79 file berhasil diparsing dan menghasilkan SVG dengan Mermaid lokal. Pengukuran teks menggunakan DOM simulasi, sehingga tampilan akhir tiap diagram perlu tinjauan visual. |
| Draw.io | Empat file `mxfile` dengan 32 tab lulus parsing XML dan pemeriksaan struktur `mxGraphModel`, ID, geometry dan hubungan edge. Tinjauan visual di editor Draw.io masih terbuka. |
| Integritas aplikasi | Hash file aplikasi dan tes yang dilacak Git sama dengan snapshot sebelum penulisan dokumentasi. |

Audit endpoint, tipe data, constraints, relasi model, validasi dan kontrak berdasarkan route terdaftar dan pembacaan statis. Skema fisik database, data historis, hasil migrasi, dan pengujian aplikasi merupakan verifikasi terpisah. Pengujian fitur yang tercantum di matriks adalah cakupan dari source tes yang tersedia. Pekerjaan ini berfokus pada dokumentasi dan tidak menjalankan migration, seeder, atau tes yang mengubah database.

Dokumen Word dan PDF diperiksa melalui lapisan teks dan tabel. Ilustrasi tertanam tersedia pada salinan asli untuk tinjauan visual lanjutan. Workbook sumber survei yang disebut Bank Informasi 2.0 belum ditemukan dalam folder referensi.

[Indeks dokumentasi](../README.md) · [Integritas referensi](../SHA256SUMS) · [Gap](GAP-ANALYSIS.md)
