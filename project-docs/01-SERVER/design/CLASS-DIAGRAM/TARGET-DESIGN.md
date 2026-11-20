# Rancangan class TARGET / PROPOSED

Peran class dan metode merupakan rancangan awal. Signature parameter dan rute publik menunggu kontrak serta review service yang sudah ada. Pertahankan transaksi dan otorisasi pada Server.

| Class PROPOSED | Metode PROPOSED | UC terkait | Tanggung jawab |
| --- | --- | --- | --- |
| `PasswordRecoveryController` | `requestReset()`, `confirmReset()` | UC-03 | Pemulihan email dan invalidasi token sesuai kebijakan. |
| `StaffAccessController` | `index()`, `updateRole()`, `deactivate()` | UC-07/08 | Kelola admin non-Owner, catat perubahan dan hindari eskalasi izin. |
| `ReviewRemovalController` | `destroyPublished()` | UC-51 | Hapus ulasan terbit sesuai izin dan kebijakan audit. |
| `CustomerNotificationController` | `destroyOwned()` | UC-59 | Hapus notifikasi yang dimiliki akun aktif. |
| `PromotionBroadcastService` | `prepare()`, `dispatch()`, `recordResult()` | UC-61 | Pratinjau, audiens Customer, antrean dan hasil yang dapat ditelusuri. |
| `MembershipProgramService` | `updatePolicy()`, `reverseAward()` | UC-19/43–45/55/57 | Konfigurasi dan reversal ledger. Kebijakan poin masih TBD. |
| `PaymentInitiationController` | `start()`, `showStatus()` | UC-20/23 | Mulai attempt gateway dan tampilkan status terotorisasi. |
| `GatewayNotificationController` | `receive()` | UC-22 | Wadah menerima hasil dari provider. Kontrak callback TBD. |
| `PaymentGatewayAdapter` | `createAttempt()`, `validateEvent()` | UC-20–22 | Batasi ketergantungan vendor pada adapter. |
| `PaymentReconciliationService` | `recordEvent()`, `applyConfirmedPayment()` | UC-22 | Deduplikasi event dan transisi pembayaran/order secara atomik. |
| `StockReservationService` | `reserve()`, `releaseExpired()` | UC-16/19/24 | Reservasi dan pelepasan stok mengikuti tenggat. |
| `ShipmentService` | `recordPacking()`, `recordTracking()`, `confirmReceived()` | UC-24–27 | Peran Gudang/Customer, bukti packing, resi, status dan histori. |
| `PurchaseOrderDocumentService` | `generate()`, `resolveVersion()`, `download()` | UC-30/31 | Buat dan distribusikan dokumen PO dengan histori versi. |
| `SupplierConfirmationService` | `recordExternalConfirmation()` | UC-32 | Simpan hasil komunikasi luar sistem dengan admin sebagai pencatat. |
| `ProcurementReceiptService` | `recordReceipt()`, `postInventory()` | UC-33 | Penerimaan parsial dan posting stok aktual dengan penguncian. |
| `ReturnInspectionService` | `recordInspection()`, `decideResolution()`, `recordReplacement()` | UC-42–44 | Pemeriksaan, penukaran, dan perlakuan varian layak jual. |
| `RefundRecordingService` | `recordTransfer()`, `updateRefundStatus()` | UC-45/46 | Pencatatan Finance, bukti privat, histori dan koreksi poin sesuai aturan. |
| `OperationsReportService` | `salesByPaidDate()`, `inventoryMovements()`, `procurementReceipts()` | UC-62–64 | Agregasi berdasarkan transaksi, mutasi, dan penerimaan dengan filter. |

Gunakan `StockInventoryService` dan `OrderService` sebagai titik telaah untuk mutasi stok dan order, `AuditLogService` untuk jejak, serta `ProofMedia` untuk bukti. Tinjau perluasan class sebelum menambah adapter atau controller agar API yang dipakai kedua client tetap konsisten.
