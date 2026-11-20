# MASTER PROMPT — MOTIFNESIA MONOREPO PROJECT DOCUMENTATION & DESIGN FOUNDATION

## 1. PERAN DAN TUJUAN

Kamu bertindak sebagai **Software Architect, Business Analyst, System Analyst, Database Designer, dan Technical Documentation Engineer** untuk proyek MotifNesia.

Tugasmu adalah membangun pusat dokumentasi dan instruksi kerja terstruktur di dalam repository Motifnesia-Monorepo.

Dokumentasi ini akan digunakan bersama oleh tiga anggota tim yang masing-masing bertanggung jawab atas:

1. Backend Server — Laravel 12 (REST API dan basis data).
2. Client Web — Laravel 12, Blade, dan Vite.
3. Client Mobile — Flutter dan Dart.

Pusat dokumentasi harus berfungsi sebagai sumber acuan bersama bagi manusia maupun AI Agent (termasuk Codex) yang membaca, menganalisis, merancang, mengembangkan, menguji, dan memodifikasi proyek.

Jangan hanya membuat struktur folder kosong. Lakukan audit referensi, audit implementasi, susun aturan kerja, dokumentasikan batasan, dan buat rancangan awal sesuai tanggung jawab setiap anggota.

---

## 2. LOKASI PROYEK

Kamu dijalankan dari direktori:

`/mnt/Projects/Laravel`

Terdapat dua direktori utama yang relevan:

### A. Repository baru — target pengerjaan

`/mnt/Projects/Laravel/Motifnesia`

Struktur saat ini:

```text
Motifnesia/
├── BASELINE-ROUTES.json
├── BASELINE.sha256
├── MIGRASI.md
├── README.md
├── Motifnesia-Server/
├── Motifnesia-Client-Web/
├── Motifnesia-Client-Mobile/
└── tests/
```

Repository ini merupakan monorepo yang menampung tiga aplikasi MotifNesia.

### B. Project lama — sumber referensi

`/mnt/Projects/Laravel/Motifnesia-fullstak`

Folder referensi:

`/mnt/Projects/Laravel/Motifnesia-fullstak/referensi`

Folder tersebut berisi sumber-sumber yang sebelumnya digunakan dalam penyusunan Tugas Akhir, antara lain:

- Bank Informasi Toko Viera.
- Bank Informasi 2.0 MotifNesia.
- Transkrip Wawancara 1 dan 2.
- Laporan User Need.
- Dokumen Tugas Akhir.
- Dokumen rancangan proses bisnis TO-BE.
- Dokumen Use Case dan Skenario Use Case.
- Rules dan Working Guidelines.
- Prompt Codex.
- Referensi tambahan lainnya.

**WAJIB:** Audit isi folder referensi secara langsung. Jangan hanya mengandalkan nama file.

Jangan mengubah, menghapus, atau memindahkan file asli dari direktori referensi lama.

---

## 3. KONTEKS DAN KEADAAN PROYEK

MotifNesia merupakan platform e-commerce penjualan produk batik dengan tiga aplikasi:

- Backend Server sebagai pusat API, autentikasi, aturan bisnis, validasi, dan pengelolaan basis data.
- Client Web sebagai antarmuka pengguna berbasis web.
- Client Mobile sebagai antarmuka pengguna berbasis Flutter.

Kedua client menggunakan backend yang sama melalui API v1.

Informasi lokal dari README:

| Aplikasi | Teknologi | Alamat pengembangan |
|---|---|---|
| Server | Laravel 12 | 127.0.0.1:8000 |
| Client Web | Laravel 12, Blade, Vite | 127.0.0.1:8001 |
| Client Mobile | Flutter, Dart | 127.0.0.1:8002 |

Saat ini, Client Web dan Client Mobile telah memiliki fungsionalitas yang berjalan dan mengonsumsi API dari Motifnesia-Server.

Implementasi yang sudah ada merupakan fondasi pengembangan sistem target. Sistem tidak dibangun kembali dari nol.

### Kondisi rancangan Tugas Akhir

Rancangan terbaru telah memiliki:

- Tujuh proses bisnis TO-BE, yaitu 2.3.1 sampai 2.3.7.
- Daftar 64 Use Case final.
- Skenario Use Case.
- Kebutuhan Fungsional terbaru dengan tambahan sembilan KF yang telah ditetapkan.
- Pembagian tanggung jawab berdasarkan scope Server, Client Web, dan Client Mobile.

Dokumen tersebut harus diperiksa dan disinkronkan dengan referensi yang tersedia. Jangan menganggap dokumen lama otomatis masih berlaku.

Perhatian: jumlah dan isi kebutuhan fungsional harus diambil dari dokumen terbaru yang benar-benar ditemukan. Jangan membuat daftar KF sendiri atau mengarang isi KF yang tidak tersedia.

### Strategi pengembangan

Implementasi dilakukan dengan memanfaatkan sistem MotifNesia yang telah tersedia.

Perbedaan antara implementasi sekarang dan rancangan target merupakan hal yang wajar dan harus dicatat secara sistematis.

Jangan menganggap seluruh rancangan target sudah tersedia dalam kode.

---

## 4. TAHAP PERTAMA — AUDIT SEBELUM MEMBUAT PERUBAHAN

Sebelum membuat atau mengubah file apa pun, lakukan audit menyeluruh.

### 4.1 Audit repository

Periksa:

- Struktur direktori monorepo.
- README setiap aplikasi.
- Framework dan versi teknologi.
- Konfigurasi setiap aplikasi.
- Dependensi utama.
- Struktur source code.
- API dan endpoint yang tersedia.
- Model, migration, controller, service, middleware, request, resource, dan komponen relevan lainnya.
- Pengujian yang tersedia.
- Hubungan komunikasi Client Web dan Client Mobile dengan Server.

Jangan hanya membaca README. Periksa implementasi sebenarnya.

### 4.2 Audit referensi

Periksa seluruh file di:

`/mnt/Projects/Laravel/Motifnesia-fullstak/referensi`

Baca dokumen DOCX, PDF, MD, XLSX, dan format lainnya yang relevan.

Jika terdapat dokumen yang memiliki versi berbeda, identifikasi:

- Nama dokumen.
- Tujuan dokumen.
- Status dokumen.
- Versi atau tanggal.
- Apakah masih berlaku.
- Dokumen lain yang bertentangan dengannya.

Perhatikan bahwa nama file saja tidak cukup untuk menentukan otoritas sebuah dokumen.

### 4.3 Identifikasi sumber otoritatif

Susun matriks sumber yang menjelaskan:

| Jenis informasi | Sumber utama | Sumber pendukung | Status |
|---|---|---|---|
| Informasi bisnis dan kondisi toko | Dokumen wawancara dan bank informasi | Laporan user need | Sesuai hasil audit |
| Proses bisnis target | TO-BE terbaru | Dokumen TA | Sesuai hasil audit |
| Use Case dan skenario | Dokumen final Use Case | Dokumen TA | Sesuai hasil audit |
| Kebutuhan fungsional | Dokumen KF terbaru | TO-BE dan Use Case | Sesuai hasil audit |
| Implementasi aktual | Source code masing-masing aplikasi | README dan dokumentasi teknis | Aktual |
| Aturan pengembangan | Rules dan Working Guidelines | Instruksi proyek | Sesuai hasil audit |

Jika terdapat file `PROMPT CODEX.md`, periksa isi dan keputusan terbarunya. Jika dokumen tersebut secara eksplisit menetapkan prioritas atas dokumen lama, ikuti ketentuan itu selama tidak bertentangan dengan instruksi terbaru pemilik proyek.

Instruksi terbaru pemilik proyek dalam percakapan ini memiliki prioritas tertinggi.

### 4.4 Audit perbedaan

Buat daftar:

- Fitur yang sudah tersedia.
- Fitur yang tersedia sebagian.
- Fitur yang belum tersedia.
- Fitur lama yang tidak lagi menjadi target.
- Fitur target yang belum memiliki implementasi.
- Perbedaan aturan bisnis.
- Perbedaan alur proses.
- Perbedaan API dan kebutuhan client.

Semua temuan harus memiliki bukti berupa path file, nama class, nama method, nama endpoint, migration, atau bagian dokumen yang relevan.

Jangan mengarang bukti.

---

## 5. TAHAP KEDUA — MEMBANGUN STRUKTUR PROJECT-DOCS

Buat struktur dokumentasi berikut di dalam repository:

```text
Motifnesia/
│
├── project-docs/
│   │
│   ├── 00-GLOBAL/
│   │   ├── AGENTS.md
│   │   ├── PROJECT-OVERVIEW.md
│   │   ├── GLOBAL-RULES.md
│   │   ├── SOURCE-OF-TRUTH.md
│   │   ├── GLOSSARY.md
│   │   ├── DECISION-LOG.md
│   │   ├── TRACEABILITY-MATRIX.md
│   │   ├── GAP-ANALYSIS.md
│   │   ├── references/
│   │   └── architecture/
│   │
│   ├── 01-SERVER/
│   │   ├── AGENTS.md
│   │   ├── SCOPE.md
│   │   ├── RULES.md
│   │   ├── REFERENCES-INDEX.md
│   │   ├── references/
│   │   ├── analysis/
│   │   ├── design/
│   │   │   ├── ERD/
│   │   │   ├── CLASS-DIAGRAM/
│   │   │   ├── API-DESIGN/
│   │   │   └── DATABASE-DESIGN/
│   │   └── implementation/
│   │
│   ├── 02-CLIENT-WEB/
│   │   ├── AGENTS.md
│   │   ├── SCOPE.md
│   │   ├── RULES.md
│   │   ├── REFERENCES-INDEX.md
│   │   ├── references/
│   │   ├── analysis/
│   │   ├── design/
│   │   │   ├── UI-UX/
│   │   │   ├── SITEMAP/
│   │   │   ├── USER-FLOW/
│   │   │   ├── PAGE-SPECIFICATION/
│   │   │   └── COMPONENT-DESIGN/
│   │   └── implementation/
│   │
│   └── 03-CLIENT-MOBILE/
│       ├── AGENTS.md
│       ├── SCOPE.md
│       ├── RULES.md
│       ├── REFERENCES-INDEX.md
│       ├── references/
│       ├── analysis/
│       ├── design/
│       │   ├── UI-UX/
│       │   ├── NAVIGATION/
│       │   ├── USER-FLOW/
│       │   ├── SCREEN-SPECIFICATION/
│       │   └── COMPONENT-DESIGN/
│       └── implementation/
│
└── ...
```

Kamu boleh menambahkan file atau subfolder jika memang diperlukan, tetapi jangan menghilangkan pemisahan global dan masing-masing scope.

### 5.1 Aturan penyimpanan referensi

Salin referensi yang relevan dari folder lama ke dalam `project-docs/00-GLOBAL/references/`.

Salinan sumber untuk masing-masing scope ditempatkan pada folder `references/` milik anggota terkait.

Gunakan salinan file, bukan memindahkan file asli.

Jangan membuat salinan duplikat yang tidak diperlukan. Jika sebuah referensi digunakan lintas scope, gunakan satu salinan pada folder global dan tautkan dari dokumentasi scope terkait.

Pertahankan:

- Nama file asli jika memungkinkan.
- Format asli.
- Isi dan struktur dokumen.
- Identitas sumber dan lokasi asalnya.

Buat `REFERENCES-INDEX.md` untuk setiap scope agar anggota mengetahui dokumen mana yang relevan dan alasan penggunaannya.

Jika file tidak bisa dibaca atau dikonversi, catat keterbatasannya. Jangan mengarang isi dokumen.

---

## 6. TAHAP KETIGA — ATURAN GLOBAL UNTUK SELURUH AI AGENT

Buat file:

`project-docs/00-GLOBAL/AGENTS.md`

File ini menjadi instruksi utama bagi AI Agent yang bekerja di dalam repository.

Isinya minimal mencakup:

1. Identitas dan tujuan proyek.
2. Arsitektur monorepo.
3. Hubungan Server, Client Web, dan Client Mobile.
4. Struktur dokumentasi dan lokasi acuan.
5. Hierarki sumber kebenaran.
6. Aturan membaca referensi sebelum mengubah kode.
7. Aturan menjaga konsistensi lintas aplikasi.
8. Aturan penggunaan API bersama.
9. Aturan autentikasi dan otorisasi.
10. Aturan pengelolaan data dan transaksi.
11. Aturan keamanan.
12. Aturan pengujian.
13. Aturan dokumentasi perubahan.
14. Larangan mengarang kebutuhan.
15. Larangan mengubah scope anggota lain tanpa koordinasi.

Pastikan instruksi ini dapat dipahami oleh agent yang tidak memiliki konteks percakapan sebelumnya.

Buat juga `GLOBAL-RULES.md` sebagai aturan teknis dan koordinasi yang lebih rinci.

### Hierarki instruksi

Terapkan hierarki berikut:

1. Instruksi terbaru dari pemilik proyek.
2. Instruksi global pada `00-GLOBAL/AGENTS.md`.
3. Instruksi khusus scope masing-masing.
4. Rules khusus scope.
5. Dokumentasi teknis dan referensi.
6. Implementasi aktual sebagai bukti kondisi sistem.

Jika terdapat konflik, jangan menyelesaikannya secara diam-diam. Catat konflik dan alasan pemilihan sumber.

Perhatikan bahwa source code menunjukkan kondisi implementasi aktual, tetapi tidak otomatis menjadi penentu kebutuhan target.

---

## 7. TAHAP KEEMPAT — INSTRUKSI KHUSUS SETIAP SCOPE

### A. BACKEND SERVER

Lokasi dokumentasi:

`project-docs/01-SERVER/`

Pemilik scope: anggota yang bertanggung jawab atas Backend Server.

Buat `AGENTS.md`, `SCOPE.md`, dan `RULES.md`.

Fokus utama:

- Laravel 12.
- REST API.
- Database.
- Business logic.
- Model dan relasi.
- Controller.
- Service.
- Authentication.
- Authorization.
- Validation.
- Transaction handling.
- Error handling.
- Integrasi Payment Gateway.
- Integrasi Client Web dan Mobile.
- Pengujian API.
- Konsistensi data.

#### A.1 Perancangan ERD

Lakukan analisis database berdasarkan:

1. Migration Laravel.
2. Model Eloquent.
3. Relasi model.
4. Struktur tabel aktual.
5. Aturan bisnis dalam implementasi.
6. Kebutuhan fungsional terbaru.
7. 64 Use Case dan skenarionya.
8. Proses bisnis TO-BE 2.3.1–2.3.7.

Buat ERD yang menggambarkan struktur aktual database berdasarkan bukti migration dan model.

Namun, karena kebutuhan target tidak seluruhnya tersedia pada implementasi sekarang, kamu juga harus mengidentifikasi entitas, atribut, dan relasi yang dibutuhkan oleh rancangan target.

**Pisahkan hasil menjadi:**

- ERD CURRENT / AS-IMPLEMENTED: kondisi yang benar-benar ditemukan dalam source code.
- ERD TARGET / PROPOSED: rancangan database yang diperlukan untuk memenuhi kebutuhan target.

Jika sebuah entitas atau relasi belum tersedia dalam implementasi tetapi diperlukan oleh Use Case, masukkan ke rancangan target dengan penanda `PROPOSED`.

Jangan menyatakan entitas tersebut sudah diimplementasikan.

Buat hasil dalam dua format:

- `.mmd` menggunakan Mermaid ER Diagram.
- `.drawio` menggunakan format XML Draw.io yang dapat dibuka dan diedit.

Buat diagram yang terstruktur, terbaca, dan memiliki relasi yang jelas.

Sertakan dokumentasi:

- Nama entitas.
- Atribut.
- Primary Key.
- Foreign Key.
- Kardinalitas.
- Optionality jika dapat ditentukan.
- Penjelasan relasi.
- Sumber bukti.
- Status implementasi.
- Asumsi atau keputusan yang masih diperlukan.

Jangan mengarang tipe data atau constraint yang tidak didukung bukti. Jika belum diketahui, tandai sebagai `TBD` atau `PROPOSED`.

#### A.2 Perancangan Class Diagram

Lakukan inventarisasi class pada backend Laravel.

Minimal identifikasi:

- Controller.
- Model.
- Service.
- Repository jika ada.
- Form Request.
- API Resource.
- Middleware.
- Job.
- Event dan Listener.
- Helper atau class pendukung yang relevan.

Prioritaskan seluruh class Controller yang ditemukan.

Untuk setiap Controller, dokumentasikan:

- Nama class.
- Lokasi file.
- Namespace.
- Method/function yang dimiliki.
- Parameter method jika dapat diidentifikasi.
- Tanggung jawab method.
- Model, service, request, atau resource yang digunakan.
- Relasi atau dependensi antarclass.

Buat Class Diagram yang menggambarkan class aktual, terutama Controller beserta method yang dimiliki.

Jangan hanya mencantumkan nama Controller. Tampilkan nama method/function di dalam masing-masing class.

Selain itu, identifikasi class yang dibutuhkan oleh Use Case target tetapi belum ditemukan pada implementasi.

Pisahkan:

- CLASS DIAGRAM CURRENT / AS-IMPLEMENTED.
- CLASS DIAGRAM TARGET / PROPOSED.

Class target yang belum ada harus diberi penanda `PROPOSED`.

Jangan mengklaim class atau method usulan sebagai bagian dari source code aktual.

Gunakan:

- Mermaid Class Diagram `.mmd`.
- Draw.io `.drawio`.

Pastikan diagram menunjukkan hubungan yang relevan, misalnya dependency, association, inheritance, dan relasi lain jika memang ditemukan atau dibutuhkan.

Jika diagram terlalu besar, pecah menjadi diagram per modul atau kelompok tanggung jawab. Tetap sediakan satu dokumentasi indeks yang menjelaskan keseluruhan diagram.

#### A.3 Perancangan API

Audit endpoint aktual dan bandingkan dengan kebutuhan client.

Dokumentasikan:

- Endpoint.
- HTTP Method.
- Controller dan method tujuan.
- Authentication.
- Authorization.
- Request.
- Response.
- Validasi.
- Status code.
- Hubungan endpoint dengan Use Case dan KF.

Pisahkan endpoint yang sudah ada, perlu penyesuaian, dan perlu dibuat.

Jangan mengubah source code hanya untuk membuat dokumentasi.

---

### B. CLIENT WEB

Lokasi dokumentasi:

`project-docs/02-CLIENT-WEB/`

Buat `AGENTS.md`, `SCOPE.md`, dan `RULES.md`.

Fokus utama:

- Laravel 12.
- Blade.
- Vite.
- Struktur halaman.
- UI/UX.
- Navigasi.
- Sitemap.
- User Flow.
- Integrasi API.
- State dan session pada client.
- Validasi tampilan.
- Responsivitas.
- Pengujian antarmuka.

Rancangan target harus berdasarkan Use Case dan Skenario Use Case final serta kebutuhan fungsional yang relevan.

Jangan membuat halaman hanya karena halaman tersebut tersedia di aplikasi lama. Evaluasi relevansinya terhadap rancangan target.

#### B.1 Audit implementasi Web

Identifikasi:

- Route.
- Controller client.
- Blade view.
- Layout.
- Component.
- Asset.
- Navigation.
- Form.
- Halaman admin.
- Halaman customer.
- Halaman supplier jika tersedia.
- Integrasi API.

Catat halaman yang sudah tersedia, perlu penyesuaian, dan belum tersedia.

#### B.2 Rancangan UI/UX

Buat dokumentasi rancangan antarmuka berdasarkan:

- Peran pengguna.
- Use Case.
- Skenario Use Case.
- Kebutuhan Fungsional.
- TO-BE terbaru.
- Implementasi Web yang sudah ada.

Untuk setiap halaman, dokumentasikan:

- Nama halaman.
- Tujuan.
- Aktor/pengguna.
- Use Case terkait.
- Informasi yang ditampilkan.
- Komponen UI.
- Aksi pengguna.
- Validasi.
- Kondisi loading.
- Kondisi kosong.
- Kondisi error.
- Responsivitas.
- API yang dikonsumsi.

Jangan membuat keputusan UI yang bertentangan dengan kebutuhan bisnis.

#### B.3 Sitemap dan Navigasi

Buat Sitemap yang menggambarkan struktur halaman dan navigasi berdasarkan role.

Minimal evaluasi:

- Guest.
- Customer.
- Super Admin Owner.
- Admin Finance.
- Admin Kasir.
- Admin Gudang.

Gunakan daftar aktor final dalam dokumen Use Case sebagai acuan.

Jangan memberikan akses ke halaman hanya berdasarkan asumsi.

Buat:

- Sitemap keseluruhan.
- Sitemap per role.
- Navigasi antarhalaman.
- Mapping halaman ke Use Case.
- Mapping halaman ke API.

Format diagram dapat menggunakan Mermaid dan/atau Draw.io jika relevan.

#### B.4 User Flow

Buat user flow untuk proses penting.

Setiap flow harus mengikuti skenario Use Case dan alur bisnis target.

Jika implementasi saat ini berbeda, dokumentasikan perbedaannya.

---

### C. CLIENT MOBILE

Lokasi dokumentasi:

`project-docs/03-CLIENT-MOBILE/`

Buat `AGENTS.md`, `SCOPE.md`, dan `RULES.md`.

Fokus utama:

- Flutter.
- Dart.
- Struktur aplikasi.
- UI/UX Mobile.
- Navigation.
- Screen Flow.
- Widget.
- State Management.
- API Integration.
- Authentication.
- Error Handling.
- Pengujian aplikasi.

Rancangan harus mengacu pada Use Case, Skenario Use Case, KF, dan TO-BE terbaru.

#### C.1 Audit implementasi Mobile

Identifikasi:

- Struktur folder.
- Screen/Page.
- Widget.
- Routing.
- State Management.
- Model data.
- API client.
- Service.
- Authentication.
- Konfigurasi.
- Pengujian.

Catat fitur yang sudah tersedia, perlu penyesuaian, dan belum tersedia.

#### C.2 Rancangan UI/UX Mobile

Untuk setiap screen, dokumentasikan:

- Nama screen.
- Tujuan.
- Role.
- Use Case terkait.
- Komponen.
- Aksi pengguna.
- Informasi yang ditampilkan.
- API yang digunakan.
- Loading state.
- Empty state.
- Error state.
- Validasi.
- Responsivitas dan perilaku layar.

Perhatikan karakteristik mobile. Jangan sekadar menyalin tampilan web menjadi tampilan mobile.

#### C.3 Navigation dan Screen Flow

Buat:

- Navigation Map keseluruhan.
- Navigation Map per role.
- Screen Flow.
- Hubungan antar-screen.
- Mapping screen ke Use Case.
- Mapping screen ke API.

Pastikan setiap screen memiliki jalur navigasi yang logis dan sesuai kewenangan pengguna.

#### C.4 Integrasi API

Gunakan kontrak API dari Server sebagai acuan bersama.

Jangan membuat endpoint fiktif.

Jika kebutuhan client belum didukung endpoint yang tersedia, masukkan ke daftar API gap dan koordinasikan dengan scope Server.

---

## 8. TAHAP KELIMA — TRACEABILITY DAN KONSISTENSI

Buat dokumentasi keterkaitan lintas artefak.

Minimal meliputi:

```text
TO-BE
  ↓
Kebutuhan Fungsional
  ↓
Use Case
  ↓
Skenario Use Case
  ↓
Rancangan Server / Web / Mobile
  ↓
API dan Database
  ↓
Implementasi
  ↓
Pengujian
```

Buat matriks keterlacakan yang memungkinkan anggota tim mengetahui:

- Proses TO-BE yang didukung.
- KF yang terkait.
- Use Case yang terkait.
- Skenario yang terkait.
- Endpoint yang terkait.
- Halaman Web yang terkait.
- Screen Mobile yang terkait.
- Entitas database yang terkait.
- Status implementasi.

Jangan memaksakan hubungan jika tidak ada dasar.

Jika sebuah Use Case tidak berkaitan langsung dengan satu proses TO-BE tertentu, tandai sebagai fungsi pendukung atau lintas proses sesuai dokumen sumber.

Buat daftar gap dan konflik secara eksplisit.

---

## 9. TAHAP KEENAM — ATURAN PERUBAHAN DAN KOORDINASI TIM

Buat aturan agar tiga anggota dapat bekerja secara paralel tanpa merusak scope satu sama lain.

### Aturan wajib

1. Setiap anggota memiliki tanggung jawab utama sesuai scope.
2. Perubahan lintas aplikasi harus dikomunikasikan.
3. Perubahan kontrak API harus didokumentasikan oleh Server.
4. Client tidak boleh mengasumsikan endpoint yang belum tersedia.
5. Server tidak boleh mengubah kebutuhan UI tanpa koordinasi dengan client.
6. Perubahan database harus memperhatikan kebutuhan kedua client.
7. Perubahan Use Case, KF, atau TO-BE harus memperbarui traceability.
8. Setiap perubahan penting harus dicatat di `DECISION-LOG.md`.
9. Perubahan implementasi harus disertai pengujian yang relevan.
10. Jangan menghapus fitur hanya karena tidak ditemukan pada satu dokumen. Periksa keterkaitannya dengan kebutuhan target.

### Aturan keamanan perubahan

Sebelum melakukan perubahan source code:

- Periksa Git status.
- Identifikasi file yang akan diubah.
- Pastikan perubahan sesuai scope.
- Jangan menimpa pekerjaan lokal anggota lain.
- Jangan menghapus file yang tidak dipahami.
- Jangan mengubah konfigurasi sensitif.
- Jangan menampilkan atau menyalin secret ke dokumentasi.

Dokumentasi ini tidak memberikan izin untuk mengubah source code secara otomatis.

---

## 10. TAHAP KETUJUH — VALIDASI HASIL

Setelah semua dokumen dan rancangan dibuat:

1. Pastikan struktur folder sesuai.
2. Pastikan seluruh file instruksi saling konsisten.
3. Pastikan referensi yang disalin tidak berubah.
4. Pastikan seluruh referensi memiliki indeks.
5. Pastikan tidak ada file sumber lama yang terhapus atau tertimpa.
6. Pastikan diagram Mermaid dapat dirender secara sintaksis.
7. Pastikan file Draw.io valid dan dapat dibuka.
8. Pastikan diagram aktual dan target tidak tercampur.
9. Pastikan tidak ada endpoint, class, method, atau tabel fiktif yang diberi label aktual.
10. Pastikan semua asumsi dan gap memiliki dokumentasi.

Jangan menjalankan migrasi, mengubah database, menjalankan seeder, atau memodifikasi source code aplikasi sebagai bagian dari tugas dokumentasi ini.

Jangan melakukan commit atau push Git.

---

## 11. HASIL AKHIR YANG WAJIB DILAPORKAN

Setelah selesai, tampilkan laporan ringkas berisi:

### A. Struktur yang dibuat
Daftar folder dan file dokumentasi yang berhasil dibuat.

### B. Referensi
Daftar referensi yang disalin, lokasi penyimpanan, serta referensi yang tidak berhasil dibaca.

### C. Audit implementasi
Ringkasan kondisi Server, Web, dan Mobile.

### D. Rancangan Server
Ringkasan ERD dan Class Diagram, termasuk jumlah class aktual dan usulan jika dapat dihitung.

Sebutkan lokasi file Mermaid dan Draw.io.

### E. Rancangan Client Web
Ringkasan Sitemap, UI/UX, User Flow, dan halaman.

### F. Rancangan Client Mobile
Ringkasan Navigation Map, Screen Flow, UI/UX, dan screen.

### G. Gap dan keputusan
Daftar ketidaksesuaian, asumsi, dan keputusan yang masih membutuhkan persetujuan pemilik proyek atau tim.

### H. Validasi
Daftar pemeriksaan yang berhasil dan yang belum berhasil.

---

## 12. PRINSIP UTAMA — JANGAN DILANGGAR

- Jangan mengarang isi referensi.
- Jangan menganggap implementasi lama sudah sama dengan rancangan target.
- Jangan menganggap rancangan target sudah diimplementasikan.
- Jangan mengubah file sumber referensi.
- Jangan mengubah source code aplikasi dalam pekerjaan dokumentasi ini.
- Jangan menghapus atau menimpa pekerjaan anggota tim.
- Jangan membuat endpoint, class, method, tabel, atau fitur aktual yang tidak ditemukan.
- Jangan menghilangkan kebutuhan Use Case hanya karena implementasinya belum tersedia.
- Jangan memaksakan semua Use Case menjadi bagian dari satu proses TO-BE.
- Jangan mencampur scope Server, Web, dan Mobile.
- Jangan menyembunyikan ketidaksesuaian.
- Jangan mengisi informasi yang belum diketahui dengan asumsi tanpa penanda.

**Pisahkan secara tegas tiga kategori informasi:**

1. `AS-IMPLEMENTED` — terbukti tersedia pada source code.
2. `TARGET` — kebutuhan atau rancangan sistem yang telah ditetapkan.
3. `PROPOSED / ASSUMPTION` — usulan teknis untuk memenuhi target yang belum tersedia atau belum diputuskan.

Jika terdapat ketidakpastian yang berdampak pada keputusan arsitektur, dokumentasikan dan tandai untuk konfirmasi. Jangan mengambil keputusan bisnis sendiri.

---

## 13. CARA MEMULAI PEKERJAAN

Mulai dengan audit repository dan referensi secara menyeluruh.

Kerjakan secara bertahap:

1. Audit dan inventarisasi.
2. Susun source-of-truth dan hierarki referensi.
3. Buat struktur `project-docs`.
4. Salin referensi yang relevan.
5. Buat instruksi global.
6. Buat instruksi khusus tiga scope.
7. Buat analisis dan rancangan awal setiap scope.
8. Buat diagram ERD dan Class Diagram dalam Mermaid serta Draw.io.
9. Buat traceability dan gap analysis.
10. Validasi seluruh hasil.

**Jangan berhenti setelah membuat struktur folder atau file AGENTS.md kosong.**

Selesaikan pekerjaan dokumentasi dan rancangan awal sejauh didukung bukti yang tersedia.

Jika terdapat batasan waktu, ukuran konteks, atau keterbatasan pembacaan dokumen, prioritaskan akurasi, catat pekerjaan yang belum selesai, dan jangan mengklaim pekerjaan telah selesai.

Mulai sekarang dari repository:

`/mnt/Projects/Laravel/Motifnesia`

Pastikan semua hasil baru berada di dalam repository tersebut, khususnya pada:

`/mnt/Projects/Laravel/Motifnesia/project-docs/`

Jaga source code ketiga aplikasi tetap aman dan tidak berubah selama pekerjaan dokumentasi ini.
