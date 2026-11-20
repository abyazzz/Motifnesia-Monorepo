# Motifnesia Monorepo

Motifnesia adalah platform penjualan batik dengan katalog, checkout, pembayaran, membership, dan dukungan pelanggan. Admin mengelola pesanan, stok, retur, dan laporan. Supplier memakai portal pengadaan untuk menyetujui pengadaan dan memperbarui status pengiriman.

## Aplikasi

| Folder | Peran | Alamat lokal | Dokumentasi |
| --- | --- | --- | --- |
| `Motifnesia-Server/` | Backend Laravel 12 untuk API, autentikasi Sanctum, aturan bisnis, database, dan media | `http://127.0.0.1:8000` | [Server](Motifnesia-Server/README.md) · [API v1](Motifnesia-Server/API-V1.md) |
| `Motifnesia-Client-Web/` | Storefront, panel admin, dan portal supplier dengan Laravel 12, Blade, dan Vite | `http://127.0.0.1:8001` | [Client Web](Motifnesia-Client-Web/README.md) |
| `Motifnesia-Client-Mobile/` | Client Flutter untuk Android dan iOS, dengan mode web untuk pengujian | `http://127.0.0.1:8002` | [Client Mobile](Motifnesia-Client-Mobile/README.md) |

Kedua client berkomunikasi dengan Motifnesia Server melalui `/api/v1`. Data transaksi, validasi, dan hak akses dikelola di server.

## Cara clone

Jalankan dari direktori tempat Anda ingin menyimpan proyek. Satu clone mengambil ketiga aplikasi.

```bash
git clone https://github.com/abyazzz/Motifnesia-Monorepo.git
cd Motifnesia-Monorepo
```

Jika repo bersifat privat dan Git belum terautentikasi, masuk ke akun GitHub yang punya akses dengan GitHub CLI, lalu ulangi perintah clone.

```bash
gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git --hostname github.com
```

## Kebutuhan pengembangan

- Instalasi server dan client web dari `composer.lock` membutuhkan PHP 8.4.1 atau lebih baru pada seri 8.4, atau PHP 8.5, serta Composer.
- Server menggunakan ekstensi PHP `pdo_mysql` dan database MySQL atau MariaDB lokal.
- Build aset client web menggunakan Node.js 20.19 atau lebih baru pada seri 20, atau Node.js 22.12 ke atas, beserta npm.
- Client mobile menggunakan Flutter 3.44 atau lebih baru dengan Dart 3.13 atau lebih baru, sesuai `pubspec.lock`.

## Menjalankan secara lokal

Buka terminal terpisah dari root repo untuk tiap aplikasi. Jalankan server lebih dulu, lalu jalankan client yang ingin dipakai.

### 1. Motifnesia Server

```bash
cd Motifnesia-Server
composer install
cp .env.example .env
php artisan key:generate
```

Buat database pengembangan MySQL atau MariaDB. Isi `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, dan `DB_PASSWORD` di `.env` sesuai database tersebut. Untuk alamat lokal di atas, gunakan `APP_URL=http://127.0.0.1:8000` dan `MOTIFNESIA_CLIENT_URL=http://127.0.0.1:8001`.

```bash
php artisan migrate
php artisan storage:link
```

Untuk mengisi data contoh dan referensi transaksi pada database pengembangan baru, jalankan `php artisan db:seed` setelah migrasi. Mulai server dengan perintah berikut, lalu buka `http://127.0.0.1:8000/up` untuk memeriksa statusnya.

```bash
php artisan serve --host=127.0.0.1 --port=8000
```

### 2. Motifnesia Client Web

```bash
cd Motifnesia-Client-Web
composer install
cp .env.example .env
php artisan key:generate
npm ci
npm run build
php artisan serve --host=127.0.0.1 --port=8001
```

Buka `http://127.0.0.1:8001`. Konfigurasi contoh sudah mengarahkan `MOTIFNESIA_API_URL` dan `MOTIFNESIA_MEDIA_URL` ke server lokal.

### 3. Motifnesia Client Mobile di browser

```bash
cd Motifnesia-Client-Mobile
flutter pub get
flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8002 \
  --dart-define=MOTIFNESIA_API_URL=http://127.0.0.1:8000/api/v1
```

Buka `http://127.0.0.1:8002`. Pengaturan SDK lokal serta wrapper Android dan iOS ada di [panduan Client Mobile](Motifnesia-Client-Mobile/README.md).

## Pengujian

| Cakupan | Perintah |
| --- | --- |
| Laravel | `php artisan test` dari folder server atau client web |
| Flutter | `flutter analyze`, `flutter test`, dan `flutter build web` dari folder client mobile |
| Browser | `node tests/browser/run.mjs` dari root setelah membangun aset client web, sesuai [panduan tes browser](tests/browser/README.md) |

Latar belakang pemisahan server dan client ada di [catatan migrasi](MIGRASI.md).
