# Motifnesia Client Web

Aplikasi Laravel 12 ini merender storefront, panel admin, dan portal supplier. Data bisnis diambil dari API Motifnesia. Sesi browser disimpan sebagai file Laravel yang terenkripsi. Token API berada di sisi server client web.

## Setup

```bash
composer install
cp -n .env.example .env
php artisan key:generate
npm ci
npm run build
```

Jalankan `key:generate` untuk instalasi baru saat `APP_KEY` kosong. Gunakan `MOTIFNESIA_API_URL` untuk base URL REST dan `MOTIFNESIA_MEDIA_URL` untuk origin publik media server. Proyek ini tidak memerlukan migrasi database.

```bash
php artisan serve --host=127.0.0.1 --port=8001
```

Konfigurasi contoh mengasumsikan server berjalan di `127.0.0.1:8000`. Gunakan HTTPS untuk client dan API saat deploy. Untuk pengujian otomatis jalankan `php artisan test`.
