# Admin · Client Web

Data, aksi dan route awal berasal dari kode. Panduan keadaan layar dan responsivitas memberi kriteria desain. Rancangan target mengikuti skenario dan menunggu penyelarasan kontrak untuk gap. [Indeks](README.md)

## Halaman 20

### Manajemen Produk

**Route AS-IMPLEMENTED** `/admin/product-management` · **Aktor saat ini** Super Admin Owner, Admin Kasir. [productManagement.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/productManagement.blade.php)

- Tujuan dan informasi. Daftar produk, stok, diskon dan SKU.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual.
- Aksi aktual. Cari/filter, buka detail, edit atau hapus sesuai izin.
- Jejak target. [UC-13](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-13).
- Validasi dan keadaan kosong. Form dan stok diverifikasi server. Kosong tampilkan belum ada produk sesuai filter.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Sesuaikan edit Gudang/Owner sesuai UC; pertahankan akses transisi hingga contract disetujui.

Sumber data awal. [`GET /admin/product-management`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-033). Aksi dan data pendukung. [`POST /admin/products/{id}/delete`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-038), [`POST /admin/products/{id}/update`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-039).

## Halaman 21

### Tambah Produk

**Route AS-IMPLEMENTED** `/admin/products/create` · **Aktor saat ini** Super Admin Owner. [addProduct.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/addProduct.blade.php)

- Tujuan dan informasi. Form produk, harga, ukuran/stok dan foto.
- Komponen. Form berlabel, ringkasan dan tindakan utama.
- Aksi aktual. Isi form, unggah, simpan lalu kembali ke daftar.
- Jejak target. [UC-12](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-12).
- Validasi dan keadaan kosong. Nama dan SKU, harga dan stok, tipe/ukuran gambar sesuai server. Kosong tampilkan form.
- Loading. Saat submit, tampilkan progres di form dan cegah kirim ganda.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Form satu kolom pada viewport sempit dengan label dan pesan per field. Jaga fokus setelah validasi.
- Rancangan target. Dukung Gudang/Owner sesuai skenario dan pisahkan katalog dari mutasi stok rutin.

Sumber data awal. [`GET|POST /admin/products/create`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-037).

## Halaman 22

### Status Pengiriman

**Route AS-IMPLEMENTED** `/admin/order-status` · **Aktor saat ini** Empat peran admin dengan batas aksi pada Gate. [orderStatus.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/orderStatus.blade.php)

- Tujuan dan informasi. Order, pembayaran, status dan bukti transfer.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Finance verifikasi bayar, Kasir ubah status pengiriman menurut Gate, lihat bukti sesuai akses.
- Jejak target. [UC-19](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-19), [UC-23](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-23), [UC-24](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-24), [UC-25](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-25).
- Validasi dan keadaan kosong. Guard transisi, order dan pembayaran; kosong tampilkan hasil nol.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Perlihatkan pesan validasi/status terbaru. Segarkan data jika aksi tidak sah atau sesi/draft kedaluwarsa. Cegah pengulangan mutasi tanpa mengetahui hasil.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED pisah tampilan Finance dan aksi internal Gudang/Kasir. Tampilkan status gateway, packing, resi dan histori.

Sumber data awal. [`GET /admin/order-status`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-029). Aksi dan data pendukung. [`POST /admin/order-status/{id}/payment`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-030), [`POST /admin/order-status/{id}/update`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-031), [`GET /admin/order-status/{order}/payment-proof`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-032).

## Halaman 23

### Daftar Pelanggan

**Route AS-IMPLEMENTED** `/admin/customers` · **Aktor saat ini** Super Admin Owner. [customerList.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/customerList.blade.php)

- Tujuan dan informasi. Identitas ringkas, aktivitas pesanan dan status akun.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Lihat daftar dan akses tindakan Owner saat ini.
- Jejak target. [UC-08](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-08).
- Validasi dan keadaan kosong. Otorisasi dan target aksi di server. Kosong sebut belum ada Customer.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Tambah edit/status Customer bagi Kasir/Owner sesuai target dan kebijakan akun.

Sumber data awal. [`GET /admin/customers`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-001). Aksi dan data pendukung. [`DELETE /admin/customers/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-002).

## Halaman 24

### Kelola Retur

**Route AS-IMPLEMENTED** `/admin/returns` · **Aktor saat ini** Super Admin Owner, Admin Kasir. [returnManagement.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/returnManagement.blade.php)

- Tujuan dan informasi. Daftar retur, status, alasan dan bukti.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual.
- Aksi aktual. Filter, tinjau bukti, ubah status dan catat alasan, hapus jika diizinkan.
- Jejak target. [UC-41](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-41), [UC-42](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-42), [UC-43](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-43), [UC-44](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-44), [UC-45](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-45).
- Validasi dan keadaan kosong. Status/note sesuai ketentuan. Kosong beri reset filter.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Perlihatkan pesan validasi/status terbaru. Segarkan data jika aksi tidak sah atau sesi/draft kedaluwarsa. Cegah pengulangan mutasi tanpa mengetahui hasil.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED panel inspeksi Gudang, keputusan resolusi Kasir/Gudang, pencatatan refund Finance dengan bukti.

Sumber data awal. [`GET /admin/returns`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-040). Aksi dan data pendukung. [`DELETE /admin/returns/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-041), [`POST /admin/returns/{id}/update-status`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-042), [`GET /admin/returns/{return}/proof/{kind}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-043).

## Halaman 25

### Ulasan Produk

**Route AS-IMPLEMENTED** `/admin/product-reviews` · **Aktor saat ini** Super Admin Owner, Admin Kasir. [reviewModeration.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/reviewModeration.blade.php)

- Tujuan dan informasi. Produk, ringkasan rating dan jumlah ulasan.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Urut/filter, buka detail produk.
- Jejak target. [UC-51](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-51).
- Validasi dan keadaan kosong. Akses Kasir/Owner. Kosong tampilkan belum ada ulasan.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Pertahankan indeks ulasan terbit, fungsionalitas hapus ada di detail sesuai kebijakan.

Sumber data awal. [`GET /admin/product-reviews`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-034).

## Halaman 26

### Detail Ulasan

**Route AS-IMPLEMENTED** `/admin/product-reviews/{id}` · **Aktor saat ini** Super Admin Owner, Admin Kasir. [productReviewDetail.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/productReviewDetail.blade.php)

- Tujuan dan informasi. Ulasan, identitas yang diizinkan, status dan rating.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Lihat ulasan dan tindakan moderasi yang tersedia saat ini.
- Jejak target. [UC-51](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-51).
- Validasi dan keadaan kosong. Akses dan identifier valid. Untuk produk tanpa ulasan, tampilkan pesan kosong.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED konfirmasi hapus ulasan terbit dan baca kembali status. Hilangkan perubahan isi/rating dalam rancangan target.

Sumber data awal. [`GET /admin/product-reviews/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-035). Aksi dan data pendukung. [`POST /admin/product-reviews/{id}/moderate`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-036).

## Halaman 27

### Live Chat Support

**Route AS-IMPLEMENTED** `/admin/live-chat` · **Aktor saat ini** Super Admin Owner, Admin Kasir. [liveChatSupport.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/liveChatSupport.blade.php)

- Tujuan dan informasi. Daftar percakapan, thread, pesan dan pelanggan.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual.
- Aksi aktual. Pilih thread, kirim, baca pesan baru.
- Jejak target. [UC-47](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-47).
- Validasi dan keadaan kosong. Akses staff dan chat valid. Kosong tampilkan belum ada thread.
- Loading. Tampilkan status memuat thread, serta status kirim per pesan.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Tambahkan status koneksi, pengiriman ulang yang aman dan urutan pesan setelah protokol disepakati.

Sumber data awal. [`GET /admin/live-chat`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-009). Aksi dan data pendukung. [`GET /admin/live-chat/list`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-010), [`POST /admin/live-chat/send`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-011), [`GET /admin/live-chat/{chatId}/messages`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-012).

## Halaman 28

### Notifikasi Sistem

**Route AS-IMPLEMENTED** `/admin/notifications` · **Aktor saat ini** Empat peran admin dengan batas aksi pada Gate. [notifications.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/notifications.blade.php)

- Tujuan dan informasi. Notifikasi sistem dan filter kategori.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Lihat, tandai, hapus atau bersihkan sesuai role.
- Jejak target. [UC-58](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-58).
- Validasi dan keadaan kosong. Rule akses per notifikasi; kosong beri reset pencarian/filter.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Pastikan penayangan sesuai aktor. Hapus admin tetap dibedakan dari UC-59 Customer.

Sumber data awal. [`GET /admin/notifications`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-024). Aksi dan data pendukung. [`POST /admin/notifications/clear-read`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-025), [`POST /admin/notifications/mark-all-read`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-026), [`DELETE /admin/notifications/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-027), [`POST /admin/notifications/{id}/toggle-read`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-028).

## Halaman 29

### Kelola Konten

**Route AS-IMPLEMENTED** `/admin/konten` · **Aktor saat ini** Super Admin Owner. [kontenStatis.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/kontenStatis.blade.php)

- Tujuan dan informasi. Daftar slide, foto, urutan dan konten.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual.
- Aksi aktual. Tambah/edit/hapus slide sesuai hak.
- Jejak target. [UC-60](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-60).
- Validasi dan keadaan kosong. Judul/urutan dan gambar sesuai rule. Kosong beri aksi tambah yang terotorisasi.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Evaluasi pengelolaan konten promosi bersama Kasir/Owner sesuai UC.

Sumber data awal. [`GET /admin/konten`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-004). Aksi dan data pendukung. [`POST /admin/konten/slides/create`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-005), [`POST /admin/konten/slides/{id}/delete`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-006), [`POST /admin/konten/slides/{id}/update`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-007), [`POST /admin/konten/slideshow`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-008).

## Halaman 30

### Laporan Penjualan

**Route AS-IMPLEMENTED** `/admin/sales-report` · **Aktor saat ini** Super Admin Owner, Admin Finance. [salesReport.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/salesReport.blade.php)

- Tujuan dan informasi. Pendapatan, transaksi, periode dan metrik.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Atur periode, tinjau agregat dan unduh CSV.
- Jejak target. [UC-62](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-62).
- Validasi dan keadaan kosong. Parameter periode dan Gate Finance/Owner. Kosong tampilkan tidak ada transaksi periode ini.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Gunakan waktu pembayaran berhasil dan pisahkan nilai refund dari penjualan.

Sumber data awal. [`GET /admin/sales-report`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-044). Aksi dan data pendukung. [`GET /admin/sales-report/export`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-045).

## Halaman 31

### Daftar Member

**Route AS-IMPLEMENTED** `/admin/memberships` · **Aktor saat ini** Super Admin Owner. [index.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/memberships/index.blade.php)

- Tujuan dan informasi. Anggota, tier, saldo poin dan status.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Kelola status, koreksi poin dengan alasan, lihat reward.
- Jejak target. [UC-55](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-55), [UC-57](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-57).
- Validasi dan keadaan kosong. ID member, status dan delta poin sesuai server. Kosong tampilkan belum ada member.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED kebijakan program dan kontrol poin sesuai Kasir/Owner, tampilkan histori koreksi.

Sumber data awal. [`GET /admin/memberships`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-021). Aksi dan data pendukung. [`POST /admin/memberships/{id}/points`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-022), [`POST /admin/memberships/{id}/status`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-023).

## Halaman 32

### Reward Membership

**Route AS-IMPLEMENTED** `/admin/membership-rewards` · **Aktor saat ini** Super Admin Owner. [rewards.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/memberships/rewards.blade.php)

- Tujuan dan informasi. Reward, syarat, biaya poin dan status.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Tambah, edit, hapus/nonaktifkan sesuai fitur.
- Jejak target. [UC-56](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-56).
- Validasi dan keadaan kosong. Akses Owner dan ID. Kosong beri aksi tambah.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Nonaktifkan tanpa hilangkan histori dan sesuaikan izin Kasir/Owner.

Sumber data awal. [`GET /admin/membership-rewards`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-015). Aksi dan data pendukung. [`DELETE /admin/membership-rewards/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-019).

## Halaman 33

### Tambah Reward

**Route AS-IMPLEMENTED** `/admin/membership-rewards/create` · **Aktor saat ini** Super Admin Owner. [rewardForm.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/memberships/rewardForm.blade.php)

- Tujuan dan informasi. Form reward, tipe diskon, poin dan masa aktif.
- Komponen. Form berlabel, ringkasan dan tindakan utama.
- Aksi aktual. Isi lalu simpan reward.
- Jejak target. [UC-56](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-56).
- Validasi dan keadaan kosong. Poin dan nilai diskon batas server, data kosong tampilkan form.
- Loading. Saat submit, tampilkan progres di form dan cegah kirim ganda.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Form satu kolom pada viewport sempit dengan label dan pesan per field. Jaga fokus setelah validasi.
- Rancangan target. Tampilkan batas voucher dan validasi yang sudah disepakati dalam kontrak.

Sumber data awal. [`GET /admin/membership-rewards/create`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-017). Aksi dan data pendukung. [`POST /admin/membership-rewards`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-016).

## Halaman 34

### Ubah Reward

**Route AS-IMPLEMENTED** `/admin/membership-rewards/{id}/edit` · **Aktor saat ini** Super Admin Owner. [rewardForm.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/memberships/rewardForm.blade.php)

- Tujuan dan informasi. Isian reward yang ada.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Ubah data lalu simpan.
- Jejak target. [UC-56](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-56).
- Validasi dan keadaan kosong. ID valid, biaya dan nilai sah. Reward hilang tampilkan keadaan tidak ditemukan.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Form satu kolom pada viewport sempit dengan label dan pesan per field. Jaga fokus setelah validasi.
- Rancangan target. Pertahankan histori penukaran dan tandai aturan yang terpengaruh.

Sumber data awal. [`GET /admin/membership-rewards/{id}/edit`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-020). Aksi dan data pendukung. [`PUT /admin/membership-rewards/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-018).

## Halaman 35

### Broadcast Member

**Route AS-IMPLEMENTED** `/admin/membership-broadcast` · **Aktor saat ini** Super Admin Owner. [broadcast.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/memberships/broadcast.blade.php)

- Tujuan dan informasi. Isi pesan, opsi kanal/audiens saat ini dan pratinjau.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Isi lalu kirim ke member aktif sesuai kontrak.
- Jejak target. [UC-61](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-61).
- Validasi dan keadaan kosong. Pesan dan audiens dari server. Kosong tampilkan form dan jumlah target jika tersedia.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED semua Customer lewat email, konfirmasi jumlah, tampilkan status pemrosesan tanpa klaim penerimaan.

Sumber data awal. [`GET /admin/membership-broadcast`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-013). Aksi dan data pendukung. [`POST /admin/membership-broadcast`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-014).

## Halaman 36

### Supplier

**Route AS-IMPLEMENTED** `/admin/suppliers` · **Aktor saat ini** Super Admin Owner. [index.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/suppliers/index.blade.php)

- Tujuan dan informasi. Kontak supplier, status dan akun terkait.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Tambah, edit, nonaktifkan supplier.
- Jejak target. [UC-28](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-28).
- Validasi dan keadaan kosong. Nama/kontak, status/akun sesuai rule server. Kosong beri opsi tambah.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED pertahankan data supplier bisnis tanpa login; Gudang/Owner mencatat konfirmasi yang diterima di luar sistem.

Sumber data awal. [`GET /admin/suppliers`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-054). Aksi dan data pendukung. [`POST /admin/suppliers`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-055), [`PUT /admin/suppliers/{supplier}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-056), [`DELETE /admin/suppliers/{supplier}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-057).

## Halaman 37

### Pengadaan Stok

**Route AS-IMPLEMENTED** `/admin/stock-procurements` · **Aktor saat ini** Super Admin Owner, Admin Gudang. [index.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/stockProcurements/index.blade.php)

- Tujuan dan informasi. Daftar pengadaan, jumlah item, status dan statistik.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual.
- Aksi aktual. Filter, buat, buka detail.
- Jejak target. [UC-29](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-29), [UC-31](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-31), [UC-64](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-64).
- Validasi dan keadaan kosong. Status/gate. Kosong tawarkan reset filter atau buat sesuai izin.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. Tambah akses laporan pengadaan serta jejak versi dan status PO.

Sumber data awal. [`GET /admin/stock-procurements`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-048).

## Halaman 38

### Buat Pengadaan

**Route AS-IMPLEMENTED** `/admin/stock-procurements/create` · **Aktor saat ini** Super Admin Owner, Admin Gudang. [create.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/stockProcurements/create.blade.php)

- Tujuan dan informasi. Supplier, item produk, ukuran dan jumlah.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Pilih supplier, pilih varian/qty, simpan.
- Jejak target. [UC-29](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-29), [UC-30](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-30).
- Validasi dan keadaan kosong. Supplier aktif, item unik/qty sah. Kosong pemasok/produk tampilkan petunjuk mengisi data acuan.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Form satu kolom pada viewport sempit dengan label dan pesan per field. Jaga fokus setelah validasi.
- Rancangan target. PROPOSED dukung metadata PO/biaya modal dan aksi hasilkan/unduh setelah tersimpan.

Sumber data awal. [`GET /admin/stock-procurements/create`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-050). Aksi dan data pendukung. [`POST /admin/stock-procurements`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-049).

## Halaman 39

### Detail Pengadaan

**Route AS-IMPLEMENTED** `/admin/stock-procurements/{stockProcurement}` · **Aktor saat ini** Super Admin Owner, Admin Gudang. [show.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/stockProcurements/show.blade.php)

- Tujuan dan informasi. Rincian PO aktual, barang, supplier, status dan timestamp.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Konfirmasi sampai dan terapkan stok sesuai status.
- Jejak target. [UC-30](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-30), [UC-31](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-31), [UC-32](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-32), [UC-33](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-33), [UC-64](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-64).
- Validasi dan keadaan kosong. Owner/Gudang, status sah dan jumlah item valid. Not found bila ID tidak sah.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Perlihatkan pesan validasi/status terbaru. Segarkan data jika aksi tidak sah atau sesi/draft kedaluwarsa. Cegah pengulangan mutasi tanpa mengetahui hasil.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED tambah dokumen PO, konfirmasi eksternal, batch penerimaan parsial dan rincian posting mutasi.

Sumber data awal. [`GET /admin/stock-procurements/{stockProcurement}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-051). Aksi dan data pendukung. [`POST /admin/stock-procurements/{stockProcurement}/apply-stock`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-052), [`POST /admin/stock-procurements/{stockProcurement}/confirm-arrived`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-053).

## Halaman 40

### Gudang

**Route AS-IMPLEMENTED** `/admin/warehouse` · **Aktor saat ini** Super Admin Owner, Admin Gudang. [index.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/warehouse/index.blade.php)

- Tujuan dan informasi. Matriks stok sistem/stock fisik, penerimaan dan mutasi tersedia.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual.
- Aksi aktual. Periksa stok, buka detail pengadaan atau langkah stok.
- Jejak target. [UC-34](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-34), [UC-35](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-35), [UC-38](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-38), [UC-63](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-63).
- Validasi dan keadaan kosong. Akses Gudang/Owner. Kosong tampilkan belum ada stok atau mutasi.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED filter riwayat, pencatatan barang masuk/keluar dan laporan persediaan sesuai kontrak.

Sumber data awal. [`GET /admin/warehouse`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-058). Aksi dan data pendukung. [`POST /admin/stock-procurements/{stockProcurement}/apply-stock`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-052), [`POST /admin/stock-procurements/{stockProcurement}/confirm-arrived`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-053).

## Halaman 41

### Stock Opname

**Route AS-IMPLEMENTED** `/admin/stock-opname` · **Aktor saat ini** Super Admin Owner, Admin Gudang. [index.blade.php](../../../../Motifnesia-Client-Web/resources/views/admin/pages/stockOpname/index.blade.php)

- Tujuan dan informasi. Matriks selisih stok per varian.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual.
- Aksi aktual. Buka item, sesuaikan stok dan beri catatan.
- Jejak target. [UC-36](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-36), [UC-37](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-37), [UC-63](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-63).
- Validasi dan keadaan kosong. Validasi varian dan role. Kosong tampilkan belum ada produk untuk diperiksa.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Perlihatkan pesan validasi/status terbaru. Segarkan data jika aksi tidak sah atau sesi/draft kedaluwarsa. Cegah pengulangan mutasi tanpa mengetahui hasil.
- Responsivitas dan perilaku UI. Sidebar dan tabel pada layar lebar. Pada layar sempit gunakan tabel yang dapat digulir atau kartu dengan aksi berlabel.
- Rancangan target. PROPOSED pisahkan sesi penghitungan fisik, konfirmasi selisih, catatan perubahan dan ekspor bila disetujui.

Sumber data awal. [`GET /admin/stock-opname`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-046). Aksi dan data pendukung. [`POST /admin/stock-opname/adjust`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-047).
