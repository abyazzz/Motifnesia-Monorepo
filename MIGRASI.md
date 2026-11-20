# Migrasi Motifnesia

Folder [Motifnesia-Server](Motifnesia-Server) dan [Motifnesia-Client-Web](Motifnesia-Client-Web) adalah dua aplikasi Laravel 12 yang dapat dijalankan terpisah. Client menggunakan sesi terenkripsi di sisi server web dan mengirim bearer token ke API. Route, form, layout, Blade, CSS, dan JavaScript mengikuti fullstack referensi. Query bisnis, otorisasi, validasi, transaksi, observer, dan akses ke berkas bukti berada di server.

## Baseline

Sumber pembanding berada di `../Motifnesia-fullstak`. Folder itu tidak memiliki metadata Git. [BASELINE.sha256](BASELINE.sha256) mencatat isi kode, aset publik, dan tes saat penyalinan. [BASELINE-ROUTES.json](BASELINE-ROUTES.json) mencatat hasil inventaris dari salinan awal setelah bootstrap. Untuk mengecek perubahan referensi pada file yang tercatat, jalankan dari folder `Motifnesia`:

```bash
(cd ../Motifnesia-fullstak && sha256sum --quiet -c ../Motifnesia/BASELINE.sha256)
```

Periksa juga file baru saat mengulang validasi. [Manifes route server](Motifnesia-Server/routes/motifnesia.php) memetakan endpoint API v1 ke aksi controller. [Manifes route client](Motifnesia-Client-Web/routes/motifnesia.php) memetakan URL browser ke endpoint yang sesuai.

## Inventaris alur

| Akses | Alur dalam implementasi referensi dan client |
| --- | --- |
| Publik dan akun | Home, daftar dan filter produk, pencarian, detail produk, registrasi, login via nama pengguna atau email, reset sandi, logout |
| Customer | Keranjang per ukuran, favorit, alamat, profil, riwayat belanja, checkout, voucher dan diskon tier, pembayaran dengan bukti, konfirmasi pesanan sampai, ulasan, retur dengan bukti dan tahap kurir, chat, notifikasi, membership dan riwayat poin |
| Owner | Produk dan stok ukuran, konten slideshow, pelanggan, supplier, membership, reward, broadcast, serta akses kasir, finance, dan gudang melalui Gate |
| Kasir | Katalog admin, status pengiriman, moderasi ulasan, pelayanan chat, retur dan notifikasi |
| Finance | Status dan verifikasi pembayaran, akses bukti pembayaran, laporan dan ekspor CSV |
| Gudang | Pengadaan, konfirmasi barang sampai, penerapan stok, matriks gudang, stock opname |
| Supplier | Pengadaan milik supplier sendiri, detail item per ukuran, persetujuan dan status pengantaran |

Otorisasi untuk tiap tindakan mengikuti Gate dan pemeriksaan pemilik data pada controller server. Navigasi mengambil kemampuan dari API. Pengumpulan data Blade yang sebelumnya mengeksekusi query, seperti jumlah pesanan dan chat belum dibaca, dipindah ke controller server.

## Perubahan kontrak dan penyimpanan

- API lama di `/api` mempertahankan jalur. Token yang diterbitkan oleh API lama tetap berlaku sesuai hak akses sebelumnya. Token yang diterbitkan oleh login versi 1 dibatasi ke kontrak versi 1.
- API baru memakai prefiks `/api/v1`. Lihat [kontrak dan contoh request](Motifnesia-Server/API-V1.md).
- Logout dan menambahkan produk dari favorit ke keranjang memakai POST dengan CSRF pada client.
- Bukti pembayaran dan retur ada di storage privat server. Berkas lama yang ikut tersalin ditempatkan di `storage/app/private/order-proofs/legacy`, dengan path lama tetap dibaca dari database. Backend memeriksa Gate atau pemilik berkas setiap kali gambar diambil.
- Checkout menyimpan draft berdasarkan token server. Pembayaran mengunci baris keranjang di transaksi database sebelum menulis pesanan. Draft yang sudah terpakai atau berbeda dari isi keranjang ditolak untuk mencegah transaksi ganda antar sesi.
- Login dummy yang sebelumnya hanya menaruh data ke sesi web diganti dengan autentikasi akun database. Endpoint ulasan lama memakai pengguna terautentikasi. Jawaban reset tidak disertakan dalam serialisasi pengguna.
- Route halaman web lama dan seluruh template aplikasi di `Motifnesia-Server/resources/views` sudah dihapus. API mengirim nama template dan data agar client dapat merender Blade. Tautan notifikasi dan email memakai `MOTIFNESIA_CLIENT_URL` di konfigurasi server.

## Menjalankan dua aplikasi

Baca konfigurasi [client web](Motifnesia-Client-Web/README.md) sebelum mulai. Untuk integrasi, jalankan server dengan database uji khusus dan mailer `array`. Salinan `.env` server menunjuk MySQL yang sama dengan referensi. Gunakan override `DB_CONNECTION`, `DB_DATABASE`, `DB_URL`, `MAIL_MAILER`, `QUEUE_CONNECTION`, `CACHE_STORE`, dan `SESSION_DRIVER` pada proses uji. Periksa jalur database efektif sebelum menjalankan migrasi atau seeder.

Tes PHPUnit server memaksa SQLite in-memory. Jalankan `php artisan test` di setiap aplikasi. Build aset client dengan `npm run build`.

Sebelum cutover, siapkan backup database dan berkas unggahan. Perbarui salinan aset dari perubahan referensi setelah baseline, lalu validasi aplikasi pada salinan MySQL dan browser. Jadwalkan transisi penulis database bersama pemilik proyek. Review skema aktif dan pemetaan penyimpanan sebelum mengubah layanan produksi.

## Hasil validasi

| Pemeriksaan | Hasil |
| --- | --- |
| PHPUnit | 13 tes server dan 4 tes client lulus |
| Penghapusan view server | 74 file view dihapus. Seluruh 156 route API cocok dengan metode, path, nama, action, dan middleware sebelum perubahan. Route cache dan 148 pemeriksaan integrasi lulus setelah penghapusan. |
| Build | Blade terkompilasi dan build Vite lulus |
| Render dan navigasi | 58 pemeriksaan pada halaman dan endpoint untuk tamu, customer, owner, finance, kasir, gudang, dan supplier lulus |
| Alur bisnis dengan data uji | 74 pemeriksaan mencakup voucher, keranjang, checkout, unggahan bukti, pembayaran, saldo stok, konfirmasi sampai, retur, ulasan, chat, notifikasi, pengadaan, dan ekspor |
| Akun dan admin | 16 pemeriksaan mencakup registrasi, reset sandi, produk, slideshow, dan broadcast dengan mailer uji |
| Pembandingan referensi | Teks render dari 23 halaman cocok dengan salinan baseline yang dijalankan memakai data uji yang sama |

Pemeriksaan integrasi menjalankan kernel Laravel client dan server dengan SQLite terisolasi. Sandbox memblokir socket HTTP lokal sehingga pengujian browser, visual, dan JavaScript interaktif belum berjalan. Instalasi MariaDB uji juga belum menghasilkan instance yang bisa diakses. Kesetaraan 1:1 masih perlu diverifikasi di browser dan pada salinan MySQL sebelum cutover. Konfigurasi database di salinan server cocok dengan referensi dan database aktif belum diakses dalam migrasi ini.

Suite untuk browser tersedia di [tests/browser](tests/browser/README.md). Percobaan Chrome headless di sandbox berhenti sebelum navigasi karena operasi socket diblokir. Konfigurasi fixture SQLite berhasil diuji secara terpisah. Hasil browser masih belum tersedia.
