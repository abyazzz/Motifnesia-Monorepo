# Arsitektur lintas aplikasi

## AS-IMPLEMENTED

[Diagram aplikasi](current.mmd) menggambarkan alur produksi data dari klien sampai penyimpanan. Browser Web mengirim form ke Laravel Web. `MotifnesiaController` meneruskan HTTP ke Server menggunakan token di sesi, lalu merender Blade dari `PageData`. Client Flutter memanggil API yang sama melalui `MotifnesiaApi`, memulihkan sesi native dari secure storage, serta memvalidasi navigasi dengan `AppRouter`. [Controller Web](../../../Motifnesia-Client-Web/app/Http/Controllers/MotifnesiaController.php) · [Sesi Flutter](../../../Motifnesia-Client-Mobile/lib/core/session/session_controller.dart)

Server memakai middleware `WebApi` untuk token, role, envelope respons, dan penyimpanan draft berumur terbatas. Otorisasi aksi berada pada Gate atau pemeriksaan objek di controller. State pesanan, stok dan keanggotaan ada di database, dan bukti di storage privat. [Middleware](../../../Motifnesia-Server/app/Http/Middleware/WebApi.php) · [Kontrak v1](../../../Motifnesia-Server/API-V1.md)

## TARGET

[Diagram konteks target](target.mmd) menambahkan gateway sebagai sistem eksternal. Supplier dan kurir bertukar informasi melalui kanal luar sistem. Admin berwenang mencatat hasil komunikasi, resi, dan penerimaan. Finance mencatat refund manual. Sebelum perubahan versi API, tetapkan kontrak dan mekanisme migrasi bagi kedua client. [TO-BE](../references/PERANCANGAN%20FINAL%20PROSES%20BISNIS%20TO-BE%20MOTIFNESIA.md)
