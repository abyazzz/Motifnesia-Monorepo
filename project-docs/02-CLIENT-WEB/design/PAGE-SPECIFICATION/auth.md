# Autentikasi · Client Web

Data, aksi dan route awal berasal dari kode. Panduan keadaan layar dan responsivitas memberi kriteria desain. Rancangan target mengikuti skenario dan menunggu penyelarasan kontrak untuk gap. [Indeks](README.md)

## Halaman 01

### Masuk

**Route AS-IMPLEMENTED** `/login` · **Aktor saat ini** Guest / sesi anonim. [login.blade.php](../../../../Motifnesia-Client-Web/resources/views/auth/login.blade.php)

- Tujuan dan informasi. Identitas, sandi, informasi sesi, pesan penolakan.
- Komponen. Form dan tombol navigasi autentikasi.
- Aksi aktual. Masuk, buka reset/registrasi, lanjut ke tujuan role atau katalog.
- Jejak target. [UC-01](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-01).
- Validasi dan keadaan kosong. Input wajib, server verifikasi kredensial/status. Kosong tampilkan form siap diisi.
- Loading. Saat submit, tampilkan progres di form dan cegah kirim ganda.
- Error. Tampilkan pesan aman dari API per field atau pada form. Pilih jalur login/registrasi/reset sesuai respons.
- Responsivitas dan perilaku UI. Form satu kolom pada viewport sempit dengan label dan pesan per field. Jaga fokus setelah validasi.
- Rancangan target. Gunakan pesan akun nonaktif sesuai kontrak. Pertahankan redirect aman ke path internal.

Form GET dirender di Web. Sesi aktif diperiksa melalui [`GET /viewer`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-117). Aksi dan data pendukung. [`POST /login`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-078), [`GET /viewer`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-117).

## Halaman 02

### Daftar Akun

**Route AS-IMPLEMENTED** `/register` · **Aktor saat ini** Guest / sesi anonim. [register.blade.php](../../../../Motifnesia-Client-Web/resources/views/auth/register.blade.php)

- Tujuan dan informasi. Form akun dan pertanyaan pemulihan.
- Komponen. Form dan tombol navigasi autentikasi.
- Aksi aktual. Daftar, kembali ke login, verifikasi isian sebelum kirim.
- Jejak target. [UC-02](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-02).
- Validasi dan keadaan kosong. Username/email unik, konfirmasi sandi, pertanyaan dan jawaban sesuai server. Kosong tampilkan form.
- Loading. Saat submit, tampilkan progres di form dan cegah kirim ganda.
- Error. Tampilkan pesan aman dari API per field atau pada form. Pilih jalur login/registrasi/reset sesuai respons.
- Responsivitas dan perilaku UI. Form satu kolom pada viewport sempit dengan label dan pesan per field. Jaga fokus setelah validasi.
- Rancangan target. Skema pemulihan melalui email dapat mengubah field keamanan setelah kontrak UC-03 disepakati.

Form GET dirender di Web. Sesi aktif diperiksa melalui [`GET /viewer`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-117). Aksi dan data pendukung. [`POST /register`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-105).

## Halaman 03

### Atur Ulang Sandi

**Route AS-IMPLEMENTED** `/forgot` · **Aktor saat ini** Guest / sesi anonim. [forgot.blade.php](../../../../Motifnesia-Client-Web/resources/views/auth/forgot.blade.php)

- Tujuan dan informasi. Identitas dan pemulihan kata sandi.
- Komponen. Form dan tombol navigasi autentikasi.
- Aksi aktual. Pilih pertanyaan, jawab, isi sandi baru atau kembali.
- Jejak target. [UC-03](../../../00-GLOBAL/TRACEABILITY-MATRIX.md#uc-03).
- Validasi dan keadaan kosong. Identitas, jawaban dan konfirmasi sandi divalidasi server. Kosong tampilkan langkah awal.
- Loading. Saat submit, tampilkan progres di form dan cegah kirim ganda.
- Error. Tampilkan pesan aman dari API per field atau pada form. Pilih jalur login/registrasi/reset sesuai respons.
- Responsivitas dan perilaku UI. Form satu kolom pada viewport sempit dengan label dan pesan per field. Jaga fokus setelah validasi.
- Rancangan target. PROPOSED alur kirim email, verifikasi token, konfirmasi sandi, lalu ke login.

Form GET dirender di Web. Sesi aktif diperiksa melalui [`GET /viewer`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-117). Aksi dan data pendukung. [`POST /forgot`](../../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-076).
