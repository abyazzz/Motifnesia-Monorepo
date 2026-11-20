# Kebutuhan fungsional TARGET

Transkripsi judul dan deskripsi berasal dari TA §2.5.3. KF-01–KF-09 mencakup proses utama dan KF-10–KF-18 memperluas dukungan. Tautan UC merefleksikan relasi yang tercantum di bagian KF sumber. [Buka dokumen TA](references/Muhammad%20Abyaz%20Zaydan-Tugas%20Akhir_Lengkap_64_Use_Case.docx)

## KF-01 Katalog dan Data Produk

Sistem menyediakan layanan untuk menambahkan, mengelola, dan menampilkan data produk pakaian batik beserta atribut, gambar, harga, dan informasi ketersediaan yang diperlukan.

Keterkaitan sumber. UC-09, UC-11, UC-12, UC-13. Proses: 2.3.1 Pengelolaan Katalog Produk.

## KF-02 Pencarian dan Penyaringan Produk

Sistem menyediakan layanan pencarian dan penyaringan katalog berdasarkan kriteria produk yang tersedia.

Keterkaitan sumber. UC-10. Proses: 2.3.1 Pengelolaan Katalog Produk.

## KF-03 Persediaan dan Pergerakan Stok

Sistem menyediakan layanan untuk mengelola informasi persediaan, melakukan reservasi dan pelepasan reservasi stok, mencatat barang masuk dan barang keluar, melakukan penyesuaian stok, menyimpan riwayat pergerakan persediaan, mendukung stock opname, serta menyediakan laporan persediaan.

Keterkaitan sumber. UC-16, UC-19, UC-24, UC-33, UC-34, UC-35, UC-36, UC-37, UC-38, UC-63. Proses: 2.3.2, 2.3.3, dan 2.3.4.

## KF-04 Keranjang, Pesanan, dan Transaksi

Sistem menyediakan layanan untuk mengelola keranjang belanja, membuat pesanan, menyimpan rincian transaksi, menyediakan riwayat dan detail pesanan, serta mengelola status pesanan sesuai aktivitas transaksi.

Keterkaitan sumber. UC-14, UC-16, UC-17, UC-18, UC-19. Proses: 2.3.3 Pemesanan dan Pengelolaan Transaksi.

## KF-05 Pembayaran melalui Payment Gateway

Sistem menyediakan layanan untuk memulai pembayaran melalui payment gateway, menerima hasil pemrosesan pembayaran, memvalidasi notifikasi pembayaran, serta menyediakan informasi status pembayaran kepada pengguna yang berwenang.

Keterkaitan sumber. UC-20, UC-21, UC-22, UC-23. Proses: 2.3.3 Pemesanan dan Pengelolaan Transaksi.

## KF-06 Pemenuhan dan Informasi Pengiriman

Sistem menyediakan layanan untuk mendukung pencatatan pemenuhan pesanan, informasi jasa pengiriman, nomor resi, serta penyampaian informasi pengiriman kepada Customer.

Keterkaitan sumber. UC-24, UC-25, UC-26, UC-27. Proses: 2.3.3 dan 2.3.4.

## KF-07 Laporan Penjualan dan Refund

Sistem menyediakan layanan untuk menyusun dan menampilkan laporan penjualan berdasarkan transaksi yang berhasil dibayar serta menyajikan informasi nilai refund secara terpisah.

Keterkaitan sumber. UC-62. Proses: 2.3.5 Pengelolaan Informasi Penjualan dan Laporan.

## KF-08 Retur, Penukaran, dan Refund

Sistem menyediakan layanan untuk mencatat pengajuan retur, memeriksa informasi pengajuan, mencatat keputusan penanganan, mengelola proses penukaran, serta mencatat status pengembalian dana.

Keterkaitan sumber. UC-39, UC-40, UC-41, UC-42, UC-43, UC-44, UC-45, UC-46. Proses: 2.3.4 Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual.

## KF-09 Supplier dan Pengadaan

Sistem menyediakan layanan untuk mengelola data supplier, membuat dan mengelola pengadaan produk, menghasilkan dokumen Purchase Order, mencatat konfirmasi supplier, serta menyediakan informasi penerimaan dan laporan pengadaan.

Keterkaitan sumber. UC-28, UC-29, UC-30, UC-31, UC-32, UC-33, UC-64. Proses: 2.3.2 Pengelolaan Pengadaan dan Persediaan Produk.

## KF-10 Autentikasi dan Pemulihan Akun

Sistem menyediakan layanan autentikasi pengguna dan pemulihan akses akun sesuai jenis pengguna serta kebijakan keamanan yang ditetapkan.

Keterkaitan sumber. UC-01, UC-02, UC-03, UC-04. Proses: Lintas proses.

## KF-11 Profil dan Alamat Customer

Sistem menyediakan layanan untuk melihat dan mengelola informasi profil serta alamat pengiriman Customer.

Keterkaitan sumber. UC-05, UC-06, UC-15. Proses: Lintas proses, khususnya 2.3.3 Pemesanan dan Pengelolaan Transaksi.

## KF-12 Pengguna Internal dan Data Pelanggan

Sistem menyediakan layanan pengelolaan akun pengguna internal dan data pelanggan sesuai kewenangan serta batas akses masing-masing peran.

Keterkaitan sumber. UC-07, UC-08. Proses: Lintas proses.

## KF-13 Percakapan Live Chat

Sistem menyediakan layanan komunikasi dua arah antara Customer dan admin berwenang melalui fitur live chat, termasuk penyimpanan pesan dan akses terhadap riwayat percakapan.

Keterkaitan sumber. UC-47. Proses: 2.3.7 Pengelolaan Interaksi dan Preferensi Pelanggan.

## KF-14 Daftar Produk Favorit

Sistem menyediakan layanan untuk menambahkan, menampilkan, dan menghapus produk dari daftar favorit milik Customer.

Keterkaitan sumber. UC-48. Proses: 2.3.7 Pengelolaan Interaksi dan Preferensi Pelanggan.

## KF-15 Ulasan dan Rating Produk

Sistem menyediakan layanan untuk mengirim, memvalidasi, memublikasikan, dan menampilkan ulasan produk. Admin berwenang dapat melihat dan menghapus ulasan sesuai kebijakan, tetapi tidak dapat mengubah isi komentar maupun rating.

Keterkaitan sumber. UC-49, UC-50, UC-51. Proses: 2.3.7 Pengelolaan Interaksi dan Preferensi Pelanggan.

## KF-16 Membership, Poin, dan Voucher

Sistem menyediakan layanan untuk mengelola informasi dan pendaftaran membership, program keanggotaan, poin, reward, penukaran poin, serta pembalikan poin apabila transaksi yang menghasilkan poin dibatalkan atau direfund.

Keterkaitan sumber. UC-19, UC-43, UC-44, UC-45, UC-52, UC-53, UC-54, UC-55, UC-56, UC-57. Proses: 2.3.3, 2.3.4, dan 2.3.6.

## KF-17 Notifikasi Pengguna

Sistem menyediakan layanan untuk menyampaikan dan menampilkan notifikasi kepada Customer dan seluruh peran admin sesuai hak akses masing-masing. Customer dapat mengelola dan menghapus notifikasi miliknya.

Keterkaitan sumber. UC-58, UC-59. Proses: Lintas proses.

## KF-18 Konten dan Broadcast Promosi

Sistem menyediakan layanan untuk mengelola konten promosi dan mengirimkan broadcast promosi melalui email kepada seluruh Customer, serta mencatat status pemrosesan pengiriman.

Keterkaitan sumber. UC-60, UC-61. Proses: 2.3.6 Pengelolaan Membership dan Promosi Pelanggan.
