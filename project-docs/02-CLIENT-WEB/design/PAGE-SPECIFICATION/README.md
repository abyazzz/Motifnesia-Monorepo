# Spesifikasi halaman Client Web

Indeks memetakan 43 halaman aktual ke role, UC, aksi, API, sumber implementasi, keadaan UI dan penyesuaian target. UC yang baru memerlukan keputusan akses platform dan kontrak Server. [Rancangan fitur baru](TARGET.md)

| Area | Halaman | Route saat ini | Akses awal | Use Case |
| --- | --- | --- | --- | --- |
| auth | [Masuk](auth.md#halaman-01) | `/login` | Guest / sesi anonim | UC-01 |
| auth | [Daftar Akun](auth.md#halaman-02) | `/register` | Guest / sesi anonim | UC-02 |
| auth | [Atur Ulang Sandi](auth.md#halaman-03) | `/forgot` | Guest / sesi anonim | UC-03 |
| customer | [Koleksi Batik](customer.md#halaman-04) | `/homePage` | Guest, Customer · API katalog menolak /homePage untuk admin | UC-09, UC-10, UC-11, UC-48 |
| customer | [Detail Produk](customer.md#halaman-05) | `/products/{id}` | Guest, Customer · API katalog menolak /homePage untuk admin | UC-11, UC-14, UC-47, UC-48, UC-50 |
| customer | [Keranjang](customer.md#halaman-06) | `/cart` | Customer | UC-14, UC-16 |
| customer | [Favorit](customer.md#halaman-07) | `/favorites` | Customer | UC-48 |
| customer | [Checkout](customer.md#halaman-08) | `/checkout` | Customer | UC-15, UC-16 |
| customer | [Pembayaran](customer.md#halaman-09) | `/payment` | Customer | UC-16, UC-20, UC-23 |
| customer | [Ringkasan Pesanan](customer.md#halaman-10) | `/transaction/success/{orderId}` | Customer | UC-18, UC-23, UC-26 |
| customer | [Akun Saya](customer.md#halaman-11) | `/profile` | Customer | UC-05, UC-15, UC-17, UC-18, UC-26, UC-27, UC-39, UC-49 |
| customer | [Ubah Profil](customer.md#halaman-12) | `/profile/edit` | Customer | UC-06 |
| customer | [Notifikasi](customer.md#halaman-13) | `/notifications` | Customer | UC-58, UC-59 |
| customer | [Membership](customer.md#halaman-14) | `/membership` | Customer | UC-52, UC-53, UC-54 |
| customer | [Riwayat Poin](customer.md#halaman-15) | `/membership/history` | Customer | UC-52 |
| customer | [Voucher Saya](customer.md#halaman-16) | `/membership/vouchers` | Customer | UC-52, UC-54 |
| customer | [Retur Saya](customer.md#halaman-17) | `/returns` | Customer | UC-40, UC-46 |
| customer | [Ajukan Retur](customer.md#halaman-18) | `/returns/create/{orderItemId}` | Customer | UC-39 |
| customer | [Bantuan & Chat](customer.md#halaman-19) | `/chat` | Customer | UC-47 |
| admin | [Manajemen Produk](admin.md#halaman-20) | `/admin/product-management` | Super Admin Owner, Admin Kasir | UC-13 |
| admin | [Tambah Produk](admin.md#halaman-21) | `/admin/products/create` | Super Admin Owner | UC-12 |
| admin | [Status Pengiriman](admin.md#halaman-22) | `/admin/order-status` | Empat peran admin dengan batas aksi pada Gate | UC-19, UC-23, UC-24, UC-25 |
| admin | [Daftar Pelanggan](admin.md#halaman-23) | `/admin/customers` | Super Admin Owner | UC-08 |
| admin | [Kelola Retur](admin.md#halaman-24) | `/admin/returns` | Super Admin Owner, Admin Kasir | UC-41, UC-42, UC-43, UC-44, UC-45 |
| admin | [Ulasan Produk](admin.md#halaman-25) | `/admin/product-reviews` | Super Admin Owner, Admin Kasir | UC-51 |
| admin | [Detail Ulasan](admin.md#halaman-26) | `/admin/product-reviews/{id}` | Super Admin Owner, Admin Kasir | UC-51 |
| admin | [Live Chat Support](admin.md#halaman-27) | `/admin/live-chat` | Super Admin Owner, Admin Kasir | UC-47 |
| admin | [Notifikasi Sistem](admin.md#halaman-28) | `/admin/notifications` | Empat peran admin dengan batas aksi pada Gate | UC-58 |
| admin | [Kelola Konten](admin.md#halaman-29) | `/admin/konten` | Super Admin Owner | UC-60 |
| admin | [Laporan Penjualan](admin.md#halaman-30) | `/admin/sales-report` | Super Admin Owner, Admin Finance | UC-62 |
| admin | [Daftar Member](admin.md#halaman-31) | `/admin/memberships` | Super Admin Owner | UC-55, UC-57 |
| admin | [Reward Membership](admin.md#halaman-32) | `/admin/membership-rewards` | Super Admin Owner | UC-56 |
| admin | [Tambah Reward](admin.md#halaman-33) | `/admin/membership-rewards/create` | Super Admin Owner | UC-56 |
| admin | [Ubah Reward](admin.md#halaman-34) | `/admin/membership-rewards/{id}/edit` | Super Admin Owner | UC-56 |
| admin | [Broadcast Member](admin.md#halaman-35) | `/admin/membership-broadcast` | Super Admin Owner | UC-61 |
| admin | [Supplier](admin.md#halaman-36) | `/admin/suppliers` | Super Admin Owner | UC-28 |
| admin | [Pengadaan Stok](admin.md#halaman-37) | `/admin/stock-procurements` | Super Admin Owner, Admin Gudang | UC-29, UC-31, UC-64 |
| admin | [Buat Pengadaan](admin.md#halaman-38) | `/admin/stock-procurements/create` | Super Admin Owner, Admin Gudang | UC-29, UC-30 |
| admin | [Detail Pengadaan](admin.md#halaman-39) | `/admin/stock-procurements/{stockProcurement}` | Super Admin Owner, Admin Gudang | UC-30, UC-31, UC-32, UC-33, UC-64 |
| admin | [Gudang](admin.md#halaman-40) | `/admin/warehouse` | Super Admin Owner, Admin Gudang | UC-34, UC-35, UC-38, UC-63 |
| admin | [Stock Opname](admin.md#halaman-41) | `/admin/stock-opname` | Super Admin Owner, Admin Gudang | UC-36, UC-37, UC-63 |
| supplier | [Pengadaan Supplier](supplier.md#halaman-42) | `/supplier/procurements` | Supplier | UC-31, UC-32 |
| supplier | [Detail Pengadaan](supplier.md#halaman-43) | `/supplier/procurements/{procurement}` | Supplier | UC-32 |
