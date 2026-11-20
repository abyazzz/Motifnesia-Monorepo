# UI/UX Web

Pertahankan identitas toko, fotografi katalog, kartu produk, navigasi customer dan sidebar admin yang ada. Pengguna memilih produk lewat pencarian, filter, detail dan pilihan ukuran. Rancangan menyimpan konteks filter setelah membuka detail dan mengembalikan fokus ke pemicu dialog. [Layout katalog aktual](../../../../Motifnesia-Client-Web/resources/views/customer/layouts/mainLayout.blade.php)

Untuk area staf, gunakan navigasi berlandaskan ability. Sediakan tabel ringkas yang dapat disortir dan difilter, peralihan ke detail, serta konfirmasi untuk aksi yang mengubah state atau menghapus. Jelaskan alasan penolakan status dan akses dengan pesan dekat tindakan, kemudian perbarui data. Bukti pembayaran atau retur terlihat sesuai delegasi role server.

- Layar lebar dapat memakai panel daftar/detail. Saat sempit, gunakan kolom tunggal, kontrol mudah dijangkau dan scroll yang jelas tanpa memotong label atau nilai.
- Informasi penting, seperti batas bayar, status pesanan dan saldo voucher memakai teks dengan semantik yang konsisten di Web dan Mobile.
- Keadaan kosong membedakan data belum ada dari filter yang tidak menemukan hasil. Validation summary memberi tautan ke input yang bermasalah. Jaga fokus dan aria live ketika form atau hasil AJAX berubah.
- Pembayaran target memisahkan instruksi bayar, status pending, dan kesuksesan terkonfirmasi. Target supplier mengandalkan kanal eksternal dan pencatatan internal. [Spesifikasi](../PAGE-SPECIFICATION/README.md) · [Sitemap](../SITEMAP/README.md)
