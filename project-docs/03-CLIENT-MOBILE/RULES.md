# Aturan Client Mobile

Ikuti [aturan global](../00-GLOBAL/GLOBAL-RULES.md).

## Layar dan state

- Tambahkan screen pada file per fitur dan daftar route per role. Bangun ulang layar sesuai batas viewport dan target sentuh. Lakukan reuse pada shared widgets, layout, dan form bila perilaku sama.
- Pisahkan state sesi, data API, dan state UI lokal. Kelola loading, kosong, gagal, refresh, navigasi kembali, deep link, serta cleanup timer ketika layar dilepas.
- Gunakan kontrak yang didokumentasikan Server. Kirim multipart sesuai nama field dan batas unggah. Gunakan token aman platform native dan state memori web sesuai pola sekarang.
- Validasi form mendukung UX. Periksa error API per field dan jangan mengasumsikan izin dari tampilan tombol. Tampilkan retry yang aman dan cegah aksi pembayaran, stok, atau retur ganda.
- Jalankan analyzer, uji kontrak, uji widget dan build pada perubahan relevan. Uji alur sempit di browser serta platform Android/iOS saat wrapper dan perangkat tersedia.
