# Indeks proses TO-BE TARGET

Tujuh proses dan 19 alur berasal dari TO-BE revisi dan TA §2.3. Tabel menyajikan aktor dan keterkaitan yang muncul persis di awal alur TA. KF/UC dapat mencakup lebih dari satu alur. Fungsi lintas proses, seperti autentikasi dan notifikasi, tetap tercatat pada traceability. [TO-BE revisi](references/PERANCANGAN%20FINAL%20PROSES%20BISNIS%20TO-BE%20MOTIFNESIA.md) · [TA 64 UC](references/Muhammad%20Abyaz%20Zaydan-Tugas%20Akhir_Lengkap_64_Use_Case.docx)

| Proses | Nama | Alur |
| --- | --- | --- |
| 2.3.1 | Pengelolaan Katalog Produk | 2 |
| 2.3.2 | Pengelolaan Pengadaan dan Persediaan Produk | 4 |
| 2.3.3 | Pemesanan dan Pengelolaan Transaksi | 3 |
| 2.3.4 | Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual | 3 |
| 2.3.5 | Pengelolaan Informasi Penjualan dan Laporan | 1 |
| 2.3.6 | Pengelolaan Membership dan Promosi Pelanggan | 3 |
| 2.3.7 | Pengelolaan Interaksi dan Preferensi Pelanggan | 3 |

| Subalur | Nama | Aktor | KF | Use Case |
| --- | --- | --- | --- | --- |
| 2.3.1.1 | Pengelolaan Data Produk | Admin Gudang, Super Admin Owner | KF-01 | [UC-12](TRACEABILITY-MATRIX.md#uc-12), [UC-13](TRACEABILITY-MATRIX.md#uc-13) |
| 2.3.1.2 | Penelusuran Katalog Produk | Guest, Customer | KF-01, KF-02 | [UC-09](TRACEABILITY-MATRIX.md#uc-09), [UC-10](TRACEABILITY-MATRIX.md#uc-10), [UC-11](TRACEABILITY-MATRIX.md#uc-11) |
| 2.3.2.1 | Pengelolaan Data Supplier dan Pengadaan | Admin Gudang, Super Admin Owner. Supplier sebagai pihak eksternal | KF-09 | [UC-28](TRACEABILITY-MATRIX.md#uc-28), [UC-29](TRACEABILITY-MATRIX.md#uc-29), [UC-30](TRACEABILITY-MATRIX.md#uc-30), [UC-31](TRACEABILITY-MATRIX.md#uc-31), [UC-32](TRACEABILITY-MATRIX.md#uc-32) |
| 2.3.2.2 | Pencatatan Penerimaan Barang | Admin Gudang, Super Admin Owner. Supplier sebagai pihak eksternal | KF-03, KF-09 | [UC-33](TRACEABILITY-MATRIX.md#uc-33) |
| 2.3.2.3 | Pengelolaan Pergerakan Persediaan | Admin Gudang, Super Admin Owner | KF-03 | [UC-34](TRACEABILITY-MATRIX.md#uc-34), [UC-35](TRACEABILITY-MATRIX.md#uc-35), [UC-38](TRACEABILITY-MATRIX.md#uc-38) |
| 2.3.2.4 | Stock Opname dan Pelaporan Persediaan | Admin Gudang, Super Admin Owner | KF-03, KF-09 | [UC-36](TRACEABILITY-MATRIX.md#uc-36), [UC-37](TRACEABILITY-MATRIX.md#uc-37), [UC-38](TRACEABILITY-MATRIX.md#uc-38), [UC-63](TRACEABILITY-MATRIX.md#uc-63), [UC-64](TRACEABILITY-MATRIX.md#uc-64) |
| 2.3.3.1 | Pemesanan Produk oleh Customer | Customer | KF-03, KF-04, KF-11 | [UC-14](TRACEABILITY-MATRIX.md#uc-14), [UC-15](TRACEABILITY-MATRIX.md#uc-15), [UC-16](TRACEABILITY-MATRIX.md#uc-16) |
| 2.3.3.2 | Pembayaran melalui Payment Gateway | Customer, Payment Gateway | KF-05 | [UC-20](TRACEABILITY-MATRIX.md#uc-20), [UC-21](TRACEABILITY-MATRIX.md#uc-21), [UC-22](TRACEABILITY-MATRIX.md#uc-22) |
| 2.3.3.3 | Pengelolaan dan Pemantauan Pesanan | Customer, Admin Kasir, Super Admin Owner, Admin Finance | KF-03, KF-04, KF-05, KF-16 | [UC-17](TRACEABILITY-MATRIX.md#uc-17), [UC-18](TRACEABILITY-MATRIX.md#uc-18), [UC-19](TRACEABILITY-MATRIX.md#uc-19), [UC-23](TRACEABILITY-MATRIX.md#uc-23) |
| 2.3.4.1 | Pemenuhan dan Pengiriman Pesanan | Admin Gudang, Customer. Jasa pengiriman sebagai pihak eksternal | KF-03, KF-06 | [UC-24](TRACEABILITY-MATRIX.md#uc-24), [UC-25](TRACEABILITY-MATRIX.md#uc-25), [UC-26](TRACEABILITY-MATRIX.md#uc-26), [UC-27](TRACEABILITY-MATRIX.md#uc-27) |
| 2.3.4.2 | Pengajuan dan Pemeriksaan Retur | Customer, Admin Kasir, Admin Gudang, Super Admin Owner | KF-08 | [UC-39](TRACEABILITY-MATRIX.md#uc-39), [UC-40](TRACEABILITY-MATRIX.md#uc-40), [UC-41](TRACEABILITY-MATRIX.md#uc-41), [UC-42](TRACEABILITY-MATRIX.md#uc-42) |
| 2.3.4.3 | Penyelesaian Retur melalui Penukaran atau Refund | Admin Gudang, Admin Finance, Admin Kasir, Customer | KF-03, KF-08, KF-16 | [UC-43](TRACEABILITY-MATRIX.md#uc-43), [UC-44](TRACEABILITY-MATRIX.md#uc-44), [UC-45](TRACEABILITY-MATRIX.md#uc-45), [UC-46](TRACEABILITY-MATRIX.md#uc-46) |
| 2.3.5.1 | Pengelolaan Laporan Penjualan | Admin Finance, Super Admin Owner | KF-07 | [UC-62](TRACEABILITY-MATRIX.md#uc-62) |
| 2.3.6.1 | Pengelolaan Program Membership dan Reward | Admin Kasir, Super Admin Owner | KF-16 | [UC-55](TRACEABILITY-MATRIX.md#uc-55), [UC-56](TRACEABILITY-MATRIX.md#uc-56), [UC-57](TRACEABILITY-MATRIX.md#uc-57) |
| 2.3.6.2 | Pendaftaran dan Penukaran Reward Membership | Customer | KF-16 | [UC-52](TRACEABILITY-MATRIX.md#uc-52), [UC-53](TRACEABILITY-MATRIX.md#uc-53), [UC-54](TRACEABILITY-MATRIX.md#uc-54) |
| 2.3.6.3 | Pengelolaan dan Pengiriman Broadcast Promosi | Admin Kasir, Super Admin Owner. Customer sebagai penerima | KF-18 | [UC-60](TRACEABILITY-MATRIX.md#uc-60), [UC-61](TRACEABILITY-MATRIX.md#uc-61) |
| 2.3.7.1 | Interaksi Customer melalui Live Chat | Customer, Admin Kasir, Super Admin Owner | KF-13 | [UC-47](TRACEABILITY-MATRIX.md#uc-47) |
| 2.3.7.2 | Pengelolaan Produk Favorit | Customer | KF-14 | [UC-48](TRACEABILITY-MATRIX.md#uc-48) |
| 2.3.7.3 | Pengiriman, Penampilan, dan Pengelolaan Ulasan Produk | Customer, Guest, Admin Kasir, Super Admin Owner | KF-15 | [UC-49](TRACEABILITY-MATRIX.md#uc-49), [UC-50](TRACEABILITY-MATRIX.md#uc-50), [UC-51](TRACEABILITY-MATRIX.md#uc-51) |

Aktor eksternal dan aturan lintas proses dirujuk ke TO-BE §1 dan §4. Lihat [gap](GAP-ANALYSIS.md) serta [jejak per skenario](TRACEABILITY-MATRIX.md).
