# Aturan Client Web

Ikuti [aturan global](../00-GLOBAL/GLOBAL-RULES.md).

## Halaman dan integrasi

- Deklarasikan format web sesuai Blade dan pola layout yang ada. Gunakan role dan ability dari viewer untuk menampilkan menu dan aksi. Server tetap menolak aksi bila tidak berwenang.
- Pertahankan token di sesi Laravel Web. Terapkan CSRF pada mutasi dan pastikan redirect berasal dari path internal yang sah. Hindari data sandi/OTP/bukti dalam flash, error, atau log.
- Selaraskan nama input, tipe file, query, pagination, dan state error dengan API. Render error field dan status sesuai respons. Tampilkan akses ditolak, sesi berakhir, server tidak terjangkau dan hasil kosong dengan konteks yang jelas.
- Gunakan navigasi keyboard, label form, fokus setelah error, dan responsivitas pada desktop serta viewport sempit. Cegah kirim ganda pada aksi yang sedang diproses.
- Uji route, sesi, akses dan rendering Blade menggunakan respons terkontrol. Uji browser untuk form, navigasi, unggah dan aksi AJAX saat lingkungan mendukung.
