# Motifnesia Client Mobile

Aplikasi Flutter untuk customer, owner, finance, kasir, gudang, dan supplier. Satu sumber Flutter dipakai untuk web, Android, dan iOS. Katalog, kartu, ikon merek, dan materi batik mengacu pada Motifnesia Client Web. Layout memakai navigasi bawah untuk customer dan menu per peran untuk staf. Layout katalog berubah jumlah kolom sesuai lebar layar.

## Persiapan dan tes web

Jika Flutter belum tersedia di Linux x86_64, jalankan installer dari folder proyek. SDK dan cache proyek disimpan di direktori `.tooling` di dalam `/mnt`.

```bash
./tool/install-flutter.sh
export PATH="$PWD/.tooling/flutter/bin:$PATH"
export PUB_CACHE="$PWD/.tooling/pub-cache"
```

Jalankan Motifnesia Server secara terpisah, lalu mulai client Flutter.

```bash
flutter pub get
flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8002 \
  --dart-define=MOTIFNESIA_API_URL=http://127.0.0.1:8000/api/v1
```

Buka `http://127.0.0.1:8002` di browser. Gunakan **Device Toolbar** untuk mengecek ukuran ponsel. Flutter menjalankan renderer web, sehingga alur login, formulir, unggah berkas, dan interaksi navigasi bisa diujikan langsung di browser.

Jika alamat API, origin media, atau halaman belanja web berbeda, atur `MOTIFNESIA_API_URL`, `MOTIFNESIA_MEDIA_URL`, dan `MOTIFNESIA_WEB_URL` dengan `--dart-define`. Nomor pembelian WhatsApp mengikuti client web dan dapat diatur memakai `MOTIFNESIA_WHATSAPP`.

## Android dan iOS

Setelah SDK tersedia, `./tool/setup-platforms.sh` menghasilkan wrapper Android dan iOS dari Flutter. Gunakan alamat HTTPS server yang dapat dijangkau perangkat. Tambahkan pengaturan signing sesuai lingkungan build, Android toolchain untuk Android, dan Xcode untuk iOS.

Android dan iOS menyimpan token di penyimpanan aman platform. Pada web, sesi berada di memori browser sehingga reload halaman membutuhkan masuk ulang.

## API dan cakupan

API v1 yang dipakai Client Web menjadi sumber katalog, validasi, akses, transaksi, pembayaran dan stok. Dokumentasi ada di [Motifnesia Server](../Motifnesia-Server/API-V1.md). Daftar route di `lib/app/routes/` memuat **43 layar** yang sesuai dengan halaman utama dan detail di web. Alias daftar produk, autosuggest, polling, unduhan CSV, dan tampilan bukti adalah aksi di dalam layar.

| Peran | Layar dan alur |
| --- | --- |
| Tamu dan akun | Katalog, pencarian dan filter, detail produk dan panduan ukuran, masuk, registrasi, reset sandi |
| Customer | Keranjang, favorit, checkout dan voucher, pembayaran dengan bukti, ringkasan pesanan, profil dan alamat, riwayat dan ulasan, retur, chat, notifikasi dan membership |
| Admin | Katalog dan edit produk, pelanggan, ulasan, pengiriman dan pembayaran, retur, laporan, notifikasi, slideshow, chat, membership, reward dan broadcast |
| Gudang dan supplier | Supplier, pembuatan dan detail pengadaan, persetujuan, pengiriman, konfirmasi sampai, penerapan stok, gudang dan stock opname |

## Struktur `lib/`

Setiap route di `app/routes/` menunjuk langsung ke satu file `*_page.dart` di `views/<peran>/pages/`. Komponen khusus peran ada di `views/<peran>/components/`. Layout, formulir, dan widget lintas peran ada di `shared/`, sementara API, sesi, dan tema ada di `core/`.

Untuk mengecek setelah memasang Flutter:

```bash
flutter analyze
flutter test
flutter build web
```

`dart test/contract_check.dart` memeriksa decoder, rute API, pagination, dan bentuk data multipart secara mandiri. Saat migrasi, verifikasi mencakup kecocokan 43 rute layar dengan web, preflight CORS, dan 40 request layar API pada SQLite terisolasi. Decoder Dart memproses 39 respons halaman dan satu redirect aturan bisnis.

[Dokumentasi setup resmi Flutter](https://docs.flutter.dev/install) · [Dokumentasi web Flutter](https://docs.flutter.dev/platform-integration/web/setup)
