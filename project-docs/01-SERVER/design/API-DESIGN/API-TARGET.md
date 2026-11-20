# Desain API TARGET dan PROPOSED

Operasi di tabel menggambarkan perubahan yang diperlukan oleh target. Nama, method/path final, versi, payload definitif dan status code merupakan bagian review kontrak. Client memakai endpoint aktual sampai kontrak disetujui dan tersedia.

| Status | Operasi dan dasar | Request dan guard yang perlu ditetapkan | Respons dan asersi |
| --- | --- | --- | --- |
| Penyesuaian | Pemulihan akun UC-03 | Identitas dan bukti verifikasi via email, expiry, rate limit, respons yang tidak membocorkan keberadaan akun | Hasil permintaan dan konfirmasi, invalidasi token sesuai kebijakan |
| Operasi baru | Pengelolaan staf UC-07 | Owner, akun Admin Finance/Kasir/Gudang, batas perubahan Owner lain | Perubahan terotorisasi dan histori, penolakan eskalasi |
| Penyesuaian | Akses data pelanggan/katalog/promosi dan membership UC-08/12/13/55–57/60 | Owner/Kasir/Gudang sesuai skenario per aksi. Pemetaan akses data detail dipisah dari izin edit | Informasi akses terverifikasi dan penolakan aksi dengan state/role yang salah |
| Penyesuaian | Checkout UC-16/19 | Customer dan baris keranjang miliknya, alamat, tanggal, harga dan stok varian, idempotensi | Order, reservasi per item, ringkasan pembayaran, tenggat 23.59 menurut kalender bisnis |
| Operasi baru | Inisiasi gateway, status dan callback UC-20–23 | Customer memulai attempt. Callback membutuhkan autentikasi provider dan korelasi order. Pengolahan memakai nilai dari sumber terverifikasi | Instruksi pembayaran, status, event duplikat aman, perubahan order atomik, kebijakan event terlambat TBD |
| Penyesuaian | Kemas, catat resi, lihat dan konfirmasi UC-24–27 | Gudang atau Customer sesuai aksi, transisi state, kode kurir dan resi yang dicatat manual | Histori dan informasi pengiriman tanpa API ekspedisi |
| Penyesuaian | Data supplier, status dan pencatatan konfirmasi UC-28/29/31/32 | Gudang/Owner mencatat data supplier serta konfirmasi dari kanal eksternal | Status dan histori pengadaan, jalur transisi portal lama perlu keputusan |
| Operasi baru | Dokumen PO dan penerimaan UC-30/33 | PO dan versi, kuantitas terima per varian, aktor internal, validasi sisa pengadaan dan harga modal bila disetujui | Unduhan PO terotorisasi, penerimaan parsial, posting stok aktual sekali |
| Penyesuaian | Hitung fisik, penyesuaian dan histori UC-34–38 | Gudang/Owner, produk, varian, jumlah aktual, alasan, filter histori | Matriks dan ledger mutasi, penolakan input tidak konsisten |
| Penyesuaian | Form retur UC-39–41 | Item milik Customer, batas tiga hari setelah terima dan bukti foto/video, role pemeriksa | Nomor dan status retur, penolakan duplikat, format unggah TBD |
| Operasi baru | Pemeriksaan, resolusi, penukaran dan refund UC-42–46 | Gudang/Kasir mencatat sesuai peran. Finance mencatat transfer manual dan bukti privat. Aturan stok layak jual dan poin | Status terpisah per pemeriksaan, resolusi, refund dan histori |
| Penyesuaian | Chat UC-47 | Kewenangan peserta dan thread, pemulihan koneksi serta urutan pesan. Teknologi real-time TBD | Pengiriman, histori, mitigasi retry |
| Penyesuaian | Manajemen ulasan UC-51 | Admin berwenang dapat menghapus ulasan terbit sesuai kebijakan. Ulasan valid terbit langsung | List, detail dan hasil tindakan, tanpa revisi isi/rating |
| Operasi baru | Hapus notifikasi UC-59 | Customer pemilik notifikasi | Hasil penghapusan atau penolakan akses |
| Penyesuaian | Broadcast UC-61 | Kasir/Owner memilih konten dan konfirmasi semua Customer sebagai audiens sesuai target | Catatan pemrosesan dan hasil tersedia, kebijakan email/retry TBD |
| Penyesuaian | Penjualan dan refund UC-62 | Finance/Owner, rentang tanggal pembayaran berhasil, filter dan izin ekspor | Nilai penjualan dan refund terpisah |
| Operasi baru | Laporan stok dan pengadaan UC-63/64 | Gudang/Owner, periode/produk/jenis mutasi atau supplier serta data penerimaan | Ringkasan, hasil kosong dan validasi parameter, format ekspor TBD |

Pertahankan endpoint dan status manual yang masih diperlukan untuk data historis selama transisi disepakati. Perbarui skema API, matriks UC/KF, tes kontrak dan kedua client dalam pekerjaan implementasi. [Traceability](../../../00-GLOBAL/TRACEABILITY-MATRIX.md) · [Keputusan terbuka](../../../00-GLOBAL/DECISION-LOG.md)
