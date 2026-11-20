# Publik dan Customer · Client Mobile

Data, aksi dan route awal berasal dari kode. Panduan keadaan layar dan responsivitas memberi kriteria desain. Rancangan target mengikuti skenario dan menunggu penyelarasan kontrak untuk gap. [Indeks](README.md)

## Layar 04

### Koleksi Batik

**Route AS-IMPLEMENTED** `/homePage` · **Aktor saat ini** Guest, Customer · API katalog menolak /homePage untuk admin. [catalog_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/catalog/catalog_page.dart)

- Tujuan dan informasi. Slide, katalog, filter dan varian tersedia.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Cari/filter produk, pilih kartu, buka detail.
- Jejak target. [UC-09](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-09), [UC-10](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-10), [UC-11](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-11), [UC-48](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-48).
- Validasi dan keadaan kosong. Query sesuai kategori/filter; kosong tampilkan hasil nol dan reset filter.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Grid adaptif, filter/dialog dan target sentuh. Pertahankan varian terpilih selama layar aktif.
- Rancangan target. Pertahankan katalog publik. Tampilan stok mengambil data server, tidak diputuskan di client.

Sumber data awal. [`GET /homePage`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-077).

## Layar 05

### Detail Produk

**Route AS-IMPLEMENTED** `/products/:id` · **Aktor saat ini** Guest, Customer · API katalog menolak /homePage untuk admin. [product_detail_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/catalog/product_detail_page.dart)

- Tujuan dan informasi. Detail, harga, stok, gambar, rating dan deskripsi motif.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Pilih ukuran, tambah keranjang/favorit, tanya admin, lihat ulasan.
- Jejak target. [UC-11](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-11), [UC-14](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-14), [UC-47](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-47), [UC-48](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-48), [UC-50](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-50).
- Validasi dan keadaan kosong. Varian dan jumlah harus tersedia. Ulasan kosong tampilkan ajakan yang sesuai hak akses.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Grid adaptif, filter/dialog dan target sentuh. Pertahankan varian terpilih selama layar aktif.
- Rancangan target. Tampilkan ulasan yang dipublikasikan. Akses aksi transaksi dan chat melalui login.

Sumber data awal. [`GET /products/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-096). Aksi dan data pendukung. [`POST /cart/add`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-060), [`POST /chat/product/{productId}/ask`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-066), [`POST /favorites/store`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-073).

## Layar 06

### Keranjang

**Route AS-IMPLEMENTED** `/cart` · **Aktor saat ini** Customer. [cart_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/cart_page.dart)

- Tujuan dan informasi. Item, varian, kuantitas, subtotal, pilihan checkout.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Atur jumlah, pilih item, hapus, lanjut checkout.
- Jejak target. [UC-14](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-14), [UC-16](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-16).
- Validasi dan keadaan kosong. Pilih item yang dimiliki, jumlah positif dan stok cukup. Kosong tampilkan tautan katalog.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Perbarui nilai dari respons server serta tangani stok berubah sebelum checkout.

Sumber data awal. [`GET /cart`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-059). Aksi dan data pendukung. [`POST /cart/checkout`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-061), [`POST /cart/update`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-062), [`DELETE /cart/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-063).

## Layar 07

### Favorit

**Route AS-IMPLEMENTED** `/favorites` · **Aktor saat ini** Customer. [favorites_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/favorites_page.dart)

- Tujuan dan informasi. Produk yang disimpan, harga dan stok.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Hapus favorit, pindahkan/tambahkan item ke cart, buka produk.
- Jejak target. [UC-48](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-48).
- Validasi dan keadaan kosong. Data milik Customer, pilihan harus masih berlaku. Kosong arahkan ke katalog.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Grid adaptif, filter/dialog dan target sentuh. Pertahankan varian terpilih selama layar aktif.
- Rancangan target. Pertahankan satu sumber data favorit per akun.

Sumber data awal. [`GET /favorites`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-072). Aksi dan data pendukung. [`DELETE /favorites/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-074), [`POST /favorites/{id}/add-to-cart`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-075).

## Layar 08

### Checkout

**Route AS-IMPLEMENTED** `/checkout` · **Aktor saat ini** Customer. [checkout_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/checkout/checkout_page.dart)

- Tujuan dan informasi. Alamat, metode kirim/bayar, item, voucher, total.
- Komponen. Form berlabel, ringkasan dan tindakan utama dengan kontrol sentuh Material.
- Aksi aktual. Pilih alamat dan metode, isi voucher, lanjut.
- Jejak target. [UC-15](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-15), [UC-16](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-16).
- Validasi dan keadaan kosong. Server validasi alamat, metode, keranjang, voucher dan stok. Draft kosong kembali ke cart.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Perlihatkan pesan validasi/status terbaru. Segarkan data jika aksi tidak sah atau sesi/draft kedaluwarsa. Cegah pengulangan mutasi tanpa mengetahui hasil.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. PROPOSED buat order dan reservasi pada submit checkout, tampilkan tenggat dan data hasil server.

Sumber data awal. [`GET /checkout`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-070). Aksi dan data pendukung. [`POST /checkout/store`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-071).

## Layar 09

### Pembayaran

**Route AS-IMPLEMENTED** `/payment` · **Aktor saat ini** Customer. [payment_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/checkout/payment_page.dart)

- Tujuan dan informasi. Nama metode, rekening atau instruksi, tenggat dan total.
- Komponen. Form berlabel, ringkasan dan tindakan utama dengan kontrol sentuh Material.
- Aksi aktual. Isi nomor pembayaran dan unggah bukti, lanjut ke ringkasan.
- Jejak target. [UC-16](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-16), [UC-20](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-20), [UC-23](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-23).
- Validasi dan keadaan kosong. Bukti gambar dan nomor sesuai rule server. Draft hilang/kedaluwarsa arahkan ke checkout.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Perlihatkan pesan validasi/status terbaru. Segarkan data jika aksi tidak sah atau sesi/draft kedaluwarsa. Cegah pengulangan mutasi tanpa mengetahui hasil.
- Responsivitas dan perilaku UI. Form scroll satu kolom, keyboard sesuai field, tombol utama tetap terjangkau dan area aman sistem dihormati.
- Rancangan target. PROPOSED instruksi gateway dan status hasil. Callback milik server. Jangan tampilkan sukses sebelum server konfirmasi.

Sumber data awal. [`GET /payment`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-091). Aksi dan data pendukung. [`POST /payment/store`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-092).

## Layar 10

### Ringkasan Pesanan

**Route AS-IMPLEMENTED** `/transaction/success/:id` · **Aktor saat ini** Customer. [order_receipt_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/checkout/order_receipt_page.dart)

- Tujuan dan informasi. Ringkasan order, item, total, status bayar dan kirim.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Lihat profil atau riwayat, tinjau rincian pesanan.
- Jejak target. [UC-18](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-18), [UC-23](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-23), [UC-26](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-26).
- Validasi dan keadaan kosong. Order milik Customer. Status belum tersedia tampilkan informasi yang diketahui server.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Judul mengikuti status riil. Tampilkan resi dan rincian pembayaran begitu kontrak mendukungnya.

Sumber data awal. [`GET /transaction/success/{orderId}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-116).

## Layar 11

### Akun Saya

**Route AS-IMPLEMENTED** `/profile` · **Aktor saat ini** Customer. [profile_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/profile/profile_page.dart)

- Tujuan dan informasi. Identitas, alamat, histori pesanan dan item, kelayakan retur/ulasan.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Kelola alamat, buka edit, pilih order, konfirmasi tiba, tambah/lihat ulasan dan buka retur.
- Jejak target. [UC-05](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-05), [UC-15](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-15), [UC-17](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-17), [UC-18](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-18), [UC-26](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-26), [UC-27](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-27), [UC-39](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-39), [UC-49](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-49).
- Validasi dan keadaan kosong. Alamat/order/item milik akun, validasi aksi per status. Tiap bagian kosong diberi pesan.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Pisahkan histori panjang ke bagian atau halaman detail apabila diperlukan; ambil izin tindakan dari respons server.

Sumber data awal. [`GET /profile`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-098). Aksi dan data pendukung. [`POST /profile/addresses`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-099), [`DELETE /profile/addresses/{id}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-100), [`POST /profile/addresses/{id}/set-primary`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-101), [`POST /profile/addresses/{id}/update`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-102), [`POST /order-reviews`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-088), [`GET /order-reviews/{orderItemId}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-089), [`POST /orders/{order}/confirm-arrived`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-090).

## Layar 12

### Ubah Profil

**Route AS-IMPLEMENTED** `/profile/edit` · **Aktor saat ini** Customer. [edit_profile_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/profile/edit_profile_page.dart)

- Tujuan dan informasi. Data profil dan foto.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Ubah data, pilih foto, simpan.
- Jejak target. [UC-06](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-06).
- Validasi dan keadaan kosong. Format kontak dan foto sesuai server. Profil kosong tampilkan nilai awal yang tersedia.
- Loading. Saat submit, tampilkan progres di form dan cegah kirim ganda.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Form scroll satu kolom, keyboard sesuai field, tombol utama tetap terjangkau dan area aman sistem dihormati.
- Rancangan target. Pertahankan perubahan lokal setelah validasi gagal sebatas data yang boleh dipulihkan.

Sumber data awal. [`GET /profile/edit`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-103). Aksi dan data pendukung. [`POST /profile/edit`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-104).

## Layar 13

### Notifikasi

**Route AS-IMPLEMENTED** `/notifications` · **Aktor saat ini** Customer. [notifications_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/notifications_page.dart)

- Tujuan dan informasi. Daftar notifikasi dan status dibaca.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual dengan kontrol sentuh Material.
- Aksi aktual. Buka tautan, tandai dibaca atau semua dibaca.
- Jejak target. [UC-58](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-58), [UC-59](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-59).
- Validasi dan keadaan kosong. Tautan internal dan kepemilikan. Kosong tampilkan belum ada notifikasi.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. PROPOSED tambah hapus milik Customer dan refresh daftar setelah konfirmasi server.

Sumber data awal. [`GET /notifications`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-085). Aksi dan data pendukung. [`POST /notifications/mark-all-read`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-086), [`POST /notifications/{id}/read`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-087).

## Layar 14

### Membership

**Route AS-IMPLEMENTED** `/membership` · **Aktor saat ini** Customer. [membership_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/membership/membership_page.dart)

- Tujuan dan informasi. Tier, poin, daftar reward dan status member.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Daftar member, pilih dan tukarkan reward.
- Jejak target. [UC-52](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-52), [UC-53](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-53), [UC-54](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-54).
- Validasi dan keadaan kosong. Syarat reward, saldo, dan akun dari backend. Kosong tampilkan belum ada reward.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Tampilkan hasil penukaran dan voucher yang diterbitkan server.

Sumber data awal. [`GET /membership`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-080). Aksi dan data pendukung. [`POST /membership/redeem/{reward}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-082), [`POST /membership/register`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-083).

## Layar 15

### Riwayat Poin

**Route AS-IMPLEMENTED** `/membership/history` · **Aktor saat ini** Customer. [points_history_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/membership/points_history_page.dart)

- Tujuan dan informasi. Saldo, buku transaksi poin, jenis dan tanggal.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Lihat histori dan berpindah halaman.
- Jejak target. [UC-52](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-52).
- Validasi dan keadaan kosong. Akses pengguna sendiri. Kosong tampilkan belum ada perubahan poin.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Tampilkan sumber transaksi earn/redeem/reversal yang tersedia dalam ledger.

Sumber data awal. [`GET /membership/history`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-081).

## Layar 16

### Voucher Saya

**Route AS-IMPLEMENTED** `/membership/vouchers` · **Aktor saat ini** Customer. [vouchers_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/membership/vouchers_page.dart)

- Tujuan dan informasi. Voucher dan status, masa berlaku, diskon.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Lihat kode dan aturan pakai, kembali belanja.
- Jejak target. [UC-52](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-52), [UC-54](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-54).
- Validasi dan keadaan kosong. Voucher akun aktif sesuai server. Kosong arahkan ke daftar reward.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Status penggunaan dan kedaluwarsa selalu mengikuti respons backend.

Sumber data awal. [`GET /membership/vouchers`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-084).

## Layar 17

### Retur Saya

**Route AS-IMPLEMENTED** `/returns` · **Aktor saat ini** Customer. [returns_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/returns/returns_page.dart)

- Tujuan dan informasi. Daftar retur, bukti, status pemeriksaan/refund.
- Komponen. Daftar atau matriks, filter bila tersedia, dan aksi kontekstual dengan kontrol sentuh Material.
- Aksi aktual. Lihat bukti, batal bila sah, unggah bukti serah kurir.
- Jejak target. [UC-40](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-40), [UC-46](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-46).
- Validasi dan keadaan kosong. Bukti dan status milik Customer. Kosong beri tautan riwayat pesanan.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Tambahkan ringkasan resolusi dan timeline refund yang diketahui, dengan kontrol bukti privat.

Sumber data awal. [`GET /returns`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-106). Aksi dan data pendukung. [`PATCH /returns/{id}/cancel`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-109), [`POST /returns/{id}/courier-proof`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-110), [`GET /returns/{return}/proof/{kind}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-111).

## Layar 18

### Ajukan Retur

**Route AS-IMPLEMENTED** `/returns/create/:id` · **Aktor saat ini** Customer. [create_return_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/returns/create_return_page.dart)

- Tujuan dan informasi. Item pesanan, alasan, tindakan, bukti foto.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Isi form, pilih bukti, kirim pengajuan.
- Jejak target. [UC-39](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-39).
- Validasi dan keadaan kosong. Validasi kuantitas/kepemilikan, kelayakan/waktu, file. Item tidak memenuhi syarat tampilkan alasan.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Form scroll satu kolom, keyboard sesuai field, tombol utama tetap terjangkau dan area aman sistem dihormati.
- Rancangan target. PROPOSED dukung foto atau video setelah batas upload diputus, arahkan ke detail retur sukses.

Sumber data awal. [`GET /returns/create/{orderItemId}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-108). Aksi dan data pendukung. [`POST /returns`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-107).

## Layar 19

### Bantuan & Chat

**Route AS-IMPLEMENTED** `/chat` · **Aktor saat ini** Customer. [chat_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/chat_page.dart)

- Tujuan dan informasi. Thread, pesan, waktu dan identitas tampilan.
- Komponen. Daftar thread, panel pesan, dan input dengan kontrol sentuh Material.
- Aksi aktual. Mulai, kirim pesan, refresh dan tutup thread.
- Jejak target. [UC-47](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-47).
- Validasi dan keadaan kosong. Akses peserta, body dan status chat valid. Kosong tampilkan mulai percakapan.
- Loading. Tampilkan status memuat thread, serta status kirim per pesan.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Jalankan transport yang disetujui untuk real-time dan tampilkan reconnect tanpa kehilangan draf.

Sumber data awal. [`GET /chat`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-064). Aksi dan data pendukung. [`POST /chat/get-or-create`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-065), [`POST /chat/send`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-067), [`POST /chat/{chatId}/close`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-068), [`GET /chat/{chatId}/messages`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-069).
