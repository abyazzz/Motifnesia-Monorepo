# Aturan kerja bersama

## Kepemilikan dan review

| Scope | Pemilik tanggung jawab | Perubahan yang perlu ditinjau bersama |
| --- | --- | --- |
| Server | Anggota Server | Endpoint, status, skema, aturan bisnis, otorisasi, dan migrasi data |
| Client Web | Anggota Web | Alur browser, kontrak form, tampilan per role, dan kompatibilitas API |
| Client Mobile | Anggota Mobile | Navigasi Flutter, penyimpanan sesi, UX layar kecil, dan kompatibilitas API |

Penanggung jawab perubahan menyertakan UC/KF/aturan bisnis, bagian kontrak yang terpengaruh, file atau data yang berubah, dampak ke client, dan bukti verifikasi. Untuk perubahan lintas aplikasi, bahas rencana urutan rilis, transisi data dan penanganan client lama dengan anggota terkait. Simpan keputusan penting dan penanggung jawab tindak lanjut di [log keputusan](DECISION-LOG.md).

Lihat [hierarki instruksi](INSTRUCTION-HIERARCHY.md), [review desain](../01-SERVER/analysis/DESIGN-REVIEW.md), dan [analisis scope Mobile](../03-CLIENT-MOBILE/analysis/RELEASE-SCOPE-DECISION.md) sebelum mengubah area terkait.

Scope bisnis kedua client adalah 1:1. Catat perbedaan platform pada layout, navigasi, interaksi, dan UX. Uji role dan kemampuan yang sama pada Web dan Mobile. [Matriks kesetaraan](../PARITAS-WEB-MOBILE.md)

## Kontrak, keamanan, dan data

- Server mendokumentasikan method, path, autentikasi, izin dan kepemilikan, payload, bentuk respons, status code, serta perilaku pagination dan multipart. Pertahankan kompatibilitas endpoint yang digunakan atau sepakati migrasi versi dengan kedua client.
- Gunakan validasi server sebagai acuan. Terapkan pemeriksaan terhadap pengguna dan objek target di setiap aksi. Cegah perpindahan state yang tidak sah, duplikasi hasil akibat retry, dan akses bukti transaksi lintas akun.
- Lakukan perubahan stok, pembayaran, retur, dan poin dengan transaksi serta penguncian sesuai risiko konkurensi. Kaitkan perubahan ke order, item, aktor, atau bukti yang relevan.
- Bukti pembayaran dan retur menggunakan akses per role atau kepemilikan. Jangan tampilkan isi bukti, data pribadi, atau nilai kredensial dalam pengujian, satuan contoh, log, atau dokumen.
- Jaga data lingkungan bersama. Tinjau migrasi, rollback atau strategi perbaikan data dan pemeriksaan integritas pada snapshot pengembangan terisolasi sebelum membuat perubahan yang memengaruhi data.

## Pemeriksaan dan pembaruan dokumentasi

1. Identifikasi requirement dan skenario. Ambil bukti implementasi sebelum menyimpulkan status.
2. Uji jalur normal, input keliru, akses terlarang, kegagalan jaringan, retry, dan konsistensi data sesuai perubahan.
3. Untuk perubahan integrasi, cek kontrak di Server dan konsumsi di Web serta Mobile. Catat pengujian yang tersedia dan pengujian yang betul-betul telah dijalankan.
4. Perbarui desain, indeks API, matriks, gap, dan catatan keputusan sesuai perubahan. Sertakan konflik, batas, dan kebutuhan yang belum terverifikasi. Fitur lama tetap dievaluasi melalui traceability sebelum keputusan penghapusan.
