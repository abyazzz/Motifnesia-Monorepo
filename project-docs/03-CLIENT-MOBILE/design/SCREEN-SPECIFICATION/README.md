# Spesifikasi layar Client Mobile

Indeks memetakan 43 layar aktual ke role, UC, aksi, API, sumber implementasi, keadaan UI dan penyesuaian target. UC yang baru memerlukan keputusan akses platform dan kontrak Server. [Rancangan fitur baru](TARGET.md)

| Area | Layar | Route saat ini | Akses awal | Use Case |
| --- | --- | --- | --- | --- |
| auth | [Masuk](auth.md#layar-01) | `/login` | Guest / sesi anonim | UC-01 |
| auth | [Daftar Akun](auth.md#layar-02) | `/register` | Guest / sesi anonim | UC-02 |
| auth | [Atur Ulang Sandi](auth.md#layar-03) | `/forgot` | Guest / sesi anonim | UC-03 |
| customer | [Koleksi Batik](customer.md#layar-04) | `/homePage` | Guest, Customer · API katalog menolak /homePage untuk admin | UC-09, UC-10, UC-11, UC-48 |
| customer | [Detail Produk](customer.md#layar-05) | `/products/:id` | Guest, Customer · API katalog menolak /homePage untuk admin | UC-11, UC-14, UC-47, UC-48, UC-50 |
| customer | [Keranjang](customer.md#layar-06) | `/cart` | Customer | UC-14, UC-16 |
| customer | [Favorit](customer.md#layar-07) | `/favorites` | Customer | UC-48 |
| customer | [Checkout](customer.md#layar-08) | `/checkout` | Customer | UC-15, UC-16 |
| customer | [Pembayaran](customer.md#layar-09) | `/payment` | Customer | UC-16, UC-20, UC-23 |
| customer | [Ringkasan Pesanan](customer.md#layar-10) | `/transaction/success/:id` | Customer | UC-18, UC-23, UC-26 |
| customer | [Akun Saya](customer.md#layar-11) | `/profile` | Customer | UC-05, UC-15, UC-17, UC-18, UC-26, UC-27, UC-39, UC-49 |
| customer | [Ubah Profil](customer.md#layar-12) | `/profile/edit` | Customer | UC-06 |
| customer | [Notifikasi](customer.md#layar-13) | `/notifications` | Customer | UC-58, UC-59 |
| customer | [Membership](customer.md#layar-14) | `/membership` | Customer | UC-52, UC-53, UC-54 |
| customer | [Riwayat Poin](customer.md#layar-15) | `/membership/history` | Customer | UC-52 |
| customer | [Voucher Saya](customer.md#layar-16) | `/membership/vouchers` | Customer | UC-52, UC-54 |
| customer | [Retur Saya](customer.md#layar-17) | `/returns` | Customer | UC-40, UC-46 |
| customer | [Ajukan Retur](customer.md#layar-18) | `/returns/create/:id` | Customer | UC-39 |
| customer | [Bantuan & Chat](customer.md#layar-19) | `/chat` | Customer | UC-47 |
| admin | [Manajemen Produk](admin.md#layar-20) | `/admin/product-management` | Super Admin Owner, Admin Kasir | UC-13 |
| admin | [Tambah Produk](admin.md#layar-21) | `/admin/products/create` | Super Admin Owner | UC-12 |
| admin | [Status Pengiriman](admin.md#layar-22) | `/admin/order-status` | Empat peran admin dengan batas aksi pada Gate | UC-19, UC-23, UC-24, UC-25 |
| admin | [Daftar Pelanggan](admin.md#layar-23) | `/admin/customers` | Super Admin Owner | UC-08 |
| admin | [Kelola Retur](admin.md#layar-24) | `/admin/returns` | Super Admin Owner, Admin Kasir | UC-41, UC-42, UC-43, UC-44, UC-45 |
| admin | [Ulasan Produk](admin.md#layar-25) | `/admin/product-reviews` | Super Admin Owner, Admin Kasir | UC-51 |
| admin | [Detail Ulasan](admin.md#layar-26) | `/admin/product-reviews/:id` | Super Admin Owner, Admin Kasir | UC-51 |
| admin | [Live Chat Support](admin.md#layar-27) | `/admin/live-chat` | Super Admin Owner, Admin Kasir | UC-47 |
| admin | [Notifikasi Sistem](admin.md#layar-28) | `/admin/notifications` | Empat peran admin dengan batas aksi pada Gate | UC-58 |
| admin | [Kelola Konten](admin.md#layar-29) | `/admin/konten` | Super Admin Owner | UC-60 |
| admin | [Laporan Penjualan](admin.md#layar-30) | `/admin/sales-report` | Super Admin Owner, Admin Finance | UC-62 |
| admin | [Daftar Member](admin.md#layar-31) | `/admin/memberships` | Super Admin Owner | UC-55, UC-57 |
| admin | [Reward Membership](admin.md#layar-32) | `/admin/membership-rewards` | Super Admin Owner | UC-56 |
| admin | [Tambah Reward](admin.md#layar-33) | `/admin/membership-rewards/create` | Super Admin Owner | UC-56 |
| admin | [Ubah Reward](admin.md#layar-34) | `/admin/membership-rewards/:id/edit` | Super Admin Owner | UC-56 |
| admin | [Broadcast Member](admin.md#layar-35) | `/admin/membership-broadcast` | Super Admin Owner | UC-61 |
| admin | [Supplier](admin.md#layar-36) | `/admin/suppliers` | Super Admin Owner | UC-28 |
| admin | [Pengadaan Stok](admin.md#layar-37) | `/admin/stock-procurements` | Super Admin Owner, Admin Gudang | UC-29, UC-31, UC-64 |
| admin | [Buat Pengadaan](admin.md#layar-38) | `/admin/stock-procurements/create` | Super Admin Owner, Admin Gudang | UC-29, UC-30 |
| admin | [Detail Pengadaan](admin.md#layar-39) | `/admin/stock-procurements/:id` | Super Admin Owner, Admin Gudang | UC-30, UC-31, UC-32, UC-33, UC-64 |
| admin | [Gudang](admin.md#layar-40) | `/admin/warehouse` | Super Admin Owner, Admin Gudang | UC-34, UC-35, UC-38, UC-63 |
| admin | [Stock Opname](admin.md#layar-41) | `/admin/stock-opname` | Super Admin Owner, Admin Gudang | UC-36, UC-37, UC-63 |
| supplier | [Pengadaan Supplier](supplier.md#layar-42) | `/supplier/procurements` | Supplier | UC-31, UC-32 |
| supplier | [Detail Pengadaan](supplier.md#layar-43) | `/supplier/procurements/:id` | Supplier | UC-32 |
