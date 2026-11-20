# Motifnesia Server

Backend Laravel untuk Motifnesia. Server menjalankan API, autentikasi, aturan bisnis, database, serta penyimpanan media dan bukti transaksi. Halaman customer, admin, dan supplier dirender oleh [Motifnesia Client Web](../Motifnesia-Client-Web). Lihat [kontrak API v1](API-V1.md) untuk daftar endpoint dan konfigurasi integrasi.

---

## Menjalankan proyek di Linux

1. Salin `.env.example` menjadi `.env` jika belum ada, lalu isi `DB_DATABASE`, `DB_USERNAME`, dan `DB_PASSWORD` sesuai akun MySQL/MariaDB lokal. Jalankan `composer install` dan `php artisan key:generate` hanya jika `APP_KEY` belum ada.
2. Pastikan server database berjalan dan akun yang dikonfigurasi dapat masuk melalui TCP: `mysql -h 127.0.0.1 -u motifnesia -p motifnesia_laravel`. Masukkan password dari `.env` saat diminta.
3. Jalankan `php artisan migrate` setelah memastikan database yang dipilih sudah benar dan data penting sudah dicadangkan.
4. Jalankan `php artisan serve --host=127.0.0.1 --port=8000`. Gunakan `php artisan test` untuk menjalankan pengujian dengan SQLite sementara.
5. Atur `MOTIFNESIA_CLIENT_URL` jika alamat client berbeda dari `http://127.0.0.1:8001`. Server memakai alamat ini untuk tautan notifikasi dan email.

### MySQL: `Access denied` untuk `motifnesia@localhost`

Kode 1698 menunjukkan server menolak autentikasi. Memperbarui cache Laravel saja tidak akan memperbaiki akun MySQL yang memakai metode autentikasi atau password yang salah. Administrator database dapat memeriksa akun dengan `sudo mysql`, lalu `SHOW CREATE USER 'motifnesia'@'localhost';`. Untuk membuat atau mengatur akun khusus proyek dengan password, jalankan perintah berikut di konsol MySQL/MariaDB, dengan mengganti placeholder password menggunakan nilai yang sama seperti `DB_PASSWORD` di `.env`:

```sql
CREATE DATABASE IF NOT EXISTS motifnesia_laravel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'motifnesia'@'localhost' IDENTIFIED BY 'PASSWORD_DARI_ENV';
ALTER USER 'motifnesia'@'localhost' IDENTIFIED BY 'PASSWORD_DARI_ENV';
GRANT ALL PRIVILEGES ON motifnesia_laravel.* TO 'motifnesia'@'localhost';
```

`ALTER USER` mengubah metode autentikasi dan password akun yang sudah ada; pastikan akun itu tidak dipakai aplikasi lain. Setelah keluar dari konsol database, uji kembali koneksi TCP di atas, lalu jalankan `php artisan config:clear` dan `php artisan migrate:status`. Jangan bagikan password atau berkas `.env`.

---

## 🛠️ Stack Teknologi & Spesifikasi
* **Framework Backend:** Laravel 12
* **Bahasa Pemrograman:** PHP 8.2 atau lebih baru
* **Database:** MySQL (via Eloquent ORM)
* **Antarmuka:** REST API dengan autentikasi Laravel Sanctum

---

## Autentikasi dan otorisasi

Client memakai bearer token Laravel Sanctum. Middleware memeriksa akun dan peran pada setiap request, lalu Gate di controller memeriksa kemampuan yang diperlukan untuk menjalankan tindakan bisnis.

---

## 👥 Pembagian Role Admin (RBAC)
Untuk efisiensi operasional, hak akses admin dibagi menjadi 3 sub-role melalui database (`admin_role`):
1. **Owner (`owner`)** — *Akses 100% Fitur*
   - Mengelola produk (CRUD penuh), merilis promosi, menyiarkan broadcast.
   - Mengelola data customer, ulasan, notifikasi, dan konten statis (slideshow, about us).
   - Melihat laporan penjualan dan mengakses seluruh menu tanpa batas.
2. **Finance (`finance`)** — *Fokus Transaksi & Keuangan*
   - Hanya memiliki akses ke menu **Status Pengiriman**, **Laporan Penjualan**, dan **Notifikasi Sistem**.
   - Dapat memverifikasi atau menolak bukti transfer pembayaran yang diunggah customer.
   - **Dilarang** melakukan update status ekspedisi pengiriman fisik barang atau CRUD produk.
3. **Kasir / CS (`kasir`)** — *Fokus Operasional Harian*
   - Mengakses menu **Manajemen Produk** dalam mode **Read-Only** (hanya melihat stok & detail produk).
   - Mengakses menu **Status Pengiriman** (hanya bisa meng-update status ekspedisi seperti dikemas/dikirim, tidak bisa melihat bukti transfer atau mengubah status pembayaran).
   - Mengelola retur produk, ulasan produk, dan melayani pelanggan lewat **Live Chat**.

---

## 👤 Fitur & Halaman Customer & Guest (Front-End)

### A. Guest (Pengunjung Publik / Tanpa Login)
Pengunjung yang belum terdaftar atau belum masuk ke akun dapat mengakses fitur-fitur publik berikut:
1. **Homepage**: Menjelajahi banner promo, kategori produk batik, melakukan pencarian cepat (live search), dan melihat daftar produk unggulan.
2. **Product Detail**: Melihat deskripsi produk, harga diskon, info stok ukuran, zoom gambar produk, dan membaca ulasan/rating produk.
3. **Batik Storytelling Tab**: Membaca filosofi, kisah budaya, dan asal-usul di balik motif batik yang sedang dilihat.
4. **Smart Size Guide (Kalkulator Ukuran)**: Membuka modal kalkulator ukuran, menginput tinggi & berat badan, mendapatkan rekomendasi ukuran terbaik secara instan menggunakan BMI, serta melihat tabel dimensi ukuran produk.
5. **Quick Buy via WhatsApp**: Menghubungi admin langsung melalui WhatsApp dengan pesan otomatis terformat yang memuat nama produk, ukuran terpilih, harga, dan link produk.
6. **Registrasi & Login**: Membuat akun baru dengan menyertakan pertanyaan keamanan rahasia atau masuk ke sistem sebagai customer terdaftar.

### B. Customer (Pelanggan Terdaftar / Setelah Login)
Setelah berhasil login, customer mendapatkan akses penuh ke seluruh fitur belanja dan manajemen akun berikut:
1. **Manajemen Keranjang Belanja**: Menambahkan produk ke keranjang, mengubah kuantitas barang, menghapus item, dan melihat total harga real-time.
2. **Favorites / Wishlist**: Menyimpan produk incaran agar mudah ditemukan kembali di kemudian hari.
3. **Checkout Transaksi**: Memilih alamat pengiriman utama, menghitung ongkos kirim secara dinamis, mengklaim voucher membership, serta otomatis mendapatkan diskon berdasarkan tingkat tier keanggotaan.
4. **Konfirmasi & Upload Bukti Pembayaran**: Melihat countdown timer batas waktu transfer (24 jam) dan mengunggah gambar bukti transfer pembayaran.
5. **Invoice & Tracking Pengiriman**: Memantau status pengerjaan pesanan secara real-time (Dikemas, Dikirim, Diterima) dan melihat riwayat transaksi sukses.
6. **Sistem Pengembalian Barang (Return & Refund)**: Mengajukan retur produk rusak, mengunggah foto penyerahan barang ke kurir, serta memantau status persetujuan pengembalian dana dari admin.
7. **Live Chat Support**: Melakukan percakapan langsung (real-time chat) dengan CS admin langsung dari halaman website.
8. **Dashboard Membership**: Mengakses info tier keanggotaan, melacak progress belanja ke tier berikutnya via progress bar, serta menukarkan koin reward yang terkumpul menjadi voucher potongan harga.

---

## 👨‍💼 Fitur & Halaman Admin (Back-End)

1. **Dashboard & Sales Analytics**: Visualisasi grafik total penjualan harian/bulanan, jumlah order masuk, statistik produk terlaris, dan export laporan ke Excel/PDF.
2. **Manajemen Produk**: CRUD produk lengkap dengan manajemen stok varian per ukuran (S, M, L, XL), unggah foto, dan pengaturan diskon coret.
3. **Status Pengiriman (Order Manager)**: Manajemen status pembayaran (waiting, verified, rejected) dan status kurir (pending, dikemas, dikirim, selesai).
4. **Kelola Retur**: Pemeriksaan berkas komplain retur, persetujuan/penolakan retur, dan integrasi pengembalian dana (refund).
5. **Live Chat Support**: Pusat obrolan admin untuk menjawab pertanyaan pelanggan secara real-time.
6. **Kelola Konten Statis**: Mengubah slide banner promosi, data deskripsi About Us, visi misi, serta icon keunggulan di homepage tanpa menyentuh kode program.
7. **Broadcast & Reward Membership**: Membuat reward voucher berbasis poin dan mengirimkan pesan broadcast massal ke semua member terdaftar.

---

## 🥇 Fitur Premium: Tiered Membership
Sistem keanggotaan berjenjang yang memproses loyalitas pelanggan berdasarkan akumulasi transaksi sukses (`total_spending`):

| Tingkatan Tier | Batas Belanja | Diskon Belanja | Multiplier Poin | Warna Badge |
| :--- | :--- | :--- | :--- | :--- |
| 🥉 **Bronze** | Rp 0 - Rp 499.999 | 0% | 1.0x | `#cd7f32` (Bronze) |
| 🥈 **Silver** | Rp 500.000 - Rp 1.999.999 | 3% | 1.5x | `#c0c0c0` (Silver) |
| 🥇 **Gold** | Rp 2.000.000+ | 5% | 2.0x | `#ffd700` (Gold) |

* **Harga Khusus Member**: Pelanggan dengan tier Silver/Gold otomatis melihat harga terpotong diskon di halaman detail produk.
* **Rincian Diskon Checkout**: Diskon tier ditampilkan secara transparan sebagai baris pengurangan harga terpisah di keranjang checkout dan dihitung secara akurat lewat JavaScript sebelum pembayaran dilakukan.
* **Sistem Poin Berlipat**: Poin transaksi dikalikan dengan multiplier tier pengguna (contoh: Member Gold menerima poin 2x lipat dari transaksi biasa).
* **Halaman Progress Tier**: Halaman membership menampilkan badge tier, total akumulasi belanja saat ini, progress bar interaktif, serta nominal sisa belanja yang diperlukan untuk naik kelas ke tier berikutnya.

---

## 🔄 Logika Bisnis & Penanganan Voucher Batal
Untuk mencegah kerugian poin customer, sistem dilengkapi penanganan voucher otomatis:
1. **Penguncian Voucher**: Voucher bertanda `used` saat order dibuat agar tidak bisa digunakan berkali-kali secara ilegal.
2. **Pemulihan Otomatis (Reversion)**: Jika pesanan kedaluwarsa (misalnya tidak dibayar dalam waktu 24 jam) dan dibatalkan oleh sistem otomatis (`php artisan app:release-expired-stocks`), sistem akan:
   - Mengembalikan stok baju ke database sesuai varian ukuran semula.
   - **Membatalkan status terpakai** pada voucher membership (`status = 'active'`, `used_at = null`), sehingga voucher kembali aktif di akun customer.

---

## 🗄️ Struktur Database Utama (Models)
1. **`User`**: Menyimpan data akun, total spending belanja, poin, status member, dan tier keanggotaan.
2. **`Produk`**: Katalog produk batik, harga diskon, deskripsi, dan filosofi motif.
3. **`ProductSizeStock`**: Tabel pivot untuk mengelola stok per ukuran produk (S, M, L, XL).
4. **`Order`**: Menyimpan data transaksi, alamat, total bayar, status pembayaran, diskon tier member, dan relasi voucher.
5. **`OrderItem`**: Rincian produk, ukuran, dan jumlah yang dibeli dalam satu order.
6. **`UserRewardRedemption`**: Kupon/voucher belanja milik member hasil penukaran poin.
7. **`ProductReturn`**: Data komplain retur produk customer beserta status refund dan tahapan retur.
8. **`Chat` & `ChatMessage`**: Data room chat dan riwayat percakapan real-time.
9. **`Notification`**: Pusat pemberitahuan pengguna (sistem, transaksi, ulasan).
10. **`KontenSlideShow` / `KontenAboutUs` / `KontenIcon`**: Pengaturan layout statis homepage.
