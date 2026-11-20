# Konteks migrasi Motifnesia: server dan client web

Dokumen ini merangkum keputusan pemilik proyek untuk sesi Codex berikutnya. Pemilik ingin sesi baru langsung melaksanakan migrasi, setelah memastikan akses dan kondisi lingkungan memungkinkan.

## Tujuan dan lokasi

Gunakan proyek berikut sebagai referensi utama perilaku dan fitur:

`/mnt/Projects/Laravel/Motifnesia-fullstak`

Proyek referensi **tidak boleh diubah**. Dokumen ini ditambahkan atas permintaan pemilik; jangan mengubah atau menghapusnya sebagai bagian migrasi. Jangan menjalankan perintah di referensi yang membuat atau mengubah file, cache, dependency, konfigurasi, database, atau asetnya.

Hasil yang diinginkan:

```text
/mnt/Projects/Laravel/
├── Motifnesia-fullstak/              # Referensi; tetap utuh
└── Motifnesia/
    ├── Motifnesia-Server/           # Salinan fullstack yang dikembangkan menjadi server
    └── Motifnesia-Client-Web/       # Proyek Laravel baru untuk client web
```

Perhatikan kapitalisasi nama folder. Buat `Motifnesia-Server` dari salinan proyek referensi, bukan dengan memindahkan atau mengganti nama proyek asli. Buat `Motifnesia-Client-Web` sebagai proyek Laravel baru. Jangan menganggap server sudah lengkap hanya karena salinannya berhasil dibuat.

## Target 1:1

Client web baru harus mencapai kesetaraan dengan fullstack referensi untuk **customer, seluruh peran admin, dan supplier**. Inventarisasi fitur dan alur berdasarkan implementasi aktual, lalu cocokkan tampilan, navigasi, validasi, hak akses, hasil proses bisnis, dan efek terhadap data. Gunakan alur aplikasi referensi sebagai acuan; catat perbedaan atau keterbatasan yang ditemukan.

Pemindahan bukan sekadar menyalin Blade. Pindahkan dan sesuaikan view, layout, komponen, CSS/JS, aset, route, controller web, form, data yang dikirim ke view, dan navigasi; sesuaikan integrasinya agar client berkomunikasi dengan server melalui REST API. Pindahkan per alur utuh dan validasi secara bertahap, sambil mempertahankan referensi sebagai pembanding.

`Motifnesia-Server` menangani data dan aturan bisnis, autentikasi, otorisasi, validasi, dan operasi penting seperti checkout, stok dan pembayaran. Hindari menggandakan aturan bisnis yang kemudian menyimpang antara API dan alur web lama. Client web tidak langsung mengakses database bisnis. Pertahankan fitur web lama di salinan server selama diperlukan untuk migrasi, lalu bersihkan secara hati-hati setelah kesetaraan terbukti.

## Database aktif dan pengujian

Database yang sekarang dipakai fullstack **aktif digunakan**. Pemilik meminta server nantinya menggunakan database yang sama, bukan database bisnis baru sebagai pengganti. Pastikan konfigurasi server sesuai tanpa mencetak atau membagikan rahasia `.env`.

Untuk pengujian yang mengubah data, gunakan database uji terisolasi atau salinan yang sesuai; jangan membuat pesanan, mengubah stok, memodifikasi akun, atau menjalankan tes yang merusak data di database aktif. Periksa target database setiap kali menjalankan migrasi, seeder, dan tes. Sebelum perubahan skema database aktif, siapkan backup dan rencana penerapan; jangan menjalankan perubahan skema pada database aktif begitu saja. Penerapan, cutover atau perubahan pada layanan aktif memerlukan keputusan yang jelas dan review hasilnya.

Perhatikan bahwa aplikasi referensi dapat terus dikembangkan. Catat baseline yang dibandingkan dan masukkan perubahan referensi yang terjadi selama migrasi ke daftar validasi agar hasil akhir tetap setara. Hindari kebingungan dari aplikasi referensi dan server yang menulis bersamaan ke database aktif.

## API dan Flutter

Fokus proyek saat ini hanya **server dan client web** sampai 1:1. Jangan mengerjakan atau mengonfigurasi proyek Flutter dalam fase ini. Flutter yang sempat dilihat pada percakapan ternyata bukan aplikasi mobile yang dimaksud pemilik dan tidak boleh dijadikan acuan.

Rancang API agar pada masa depan bisa dipakai baik oleh client web maupun Flutter untuk proses bisnis yang sama. Periksa API yang sudah ada, pertahankan kompatibilitasnya sebisa mungkin dan dokumentasikan perubahan kontrak yang diperlukan. Keberadaan endpoint tidak berarti fiturnya sudah setara dengan web.

## Temuan awal dari pemeriksaan statis

- Fullstack memakai Laravel 12, PHP `^8.2`, dan Laravel Sanctum; lihat `composer.json` di referensi.
- `routes/api.php` sudah menyediakan sebagian API, termasuk autentikasi, produk, keranjang, favorit, alamat, serta beberapa operasi admin. Cakupannya belum sama dengan seluruh route web.
- `routes/web.php` mencakup alur customer, admin dan supplier, termasuk checkout, pembayaran, membership, retur, chat, pengadaan, gudang dan stok. Inventarisasi yang lebih lengkap tetap diperlukan.
- Ada model, migration, observer, service dan view yang bisa digunakan sebagai dasar; sebagian service dan view masih terikat ke autentikasi, route atau konteks web Laravel yang sama. Audit dependensi sebelum memisahkan.
- Temuan tersebut berasal dari pembacaan kode, bukan validasi menyeluruh saat aplikasi berjalan. Jangan menganggap daftar di atas sebagai inventaris lengkap.

## Cara kerja yang diharapkan

1. Periksa izin tulis untuk folder tujuan, instruksi proyek dan kondisi lingkungan. Baca referensi tanpa mengubahnya; buat baseline dan inventaris fitur serta kontrak API.
2. Buat salinan server dan proyek client web di lokasi yang diminta. Pastikan file dan konfigurasi penting, termasuk aset yang digunakan aplikasi, ditangani dengan benar dan tanpa membocorkan rahasia.
3. Rancang integrasi dan jalankan migrasi per alur end-to-end: API server, client web, lalu validasi terhadap referensi. Pastikan kontrol akses diterapkan di server.
4. Verifikasi alur dan efek data dengan pengujian yang sesuai menggunakan data uji terisolasi, lalu lengkapi seluruh fitur customer, admin dan supplier. Catat setiap perbedaan yang belum selesai.
5. Bersihkan bagian yang tak lagi diperlukan hanya saat aman, dan laporkan hasil, pengujian, serta pekerjaan atau hambatan yang benar-benar tersisa. Jangan menyatakan 1:1 selesai tanpa bukti yang memadai.

Pemilik sudah menginstruksikan sesi baru untuk **langsung mengeksekusi migrasi ini**. Lanjutkan secara mandiri sesuai batasan di atas. Jika izin sistem, akses dependency, database uji, atau informasi penting benar-benar menghalangi, jelaskan hambatannya secara spesifik dan selesaikan pekerjaan independen yang masih bisa dilakukan.

## Prompt untuk sesi baru

> Bro, baca `/mnt/Projects/Laravel/Motifnesia-fullstak/KONTEKS-MIGRASI-MOTIFNESIA.md` sebagai konteks dan instruksi proyek ini, lalu langsung eksekusi migrasinya sampai selesai sesuai dokumen. Proyek `/mnt/Projects/Laravel/Motifnesia-fullstak` hanya referensi dan tidak boleh diubah. Buat `/mnt/Projects/Laravel/Motifnesia/Motifnesia-Server` dari salinannya dan proyek Laravel baru `/mnt/Projects/Laravel/Motifnesia/Motifnesia-Client-Web`. Pindahkan dan sesuaikan seluruh fitur customer, admin, dan supplier secara bertahap, termasuk API, view, navigasi, otorisasi, dan validasi 1:1 terhadap referensi. Database sekarang aktif dan tetap menjadi database server; lakukan pengujian yang mengubah data pada database uji terisolasi. Flutter belum dikerjakan. Lanjutkan mandiri dan jelaskan bila ada hambatan yang benar-benar membutuhkan bantuan gue.
