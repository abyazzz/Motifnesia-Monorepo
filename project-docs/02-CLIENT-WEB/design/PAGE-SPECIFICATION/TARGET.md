# Rancangan tambahan Client Web · PROPOSED

Rancangan dapat berupa halaman baru, bagian halaman yang sudah ada, atau dialog. Gunakan layout tabel atau detail berpanel dengan alur keyboard. Dialog aksi membutuhkan fokus, label, dan meskipun ada pratinjau, hasil tetap berasal dari Server.

| Halaman | Use Case | Aktor | Jalur masuk | Komponen dan data | Validasi dan error | Kontrak dibutuhkan |
| --- | --- | --- | --- | --- | --- | --- |
| Kelola akun internal | UC-07 | Super Admin Owner | Menu Admin | Daftar akun, role, status dan histori. Dialog edit/nonaktif sesuai izin. | Tampilkan hanya akun target sah. Tolak ubah Owner lain, cek sesi aktif dan konfirmasi mutasi. | Operasi pengelolaan staf pada Server |
| Pemulihan melalui email | UC-03 | Guest dan pengguna akun terkait | Masuk → Pemulihan | Input identitas, status permintaan, layar token dan sandi baru. | Pesan pemulihan yang aman, expiry dan retry sesuai server. | Kontrak pemulihan email |
| Instruksi dan status gateway | UC-20, UC-23 | Customer | Checkout → Pembayaran → Pesanan | Instruksi metode, tenggat, pending/sukses/gagal dan tautan status. | Tampilkan hasil dari Server. Refresh setelah kembali dari provider. UC-21/22 berjalan antarsistem. | Inisiasi pembayaran dan status terotorisasi |
| Pengemasan dan resi | UC-24, UC-25, UC-26 | Admin Gudang, Customer | Pesanan dan detail | Daftar tugas packing, resi, kurir, tanggal. Customer melihat rincian yang diizinkan. | Akses per aksi. State berubah setelah server verifikasi. | Pencatatan pengiriman manual |
| Dokumen dan penerimaan PO | UC-30, UC-32, UC-33 | Admin Gudang, Super Admin Owner | Detail Pengadaan | Aksi unduh, histori eksternal, input jumlah aktual dan distribusi per ukuran. | Sisa PO dan penerimaan parsial; tolak duplikat dan tampilkan error kontrak. | Purchase order, konfirmasi eksternal, dan penerimaan |
| Inspeksi dan pembayaran refund | UC-42, UC-43, UC-44, UC-45, UC-46 | Admin Gudang, Admin Kasir, Admin Finance, Customer | Retur dan detail pesanan | Kondisi dan bukti, resolusi, penukaran, catatan transfer Finance. Customer melihat hasil. | Hak data per role, preview bukti privat, status refund dibaca dari server. | Pemeriksaan dan refund manual |
| Laporan stok dan pengadaan | UC-63, UC-64 | Admin Gudang, Super Admin Owner | Gudang dan Pengadaan | Filter periode/jenis/pergerakan atau supplier, ringkasan jumlah dan biaya yang tersedia. | Tampilan kosong dan ekspor hanya sesuai kontrak. | Laporan persediaan dan penerimaan |
| Hapus ulasan dan notifikasi | UC-51, UC-59 | Admin Kasir, Super Admin Owner, Customer | Detail ulasan admin dan Notifikasi customer | Konfirmasi hapus, daftar hasil terbaru, undo hanya bila didukung. | Pemeriksaan terhadap kepemilikan dan kebijakan retensi. | Penghapusan yang terotorisasi |
| Pengiriman broadcast dan status | UC-61 | Admin Kasir, Super Admin Owner | Konten → Broadcast | Pratinjau, konfirmasi audiens semua Customer, antrean dan status hasil. | Bedakan gagal sebagian dan proses tertunda. Jangan klaim diterima tanpa bukti. | Kontrak pengiriman/status broadcast |

Setiap form menampilkan loading dan cegah kirim ganda, setiap daftar memiliki empty state sesuai filter, serta setiap aksi menjaga fokus dan informasi error. Spesifikasi path dan aksi diputuskan setelah [API Target](../../../01-SERVER/design/API-DESIGN/API-TARGET.md) disetujui.
