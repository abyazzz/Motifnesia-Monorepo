# Review rancangan Server

Audit statis terhadap migration, model, source class dan artefak desain. Hasil menunjukkan area yang memerlukan verifikasi fisik dan visual. Tidak ada migration atau database yang dijalankan.

## ERD CURRENT

- Diagram merangkum 42 tabel dan relasi FK fisik dari migration. Kamus mencakup kolom, nullable, indeks dan bukti migration. Ketersediaan skema fisik serta migration yang sudah diterapkan masih TBD. [Kamus](../design/DATABASE-DESIGN/SCHEMA-CURRENT.md) · [Diagram](../design/ERD/README.md)
- Pivot product_favorite dan product_size_stocks memakai constraint unik gabungan. Kardinalitas per satu FK tetap many, sehingga jangan membaca unique gabungan sebagai unik setiap kolom.
- reviews.product_id memiliki indeks tanpa FK fisik pada migration. Relasi model perlu dibaca terpisah dari constraint. Token Sanctum polymorphic juga tidak memiliki FK sederhana. [Migration reviews](../../../Motifnesia-Server/database/migrations/2025_11_24_000012_create_reviews_table.php)
- Model ProductOrder, ProductOrderDetail, dan ProductOrderItem belum memiliki tabel yang dapat ditelusuri ke migration dalam inventaris. Evaluasi penggunaan dan skema deployment sebelum menghapus atau menganggap tabel tersedia.
- FK nullable terhadap users dan entitas lain harus diperiksa dari migration masing-masing. Garis diagram menampilkan FK fisik, sedangkan relasi Eloquent, trait dan indeks dicatat pada kamus/source. Perubahan bersyarat dan SQL per-driver membutuhkan verifikasi database fisik.
- Perlu review manual seluruh pasangan FK, optionality dan kardinalitas terhadap migration serta relasi model dan pemeriksaan keterbacaan visual. Pemeriksaan geometris tidak memastikan garis tidak saling silang.

## ERD TARGET

Kolom berikut merujuk entitas usulan pada SCHEMA-TARGET. Setiap parent tercatat satu per child pada usulan, kecuali replacement_item_id yang 0..1. Multiplicity child per parent, kendala unik dan aturan retensi masih PROPOSED/TBD.

| Entitas PROPOSED | Kebutuhan dan alasan | Proses dan KF | Hubungan, kardinalitas serta keputusan |
| --- | --- | --- | --- |
| gateway_payment_attempts | UC-20–23, simpan attempt dan status | 2.3.3 · KF-05 | orders 1 per attempt; jumlah attempt/order TBD; vendor dan retry |
| gateway_payment_events | UC-22, simpan callback | 2.3.3 · KF-05 | attempt 1; jumlah event dan unique idempotensi TBD |
| stock_reservations | UC-16/19, stok checkout | 2.3.3 · KF-03/04 | order_items dan product_size_stocks masing-masing 1; aturan release TBD |
| order_shipments | UC-24–27, resi/pemenuhan | 2.3.4 · KF-06 | orders 1; beberapa shipment dimungkinkan oleh diagram tetapi kebijakan paket dan item shipment TBD |
| procurement_documents | UC-30/31, dokumen PO | 2.3.2 · KF-09 | stock_procurements 1; versi dan nomor TBD |
| procurement_confirmations | UC-32, hasil kanal eksternal | 2.3.2 · KF-09 | stock_procurements 1; histori dan bukti TBD |
| procurement_receipts | UC-33/64, penerimaan parsial | 2.3.2 · KF-03/09 | stock_procurements 1; 0..n penerimaan diusulkan |
| procurement_receipt_items | UC-33/64, jumlah aktual per varian | 2.3.2 · KF-03/09 | receipt dan item pengadaan masing-masing 1; kecocokan PO dan varian perlu constraint |
| return_inspections | UC-42, kondisi dan kelayakan jual | 2.3.4 · KF-08 | returns 1; revisi pemeriksaan dan kaitan mutasi stok TBD |
| return_resolutions | UC-43/44, keputusan dan penukaran | 2.3.4 · KF-08 | returns 1, replacement_item_id 0..1; arti item order pengganti perlu verifikasi |
| refund_records | UC-45/46/62, bukti dan status refund | 2.3.4/2.3.5 · KF-07/08 | resolution 1; partial refund, proof dan reversal poin TBD |
| membership_programs | UC-55, konfigurasi program | 2.3.6 · KF-16 | updated_by user 1; hubungan versi program dengan reward dan periode TBD |
| promotion_broadcasts | UC-61, status broadcast | 2.3.6 · KF-18 | created_by user 1; mekanisme penyimpanan isi TBD |
| promotion_deliveries | UC-61, status per penerima | 2.3.6 · KF-18 | broadcast dan user masing-masing 1; jumlah retry dan identitas pengiriman TBD |

Catalog, ledger stok, poin, voucher, notifikasi dan audit berangkat dari tabel aktual. Diagram target belum menghubungkan seluruh aturan ini secara terpadu. Hubungan stok dengan receipt, shipment, retur, reversal poin dan status voucher perlu rincian. Diagram saat ini memungkinkan banyak shipment tanpa detail item; kebijakan split shipment masih keputusan terbuka.

## Class CURRENT

Class diagram menampilkan metode deklarasi dengan nama parameter. Inventaris controller memuat signature lengkap dan namespace. Diagram belum memperlihatkan tipe return, trait, atau semua dependency lintas modul. Contoh User memakai HasApiTokens, HasFactory dan Notifiable di [source](../../../Motifnesia-Server/app/Models/User.php). Diagram tidak boleh dibaca sebagai daftar metode yang diwarisi.

Pemeriksaan AST membandingkan 101 class aplikasi dan 374 metode yang dideklarasikan beserta nama parameter pada Mermaid. Semuanya ditemukan di source. Sembilan referensi class framework pada diagram adalah parent eksternal, di luar 101 class aplikasi. Return type, trait, dependency lintas diagram, dan seluruh relasi masih perlu review manual. Rujuk [inventaris controller](../design/CLASS-DIAGRAM/CONTROLLERS-CURRENT.md) dan source sebagai bukti; ringkasan otomatis tidak menggantikan pengecekan body method.

## Class TARGET

Delapan belas class adalah PROPOSED. Pisahkan tujuan dan mekanisme. Controller menerima permintaan dan membatasi akses, service mengoordinasikan aturan transaksi, adapter menutup perbedaan vendor, job dapat dipertimbangkan untuk pekerjaan asynchronous. Bentuk class belum disetujui. Reuse dan pengembangan class yang ada harus dievaluasi bersama tim.

| Usulan | KF / UC | Class aktual yang perlu dievaluasi | Keputusan |
| --- | --- | --- | --- |
| PasswordRecoveryController | KF-10 · UC-03 | Auth/UserController, WebCredentials | Controller atau perluasan yang ada; verifikasi email TBD |
| StaffAccessController | KF-12 · UC-07/08 | Admin/CustomerController, AppServiceProvider | Pisahkan pengelolaan staf dan customer jika akses berbeda |
| ReviewRemovalController | KF-15 · UC-51 | Admin/ProductReviewController | Tambah aksi atau class baru |
| CustomerNotificationController | KF-17 · UC-59 | Customer/NotificationController | Tambah aksi kepemilikan ke controller yang ada |
| PromotionBroadcastService | KF-18 · UC-61 | Admin/MembershipController, MemberNotificationService | Service dan job retry sesuai kontrak email |
| MembershipProgramService | KF-16 · UC-55/57 | User, Admin/MembershipController | Policy dan ledger bersama |
| PaymentInitiationController | KF-05 · UC-20/23 | Customer/PaymentController, OrderService | Versi kontrak dan migrasi pembayaran |
| GatewayNotificationController | KF-05 · UC-22 | WebApi, OrderService | Controller khusus atau endpoint API; validasi callback |
| PaymentGatewayAdapter | KF-05 · UC-20–22 | WebCredentials, OrderService | Interface vendor dan transaksi idempotent |
| PaymentReconciliationService | KF-05 · UC-22 | OrderService | Kepemilikan transisi dan retry |
| StockReservationService | KF-03/04 · UC-16/19 | OrderService, StockInventoryService | Reuse dan penguncian atomik |
| ShipmentService | KF-06 · UC-24–27 | OrderStatusController, PurchaseHistoryController | Format resi dan banyak paket TBD |
| PurchaseOrderDocumentService | KF-09 · UC-30/31 | StockProcurementController | Nomor dan format dokumen TBD |
| SupplierConfirmationService | KF-09 · UC-32 | StockProcurementController | Pencatatan eksternal dalam service atau action |
| ProcurementReceiptService | KF-03/09 · UC-33 | StockInventoryService, StockProcurementController | Penerimaan parsial dan idempotensi |
| ReturnInspectionService | KF-08 · UC-42–44 | Admin/ReturnController, StockInventoryService | Hubungan pemeriksaan dan mutasi stok |
| RefundRecordingService | KF-08/16 · UC-45/46 | Admin/ReturnController, ProofMedia | Transfer manual, bukti, reversal poin |
| OperationsReportService | KF-03/07/09 · UC-62–64 | Admin/ReportController, StockInventoryService | Periode pembayaran dan refund |

## Keputusan dan asumsi

- Pilih kebijakan satu atau beberapa pengiriman per order dan representasi item per pengiriman.
- Tetapkan event gateway, signature, duplikasi, callback terlambat dan transisi stock reservation.
- Konfirmasi receipt parsial, kelebihan penerimaan, versioning PO dan cara mencatat konfirmasi eksternal.
- Tetapkan model refund, bukti privat, status penukaran dan pembalikan poin.
- Review alasan kebutuhan entitas dan class dengan pemilik scope sebelum mengubah diagram atau source.
