# MotifNesia documentation baseline · Phase 3

**Versi** Phase 3 · draft terkontrol 1.0  
**Tanggal pencatatan** 2026-11-21 Asia/Jakarta  
**Tanggal finalisasi dan persetujuan baseline** TBD  
**Nomor commit baseline** TBD

Baseline ini adalah acuan kerja dokumentasi dan rancangan. Keputusan yang belum ditetapkan tetap ditandai. Sebelum penerapan perubahan, catat alasan, pemilik, dampak lintas scope dan hasil verifikasi di log terkait.

## Arsitektur

Backend Laravel 12 mengelola API v1, data, transaksi dan otorisasi. Client Web Laravel/Blade dan Client Mobile Flutter menggunakan API Server yang sama. Scope fitur, KF, UC, aktor dan kemampuan per role ditargetkan 1:1, dengan UX sesuai platform. [Arsitektur](00-GLOBAL/architecture/README.md) · [Matriks kesetaraan](PARITAS-WEB-MOBILE.md)

## Proses TO-BE

- 2.3.1 Pengelolaan Katalog Produk
- 2.3.2 Pengelolaan Pengadaan dan Persediaan Produk
- 2.3.3 Pemesanan dan Pengelolaan Transaksi
- 2.3.4 Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual
- 2.3.5 Pengelolaan Informasi Penjualan dan Laporan
- 2.3.6 Pengelolaan Membership dan Promosi Pelanggan
- 2.3.7 Pengelolaan Interaksi dan Preferensi Pelanggan

## Kebutuhan fungsional

Ada 18 KF dari TA §2.5.3. [Detail dan sumber](00-GLOBAL/KEBUTUHAN-FUNGSIONAL.md)

- KF-01 Katalog dan Data Produk
- KF-02 Pencarian dan Penyaringan Produk
- KF-03 Persediaan dan Pergerakan Stok
- KF-04 Keranjang, Pesanan, dan Transaksi
- KF-05 Pembayaran melalui Payment Gateway
- KF-06 Pemenuhan dan Informasi Pengiriman
- KF-07 Laporan Penjualan dan Refund
- KF-08 Retur, Penukaran, dan Refund
- KF-09 Supplier dan Pengadaan
- KF-10 Autentikasi dan Pemulihan Akun
- KF-11 Profil dan Alamat Customer
- KF-12 Pengguna Internal dan Data Pelanggan
- KF-13 Percakapan Live Chat
- KF-14 Daftar Produk Favorit
- KF-15 Ulasan dan Rating Produk
- KF-16 Membership, Poin, dan Voucher
- KF-17 Notifikasi Pengguna
- KF-18 Konten dan Broadcast Promosi

## Use Case dan skenario

Ada 64 UC dari TA §3.2.1–3.2.2. [Skenario](00-GLOBAL/USE-CASE-SCENARIOS.md) · [Traceability](00-GLOBAL/TRACEABILITY-MATRIX.md)

- UC-01 Login
- UC-02 Registrasi Akun
- UC-03 Mengatur Ulang Kata Sandi
- UC-04 Logout
- UC-05 Melihat Profil
- UC-06 Mengelola Profil
- UC-07 Mengelola Pengguna dan Hak Akses
- UC-08 Mengelola Data Pelanggan
- UC-09 Melihat Katalog Produk
- UC-10 Mencari dan Memfilter Produk
- UC-11 Melihat Detail Produk
- UC-12 Menambahkan Produk Baru
- UC-13 Mengelola Data Produk
- UC-14 Mengelola Keranjang Belanja
- UC-15 Mengelola Alamat Pengiriman
- UC-16 Membuat Pesanan / Checkout
- UC-17 Melihat Riwayat Pesanan
- UC-18 Melihat Detail Pesanan
- UC-19 Mengelola Pesanan
- UC-20 Memulai Pembayaran
- UC-21 Memproses Pembayaran
- UC-22 Menerima Notifikasi Pembayaran
- UC-23 Melihat Informasi Pembayaran
- UC-24 Menyiapkan dan Mengemas Pesanan
- UC-25 Mencatat Informasi Pengiriman
- UC-26 Melihat Informasi Pengiriman
- UC-27 Mengonfirmasi Penerimaan Pesanan
- UC-28 Mengelola Data Supplier
- UC-29 Membuat Pengadaan Produk
- UC-30 Menghasilkan dan Mengunduh Dokumen Purchase Order
- UC-31 Mengelola Pengadaan
- UC-32 Mencatat Konfirmasi Supplier
- UC-33 Mencatat Penerimaan Barang
- UC-34 Melihat Persediaan Gudang
- UC-35 Mencatat Barang Masuk dan Barang Keluar
- UC-36 Melakukan Stock Opname
- UC-37 Melakukan Penyesuaian Stok
- UC-38 Melihat Riwayat Pergerakan Stok
- UC-39 Mengajukan Retur Produk
- UC-40 Melihat Status Pengajuan Retur
- UC-41 Meninjau dan Mengelola Pengajuan Retur
- UC-42 Mencatat Penerimaan dan Pemeriksaan Produk Retur
- UC-43 Menentukan Penyelesaian Retur
- UC-44 Memproses Penukaran Produk
- UC-45 Memproses Pengembalian Dana
- UC-46 Melihat Status Pengembalian Dana
- UC-47 Mengelola Percakapan Live Chat
- UC-48 Mengelola Produk Favorit
- UC-49 Mengirim Ulasan Produk
- UC-50 Melihat Ulasan Produk
- UC-51 Manajemen Ulasan Produk
- UC-52 Melihat Informasi Membership
- UC-53 Mendaftar Membership
- UC-54 Menukarkan Poin dengan Reward
- UC-55 Mengelola Program Membership
- UC-56 Mengelola Reward Membership
- UC-57 Mengelola Poin Membership
- UC-58 Melihat Notifikasi
- UC-59 Mengelola Notifikasi
- UC-60 Mengelola Konten Promosi
- UC-61 Mengirim Broadcast Promosi
- UC-62 Mengelola Laporan Penjualan
- UC-63 Melihat Laporan Persediaan
- UC-64 Melihat Laporan Pengadaan

## Status desain dan kesiapan

| Area | Status |
| --- | --- |
| Scope Web dan Mobile | Kesetaraan target 1:1 diputuskan pemilik. Implementasi tiap UC dan role belum dibuktikan setara. Supplier target perlu rekonsiliasi dengan RB-02. |
| ERD CURRENT | Mermaid dan Draw.io dari migration, 42 nama tabel cocok dalam pemeriksaan statis. Skema database fisik, setiap FK dan constraint belum diverifikasi. |
| ERD TARGET | 14 entitas PROPOSED, belum menjadi skema implementasi. Cardinality, unique dan aturan keputusan tertentu TBD. |
| Class CURRENT | 101 class dan 374 nama method/parameter diperiksa terhadap source; return type, trait dan dependency lengkap belum semua diverifikasi. |
| Class TARGET | 18 class PROPOSED dengan kandidat reuse; keputusan class terpisah dan metode final TBD. |
| Wireframe | Pemilik menyatakan visual Phase 2 cukup untuk dokumentasi saat ini. File dipertahankan. Review visual editor Draw.io menyeluruh belum dilakukan. |
| Server | Kebutuhan dan gap siap ditelaah tim. Kontrak gateway, data, transaksi dan migrasi masih membutuhkan keputusan. |
| Client Web dan Mobile | Target 1:1 tersedia untuk perencanaan. Gap aktual, API target, peran dan uji perlu diselesaikan sebelum dinyatakan siap rilis. |

[Baseline teknis Server](01-SERVER/analysis/PHASE-3-TECHNICAL-BASELINE.md) · [Web](02-CLIENT-WEB/SCOPE.md) · [Mobile](03-CLIENT-MOBILE/SCOPE.md)

## Keputusan dan isu

**Disetujui pemilik pada instruksi Phase 3**

- Kesetaraan scope bisnis Web–Mobile 1:1 dengan API bersama.
- Wireframe dan visual Phase 2 cukup untuk dokumentasi saat ini.

**Belum ditetapkan**

- Nama UC-42–44 dalam instruksi terbaru berbeda dari TA sumber.
- Relasi UC-24/KF-03 serta UC-43 dan UC-44/KF-16 membutuhkan konfirmasi.
- Supplier target dan transisi portal bertentangan dengan RB-02 dan membutuhkan konfirmasi; kesetaraan akses yang disetujui berlaku di kedua client.
- Vendor gateway, zona waktu tenggat, retry/callback terlambat, partial shipment/refund, penerimaan berlebih dan kebijakan poin masih TBD.
- Tanggal persetujuan baseline, commit dan pemilik persetujuan formal belum tersedia.

[Rekonsiliasi](00-GLOBAL/UC-KF-RECONCILIATION.md) · [Keputusan](00-GLOBAL/DECISION-LOG.md) · [Gap](00-GLOBAL/GAP-ANALYSIS.md) · [Sumber acuan](00-GLOBAL/SOURCE-OF-TRUTH.md)
