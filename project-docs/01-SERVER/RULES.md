# Aturan Backend Server

Ikuti [aturan global](../00-GLOBAL/GLOBAL-RULES.md).

## Kontrak dan kerahasiaan

- Bentuk perubahan request, response, status, pagination, schema error, dan file terotorisasi di kontrak v1. Cek penggunaan pada dua client sebelum mengubah.
- Pertahankan Sanctum dan Gate di Server. Periksa scope token, role, kepemilikan dan transisi state pada setiap aksi. Jaga bukti privat sesuai izin dan minimalkan data sensitif yang dikembalikan.
- Gunakan Form Request atau validator yang sesuai dan kembalikan error konsisten. Tes kesesuaian validasi data upload dan penolakan objek milik akun berbeda.

## Transaksi dan desain

- Reservasi, pelepasan stok, penerimaan barang, status pembayaran, retur dan poin memerlukan invarian transaksi, locking yang cukup, idempotensi dan jejak perubahan.
- Rancangan gateway mengikuti UC-20–22. Verifikasi hasil di Server, korelasikan event serta order, tangani duplikasi dan hasil terlambat sesuai kontrak yang ditetapkan. Bukti transfer dan pembayaran manual aktual menjadi konteks transisi.
- Buat perubahan data dengan strategi backfill, pemeriksaan jumlah, kompatibilitas data lama dan rencana rollback. Rancangan PROPOSED menunggu review sebelum pengembangan.
- Untuk perubahan kode, cakup pengujian akses, validasi, transaksi konkurensi, retry, kondisi state lama dan kedua client sesuai scope.
