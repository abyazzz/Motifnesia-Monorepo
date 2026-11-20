# Log keputusan dan konflik

## Acuan yang dipakai

| ID | Keputusan dan dasar | Dampak |
| --- | --- | --- |
| D-01 | TO-BE revisi §2–5 dipakai untuk proses dan RB. TA §2.5.3 dan §3.2 memakai 18 KF serta 64 UC dan skenario. | Urutan, ID, dan keterlacakan memakai dokumen sesuai domain. |
| D-02 | TO-BE §6 menyebut UC-51 sebagai moderasi lama. TA §3.2.2 mengubahnya menjadi pengelolaan ulasan terbit dengan aksi hapus. Publikasi langsung tetap berlaku menurut RB-19. | Pertahankan UC-51 dengan cakupan skenario akhir. Audit tindakan moderasi lama untuk migrasi fitur. |
| D-03 | Draft Mobile berfokus pada Guest/Customer. Platform Flutter sekarang juga memuat admin/supplier, dan mandat mengaudit semua route. | Dokumentasikan semua layar aktual. Porsi admin dalam target rilis mobile tetap memerlukan persetujuan tim. |
| D-04 | Working Guidelines 1.0 membagi peran alat riset. Prompt proyek membagi tiga anggota menurut aplikasi. | Prinsip validasi bukti tetap dipakai. Kepemilikan engineering mengikuti tiga scope. |
| D-05 | Draft TA §2.1.2 memakai istilah Admin Toko dan Staf Toko. Daftar UC akhir dan TO-BE mengenal sub-role admin. | Rancangan akses target memakai aktor per UC. Istilah AS-IS tetap dipakai pada deskripsi toko. |
| D-06 | ERD aktual diturunkan dari migration `up()` dan relasi model. Route terdaftar diamati tanpa menjalankan migrasi. | Status instalasi database aktif, data historis, dan hasil runtime perlu verifikasi terpisah. |

## Keputusan yang masih terbuka

| ID | Pertanyaan untuk pemilik proyek dan tim | Dasar |
| --- | --- | --- |
| O-01 | Vendor gateway, zona waktu bisnis untuk 23.59, callback terlambat, validasi callback, retry/idempotensi, dan rekonsiliasi. | TO-BE §5, RB-05–RB-09, UC-16/20–23 |
| O-02 | Penomoran/versi PO, pembatalan setelah dikirim, penerimaan berlebih, dan transisi dari login supplier aktif. | TO-BE §5, RB-02/10, UC-28–33 |
| O-03 | Bukti dan akses refund, aturan biaya/kondisi retur, video, serta kapan dan berapa poin dibalik. | TO-BE §5, RB-12–18, UC-39–46 |
| O-04 | Yang dirilis di tiap client, termasuk cakupan admin di Mobile, serta urutan transisi Gate untuk kedua client. | TA 64 UC, draft Mobile dan audit route |
| O-05 | Teknologi chat real-time, layanan email dan retry broadcast, retensi/penghapusan notifikasi, serta format periode/ekspor laporan. | TO-BE §5, UC-47/58–64 |
| O-06 | Rasio poin, kedaluwarsa poin dan voucher, histori reward, serta mekanisme konfigurasi program membership. | TO-BE §5, KF-16, UC-52–57 |
| O-07 | Mekanisme pemulihan melalui email, umur token dan sesi yang akan dicabut, serta kebijakan soft-deactivate akun/produk. | UC-03/07/08/13 |
| O-08 | Transformasi histori metode bayar, mode akses bukti lama, retensi portal lama, dan penghapusan ulasan terbit tanpa merusak audit. | RB-02/05/19, UC-51, data aktual |
| O-09 | Relasi KF dan proses yang berbeda arah pada TA §2.5.3 dan §3.2.1, termasuk pemetaan multi-KF dan cakupan lintas proses. | [Keterlacakan](TRACEABILITY-MATRIX.md) |

Keputusan teknis di rancangan dengan label `PROPOSED` menunggu review scope terkait. Keputusan bisnis mengikuti pemilik proyek. [Matriks sumber](SOURCE-OF-TRUTH.md) · [TO-BE §5](references/PERANCANGAN%20FINAL%20PROSES%20BISNIS%20TO-BE%20MOTIFNESIA.md)
