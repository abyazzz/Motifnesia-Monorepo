# API Motifnesia versi 1

Gunakan `/api/v1` sebagai prefiks. Endpoint dan aksi controller yang dipakai client web terdaftar di [routes/motifnesia.php](routes/motifnesia.php). API versi 1 menerima JSON untuk form biasa, query string untuk filter dan halaman, dan multipart untuk unggahan.

## Autentikasi dan akses

| Metode dan path | Hasil |
| --- | --- |
| `POST /api/v1/login` | Terima `username` dan `password`. Kembalikan bearer token Sanctum berdurasi 12 jam beserta identitas, halaman awal, dan kemampuan pengguna. |
| `GET /api/v1/viewer` | Identitas pengguna, atau `null` untuk tamu. |
| `POST /api/v1/logout` | Cabut token aktif dan hapus draft checkout terkait. |
| `POST /api/v1/register` | Registrasi customer dengan field yang sama seperti form web. |
| `POST /api/v1/forgot` | Reset sandi setelah memeriksa pertanyaan keamanan. Cabut token akun setelah sandi diubah. |

Kirim `Authorization: Bearer <token>` untuk aksi terautentikasi. Server merespons 401 untuk token yang tidak berlaku, 403 untuk hak akses yang tidak mencukupi, dan 422 untuk validasi atau kegagalan aturan bisnis. Endpoint lama yang meminta autentikasi tetap menerima token wildcard lama. Autentikasi, registrasi, dan reset versi 1 memiliki rate limiter.

## Respons

- Halaman data mengembalikan `page`, `data`, dan `viewer`. `page` adalah nama template untuk client web. `data` memuat data terotorisasi, termasuk koleksi dengan `_type: collection` dan `items`, record dengan `_type: record` dan `fields`, waktu ISO, serta pagination berisi item, jumlah total, ukuran halaman, halaman aktif, dan nama parameter halaman.
- Aksi AJAX menjaga struktur JSON controller lama. Checkout mengembalikan `redirect_url` relatif. Aksi yang sebelumnya mengirim redirect mengembalikan `redirect`, `flash`, `message`, dan `errors`. Client menentukan navigasi dan menampilkan pesan.
- Laporan CSV dan bukti unggahan mengembalikan konten berkas. Permintaan bukti melewati pemeriksaan akses server.
- Pagination dibangun ulang sesuai URL dan query client. Link notifikasi lama dipetakan ke path client. Atur `MOTIFNESIA_CLIENT_URL` di server untuk link baru di notifikasi dan email.

## Checkout

1. Pilih baris milik akun dengan `POST /api/v1/cart/checkout` dan array `selected_items`.
2. Ambil `GET /api/v1/checkout`. Kirim `alamat`, `metode_pengiriman_id`, `metode_pembayaran_id`, dan opsional `voucher_code` ke `POST /api/v1/checkout/store`.
3. Ambil `GET /api/v1/payment` dengan token yang sama untuk menampilkan draft. Kirim `payment_number` dan unggahan gambar `payment_proof` ke `POST /api/v1/payment/store`.
4. Ambil rincian hasil dari path `/transaction/success/{orderId}` yang diberikan server.

Draft disimpan di cache server dengan lock atomik. Gunakan satu cache bersama yang mendukung lock atomik untuk beberapa instance server dan atur `MOTIFNESIA_WORKFLOW_STORE` sesuai nama store Laravel. Default `file` cocok untuk satu instance. Tetapkan `ASSET_URL` ke origin publik media jika URL internal API berbeda dari origin yang dapat diakses browser.
