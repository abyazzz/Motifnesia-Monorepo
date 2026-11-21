# Baseline rancangan teknis Server · Phase 3

Baseline ini mengikat kebutuhan, status dan bukti desain. Keputusan teknis berlabel PROPOSED memerlukan review implementasi. Skema database fisik belum diperiksa.

## Database CURRENT

[ERD CURRENT Mermaid dan Draw.io](../design/ERD/README.md) menggambarkan tabel dari migration. Pemeriksaan Phase 3 membandingkan nama seluruh 42 tabel yang dideklarasikan dengan node diagram keseluruhan, tanpa selisih. Sebanyak 53 relasi dan kardinalitas diagram overview sesuai dengan kamus dokumentasi, dan baris migration yang dirujuk memuat kolom dan parent terkait. [Kamus CURRENT](../design/DATABASE-DESIGN/SCHEMA-CURRENT.md) mencatat atribut, PK, FK fisik, indeks, nullable, relasi Eloquent dan bukti migration. Status deployment, seluruh FK dan constraints di database fisik masih belum terverifikasi.

Pivot dengan unique gabungan tidak otomatis unik pada masing-masing kolom. Polymorphic token dan relasi Eloquent tidak otomatis merupakan FK fisik. Produk Order model yang tabelnya belum ditemukan pada migration tetap dicatat pada kamus. Audit menyeluruh atas setiap relasi, perubahan bersyarat, index dan trait masih diperlukan sebelum menyatakan kesetaraan skema fisik.

## Database TARGET

[Kamus TARGET](../design/DATABASE-DESIGN/SCHEMA-TARGET.md) dan [diagram target](../design/ERD/README.md) memuat 14 entitas PROPOSED. [Review Phase 2](DESIGN-REVIEW.md) memetakan tiap entitas ke proses, KF, UC, relasi dan keputusan. Tabel yang sudah ada berfungsi sebagai anchor implementasi. Usulan entitas belum diputuskan sebagai migration baru.

| Area | Bukti dan rancangan | Kebutuhan yang masih diputuskan |
| --- | --- | --- |
| Shipment | UC-24–27 dan RB-03. order_shipments PROPOSED menghubungkan order dan metode kirim. | Banyak shipment, kebutuhan baris item per shipment, jumlah parsial, status/riwayat dan kardinalitas TBD. |
| PO dan penerimaan | UC-30–33/64 dan RB-10. procurement_receipts dan receipt_items PROPOSED menyimpan penerimaan per item/varian; relasi supplier melalui stock_procurements. | Format PO, penerimaan berlebih, versi dan identitas retry TBD. Rekomendasi transaksi atomik dan kunci unik/idempotensi perlu disetujui. |
| Gateway | UC-20–23, RB-05–09. payment attempts terkait order dan events terkait attempt pada rancangan. | Vendor, identifier provider, autentikasi callback, event ganda/terlambat, retry, rekonsiliasi dan aturan unique TBD. |
| Retur dan refund | UC-39–46, RB-12–16. returns, inspection, resolution dan refund diusulkan sebagai jejak terpisah. Transfer dilakukan manual, bukti privat dan status dicatat sistem. | Refund penuh atau parsial, item pengganti, keterkaitan stok, retensi bukti dan kardinalitas TBD. |
| Poin/voucher | KF-16, UC-19/45/52–57 dan RB-18. point_transactions dan user_reward_redemptions tersedia pada source, reversal serta histori dijadikan kebutuhan target. | Pencocokan sumber transaksi, reversal tepat sekali, pembatalan dan status voucher membutuhkan aturan dan constraint yang disepakati. |
| Integritas | Kamus mencatat PK/FK/nullable dan indeks sesuai migration. Diagram target menandai relasi PROPOSED. | Tipe SQL, unique/index, perilaku hapus dan integritas lintas tabel/proses TBD. Jangan menganggap unique gabungan sebagai unique tunggal. |

## Class CURRENT

[Class diagram CURRENT](../design/CLASS-DIAGRAM/README.md) bersama [inventaris controller](../design/CLASS-DIAGRAM/CONTROLLERS-CURRENT.md) dan [inventaris pendukung](../design/CLASS-DIAGRAM/PENDUKUNG-CURRENT.md) menjadi rujukan source. AST memeriksa 101 class aplikasi dan 374 nama method beserta nama parameter pada Mermaid. Sembilan parent framework adalah referensi eksternal, bukan class aplikasi. Return type, trait, dependency dan semua garis antarclass belum diverifikasi secara menyeluruh.

## Class TARGET

[Target](../design/CLASS-DIAGRAM/TARGET-DESIGN.md) mencatat 18 class PROPOSED, method, tanggung jawab dan UC. [Review](DESIGN-REVIEW.md) mengaitkan tiap usulan ke KF, UC dan kandidat reuse. **Tidak ada daftar class baru yang sudah terbukti wajib dibuat sebagai class terpisah.** Kapabilitas gateway/callback, reservasi, receipt, shipment, retur/refund, ledger, PO, notifikasi dan laporan diperlukan sesuai kebutuhan, sementara pilihan Controller, Service, Adapter atau Job dan reuse menunggu desain teknis tim.

Prinsip evaluasi. Controller mengautentikasi permintaan dan membatasi input. Service atau action menangani transaksi domain. Adapter menyekat provider. Job hanya dipilih bila kebutuhan antrean disetujui. Model mewakili data dan relasi. Hindari dua komponen memegang mutasi stok atau ledger yang sama tanpa batas tanggung jawab.

## Riwayat Phase 2

Diagram CURRENT dan TARGET beserta Draw.io tetap dipertahankan. Phase 3 menambahkan penjelasan status, matriks keputusan dan keterbatasan pemeriksaan tanpa mengubah migration atau source. Pembaruan visual dilakukan hanya jika koreksi hubungan memiliki bukti memadai.
