# Supplier aktual · Client Mobile

Data, aksi dan route awal berasal dari kode. Panduan keadaan layar dan responsivitas memberi kriteria desain. Rancangan target mengikuti skenario dan menunggu penyelarasan kontrak untuk gap. [Indeks](README.md)

## Layar 42

### Pengadaan Supplier

**Route AS-IMPLEMENTED** `/supplier/procurements` · **Aktor saat ini** Supplier. [procurements_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/supplier/pages/procurements_page.dart)

- Tujuan dan informasi. Pengadaan milik akun supplier.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Lihat dan buka detail berdasarkan daftar.
- Jejak target. [UC-31](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-31), [UC-32](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-32) (jejak fungsi pengadaan aktual, aktor target internal).
- Validasi dan keadaan kosong. Role Supplier dan kepemilikan. Kosong tampilkan belum ada pengadaan.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Alur aktual untuk transisi. Target menempatkan komunikasi supplier di luar aplikasi.

Sumber data awal. [`GET /supplier/procurements`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-113).

## Layar 43

### Detail Pengadaan

**Route AS-IMPLEMENTED** `/supplier/procurements/:id` · **Aktor saat ini** Supplier. [procurement_detail_page.dart](../../../../Motifnesia-Client-Mobile/lib/views/supplier/pages/procurement_detail_page.dart)

- Tujuan dan informasi. Rincian pengadaan dan status pengiriman.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status dengan kontrol sentuh Material.
- Aksi aktual. Setujui pengadaan atau tandai diantar.
- Jejak target. [UC-32](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-32) (jejak fungsi pengadaan aktual, aktor target internal).
- Validasi dan keadaan kosong. Pemilik dan transisi sah. Not found bila objek tidak tersedia.
- Loading. Tampilkan progres awal, pertahankan data terakhir saat reload, dan beri status tunggu pada aksi.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Daftar scroll, konten boleh melebar terbatas. Gunakan kartu, sheet atau dialog untuk tindakan kontekstual.
- Rancangan target. Alur aktual untuk transisi. Hasil konfirmasi target dicatat admin internal.

Sumber data awal. [`GET /supplier/procurements/{procurement}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-114). Aksi dan data pendukung. [`POST /supplier/procurements/{procurement}/status`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-115).
