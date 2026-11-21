# Phase 2 · Laporan review

## A. Perubahan

Instruksi root diperluas dan tiga AGENTS aplikasi ditambahkan. Enam dokumen global diperbarui pada bagian terkait. Laporan baru memuat [hierarki instruksi](00-GLOBAL/INSTRUCTION-HIERARCHY.md), [rekonsiliasi UC-KF](00-GLOBAL/UC-KF-RECONCILIATION.md), [review desain Server](01-SERVER/analysis/DESIGN-REVIEW.md), dan [alternatif scope Mobile](03-CLIENT-MOBILE/analysis/RELEASE-SCOPE-DECISION.md).

Setiap UI-UX memiliki design system, indeks wireframe, spesifikasi per halaman, review, SVG, dan tiga file Draw.io yang dikelompokkan menurut customer, admin, dan supplier. [Web](02-CLIENT-WEB/design/UI-UX/wireframes/README.md) · [Mobile](03-CLIENT-MOBILE/design/UI-UX/wireframes/README.md)

## B. Instruksi agent

Sebelum pekerjaan, AGENTS tersedia pada root dan empat scope dokumentasi. AGENTS pada ketiga aplikasi dan subdirektorinya belum ditemukan. Sesudahnya, setiap aplikasi memiliki entry yang mengarah ke instruksi global, aturan dan scope. Pemeriksaan tautan relatif dilakukan. [Urutan dan contoh](00-GLOBAL/INSTRUCTION-HIERARCHY.md)

## C. Rekonsiliasi

UC-15, UC-16, UC-19, UC-22, UC-24, UC-42, UC-43 dan UC-44 diperiksa terhadap dokumen TA asli dan TO-BE. Rekomendasi membedakan relasi utama, pendukung dan invarian. Delapan kasus tetap NEEDS APPROVAL, terutama hubungan poin dengan penukaran, serta apakah packing mencatat pergerakan stok. Pemetaan final pada matriks belum diubah. [Analisis per UC](00-GLOBAL/UC-KF-RECONCILIATION.md)

## D. Desain Server

ERD CURRENT mencakup 42 tabel dan 53 FK dalam inventaris sebelumnya. Review menemukan perhatian pada FK fisik dibanding relasi Eloquent, indeks komposit dan tiga model yang tabelnya belum ditemukan di migration. ERD TARGET memuat 14 entitas PROPOSED. Perlu keputusan terkait item pengiriman, penerimaan parsial, event gateway, refund dan reversal poin.

AST memeriksa 101 class aplikasi dan 374 method beserta nama parameter yang tergambar di Mermaid. Sembilan parent framework muncul sebagai class eksternal. Return type, trait, hubungan lintas diagram, seluruh FK dan optionality masih perlu review manual menyeluruh. Delapan belas class target tetap usulan, dengan kandidat reuse class aktual dalam [review desain](01-SERVER/analysis/DESIGN-REVIEW.md). Diagram lama dipertahankan.

## E. Scope Mobile

Alternatif A berfokus pada Guest/Customer, B seluruh role, C Customer dan Gudang. Portal Supplier pada A/B merupakan opsi transisi yang memerlukan keputusan karena RB-02 menetapkan Supplier eksternal. O-04 tetap NEEDS APPROVAL. [Perbandingan dampak](03-CLIENT-MOBILE/analysis/RELEASE-SCOPE-DECISION.md)

## F. UI/UX

Terdapat 24 halaman prioritas per platform, yaitu 11 Customer, 9 admin dan 4 Supplier, dengan total 48 halaman. Setiap halaman memiliki preview SVG, tab Draw.io dan spesifikasi role, UC, aksi, state dan API. Wireframe adalah rancangan blok awal low-fidelity. Beberapa halaman masih memakai susunan daftar generik, dan spesifikasi loading, kosong, error serta validasi masih umum. Perlu pengembangan visual per halaman, interaksi, aksesibilitas dan state spesifik sebelum rancangan siap disetujui. Admin Mobile bersyarat dan Supplier berstatus aktual/alternatif. Login, registrasi, reset sandi, live chat, ulasan detail, pengelolaan reward dan pengelolaan akun internal belum dibuat sebagai wireframe khusus.

## G. Validasi

- 79 Mermaid berhasil diparsing dan menghasilkan SVG memakai Mermaid lokal dengan simulasi DOM. Layout hasil perlu pemeriksaan visual nyata.
- Sepuluh file Draw.io dengan 80 halaman lulus parsing XML, pemeriksaan nama, ID, referensi edge, geometry dan overlap bounding box. Pemeriksaan ini tidak memverifikasi persilangan garis, keterpotongan label, atau pembukaan dalam editor Draw.io.
- Google Chrome headless tidak dapat dimulai karena pembatasan socket lingkungan. Dua preview SVG diperiksa secara visual melalui librsvg, meliputi katalog Web dan contoh penerimaan Mobile. Tinjauan visual semua halaman serta pembukaan dan keterbacaan di Draw.io masih terbuka.
- Referensi yang disalin lulus pemeriksaan SHA256. Dokumen TA asli tetap utuh.
- Sebanyak 3.720 tautan file Markdown dan 1.683 anchor Markdown diperiksa. Tidak ditemukan target atau anchor yang hilang.
- Status awal bersih untuk file terlacak dengan satu file tak terlacak project-docs.zip. Status akhir mencakup perubahan instruksi dan dokumentasi Phase 2 serta file zip yang sudah ada.

## H. Keputusan pemilik proyek

### Bisnis dan cakupan

1. Setujui atau ubah relasi pendukung untuk delapan UC, termasuk dampak UC-43/44 terhadap poin.
2. Pilih cakupan Mobile dan peran admin yang diperlukan. Tentukan masa transisi portal Supplier mengingat RB-02.
3. Tentukan kebijakan pengiriman parsial/split, perubahan PO dan penerimaan berlebih, refund parsial, bukti dan reversal poin.
4. Tetapkan vendor gateway, zona waktu tenggat, penanganan callback terlambat dan kebijakan rekonsiliasi.

### Teknis untuk ditinjau bersama tim

1. Tentukan idempotensi event gateway dan transaksi stok, model referensi item pengganti, serta model histori shipment.
2. Putuskan reuse service dan controller yang sudah ada sebelum menambah 18 class PROPOSED.
3. Tinjau wireframe pada ukuran nyata, aksesibilitas, status dan kontrak API sebelum implementasi.
