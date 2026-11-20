# Rancangan database TARGET dan PROPOSED

Tabel di bawah adalah opsi pemodelan untuk memenuhi UC dan RB. Entitas yang telah ada tetap menjadi anchor. Jenis di kolom atribut adalah kategori logis, sedangkan tipe SQL, panjang, indeks, dan kebijakan hapus ditentukan setelah review data serta kebutuhan. PK/FK dan optionality di sini merupakan usulan. Detail vendor, aturan pembayaran, satuan harga, dan key komposit masih berstatus TBD.

| Entitas | Status | Acuan target | Atribut usulan | Parent dan optionality per baris |
| --- | --- | --- | --- | --- |
| `gateway_payment_attempts` | PROPOSED | UC-20–23, RB-05–09 | `id` (key, PK); `order_id` (ref, FK); `provider_reference` (identifier); `status` (status_code); `expires_at` (instant); `paid_at` (instant); `amount` (amount) | `order_id → orders` (1) |
| `gateway_payment_events` | PROPOSED | UC-22, RB-09 | `id` (key, PK); `attempt_id` (ref, FK); `provider_event_id` (identifier); `received_at` (instant); `processing_status` (status_code); `payload_fingerprint` (digest) | `attempt_id → gateway_payment_attempts` (1) |
| `stock_reservations` | PROPOSED | UC-16/22/24, RB-06–08 | `id` (key, PK); `order_item_id` (ref, FK); `variant_stock_id` (ref, FK); `qty` (quantity); `expires_at` (instant); `state` (status_code) | `order_item_id → order_items` (1); `variant_stock_id → product_size_stocks` (1) |
| `order_shipments` | PROPOSED | UC-24–27, RB-03 | `id` (key, PK); `order_id` (ref, FK); `shipping_method_id` (ref, FK); `tracking_number` (text); `recorded_by` (ref, FK); `shipped_at` (instant); `received_at` (instant) | `order_id → orders` (1); `shipping_method_id → metode_pengiriman` (1); `recorded_by → users` (1) |
| `procurement_documents` | PROPOSED | UC-30/31, RB-02 | `id` (key, PK); `procurement_id` (ref, FK); `po_number` (identifier); `document_version` (identifier); `created_by` (ref, FK); `document_path` (private_object); `sent_at` (instant) | `procurement_id → stock_procurements` (1); `created_by → users` (1) |
| `procurement_confirmations` | PROPOSED | UC-32, RB-02 | `id` (key, PK); `procurement_id` (ref, FK); `recorded_by` (ref, FK); `external_channel` (text); `response_notes` (text); `confirmed_at` (instant) | `procurement_id → stock_procurements` (1); `recorded_by → users` (1) |
| `procurement_receipts` | PROPOSED | UC-33/64, RB-10/25 | `id` (key, PK); `procurement_id` (ref, FK); `received_by` (ref, FK); `received_at` (instant); `posting_status` (status_code) | `procurement_id → stock_procurements` (1); `received_by → users` (1) |
| `procurement_receipt_items` | PROPOSED | UC-33/64, RB-10 | `id` (key, PK); `receipt_id` (ref, FK); `procurement_item_id` (ref, FK); `variant` (text); `received_qty` (quantity); `unit_cost` (amount) | `receipt_id → procurement_receipts` (1); `procurement_item_id → stock_procurement_items` (1) |
| `return_inspections` | PROPOSED | UC-42, RB-12–15 | `id` (key, PK); `return_id` (ref, FK); `inspected_by` (ref, FK); `inspected_at` (instant); `condition_code` (text); `sellable_qty` (quantity); `notes` (text) | `return_id → returns` (1); `inspected_by → users` (1) |
| `return_resolutions` | PROPOSED | UC-43/44, RB-15 | `id` (key, PK); `return_id` (ref, FK); `decided_by` (ref, FK); `resolution_type` (status_code); `replacement_item_id` (ref, FK); `status` (status_code) | `return_id → returns` (1); `decided_by → users` (1); `replacement_item_id → order_items` (0..1) |
| `refund_records` | PROPOSED | UC-45/46/62, RB-16/18/24 | `id` (key, PK); `resolution_id` (ref, FK); `recorded_by` (ref, FK); `amount` (amount); `proof_path` (private_object); `paid_at` (instant); `status` (status_code) | `resolution_id → return_resolutions` (1); `recorded_by → users` (1) |
| `membership_programs` | PROPOSED | UC-55, KF-16 | `id` (key, PK); `updated_by` (ref, FK); `label` (text); `status` (status_code); `effective_at` (instant); `policy_version` (text) | `updated_by → users` (1) |
| `promotion_broadcasts` | PROPOSED | UC-61, RB-21 | `id` (key, PK); `created_by` (ref, FK); `subject` (text); `content` (text); `queued_at` (instant); `status` (status_code) | `created_by → users` (1) |
| `promotion_deliveries` | PROPOSED | UC-61, RB-21/25 | `id` (key, PK); `broadcast_id` (ref, FK); `recipient_user_id` (ref, FK); `delivery_status` (status_code); `attempted_at` (instant); `provider_ref` (identifier) | `broadcast_id → promotion_broadcasts` (1); `recipient_user_id → users` (1) |

## Aturan lintas entitas

- Gateway menyimpan referensi transaksi dan penerimaan peristiwa. Gunakan deduplikasi berdasarkan identitas peristiwa yang disahkan, penguncian order, dan catat perubahan ketika pembayaran sukses. Penanganan event terlambat dan bentuk identifier mengikuti vendor dan O-01.
- Satu order memiliki item yang direservasi secara atomik saat checkout. Lepas stok sekali pada pembatalan, termasuk retry. Kaitkan ke varian dan state order. Tenggat berasal dari RB-06 dan konfirmasi zona waktu.
- Penerimaan merekam jumlah aktual per varian dan dapat bertahap. Mutasi stok terjadi saat posting setiap penerimaan tepat sekali. Tutup pengadaan setelah penerimaan lengkap sesuai kebijakan yang disetujui. Hubungkan riwayat pengadaan ke dokumen, konfirmasi eksternal dan admin pencatat.
- Penyiapan, pengiriman dan penerimaan melengkapi status order. Pencatatan resi tetap manual sesuai RB-03. Jumlah paket per order, kebutuhan riwayat, dan batas mutabilitas masih TBD.
- Pemeriksaan barang retur mencatat kondisi. Tambahkan stok jual hanya untuk unit layak jual. Pisahkan keputusan penyelesaian, penukaran, dan catatan refund Finance. Catat bukti privat dan histori poin tanpa melakukan transfer terprogram.
- Penerima broadcast diidentifikasi melalui Customer, lalu catat status pemrosesan yang diketahui. Status terkirim oleh provider dan status diterima pengguna memerlukan bukti berbeda. Hindari duplikasi kirim pada retry.
- UC-07, UC-08, UC-51, UC-58/59 sebagian dapat memakai tabel `users`, `audit_logs`, `order_reviews`, dan `notifications`. Perubahan kebijakan akses serta retensi masih perlu review. Jangan hapus tabel, status, atau kolom warisan sebelum memeriksa data, kontrak kedua client, dan rollback.

[Keputusan terbuka](../../../00-GLOBAL/DECISION-LOG.md) · [ERD target](../ERD/README.md) · [Skema aktual](SCHEMA-CURRENT.md)
