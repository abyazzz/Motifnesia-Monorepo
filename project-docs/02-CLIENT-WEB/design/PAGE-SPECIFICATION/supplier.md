# Supplier aktual · Client Web

Data, aksi dan route awal berasal dari kode. Panduan keadaan layar dan responsivitas memberi kriteria desain. Rancangan target mengikuti skenario dan menunggu penyelarasan kontrak untuk gap. [Indeks](README.md)

## Halaman 42

### Pengadaan Supplier

**Route AS-IMPLEMENTED** `/supplier/procurements` · **Aktor saat ini** Supplier. [index.blade.php](../../../../Motifnesia-Client-Web/resources/views/supplier/procurements/index.blade.php)

- Tujuan dan informasi. Pengadaan milik akun supplier.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Lihat dan buka detail berdasarkan daftar.
- Jejak target. [UC-31](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-31), [UC-32](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-32) (jejak fungsi pengadaan aktual, aktor target internal).
- Validasi dan keadaan kosong. Role Supplier dan kepemilikan. Kosong tampilkan belum ada pengadaan.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Susun daftar dan ringkasan dalam kolom yang masuk akal pada desktop dan viewport sempit.
- Rancangan target. Alur aktual untuk transisi. Target menempatkan komunikasi supplier di luar aplikasi.

Sumber data awal. [`GET /supplier/procurements`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-113).

## Halaman 43

### Detail Pengadaan

**Route AS-IMPLEMENTED** `/supplier/procurements/{procurement}` · **Aktor saat ini** Supplier. [show.blade.php](../../../../Motifnesia-Client-Web/resources/views/supplier/procurements/show.blade.php)

- Tujuan dan informasi. Rincian pengadaan dan status pengiriman.
- Komponen. Kartu/ringkasan, header konteks, dan pesan status.
- Aksi aktual. Setujui pengadaan atau tandai diantar.
- Jejak target. [UC-32](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-32) (jejak fungsi pengadaan aktual, aktor target internal).
- Validasi dan keadaan kosong. Pemilik dan transisi sah. Not found bila objek tidak tersedia.
- Loading. Saat filter, submit atau mutasi AJAX berlangsung, tampilkan indikator dan pertahankan konteks halaman.
- Error. Pisahkan validasi, akses/sesi ditolak, data hilang, dan kegagalan jaringan. Sajikan ulang tindakan hanya jika aman.
- Responsivitas dan perilaku UI. Susun daftar dan ringkasan dalam kolom yang masuk akal pada desktop dan viewport sempit.
- Rancangan target. Alur aktual untuk transisi. Hasil konfirmasi target dicatat admin internal.

Sumber data awal. [`GET /supplier/procurements/{procurement}`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-114). Aksi dan data pendukung. [`POST /supplier/procurements/{procurement}/status`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-115).
