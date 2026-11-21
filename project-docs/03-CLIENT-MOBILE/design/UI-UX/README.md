# UI/UX Mobile

Pertahankan bahasa visual MotifNesia dan informasi yang dibagikan dengan Web. Gunakan pola Flutter Material dengan target sentuh yang cukup, navigasi bawah untuk fitur Customer yang sering dipakai, dan daftar menu per role. Layar admin memakai kartu dan halaman detail. Tindakan sekunder dapat masuk sheet kontekstual supaya viewport sempit tetap fokus.

- Padding area aman, scroll konten, tampilan keyboard, orientasi, dan skala teks perlu diperiksa pada Android/iOS. Pada browser lebar gunakan batas lebar konten dan grid adaptif.
- Form memberi label, jenis keyboard sesuai, pesan validasi per field, dan ringkasan aksi. Pertahankan pilihan ukuran/alamat ketika memungkinkan.
- Tombol bayar menampilkan hasil server, state pending juga setelah kembali dari aplikasi pembayaran. Simpan konteks bila koneksi terputus dan beri tindakan refresh yang aman.
- Pemilihan foto atau video mengikuti kontrak unggah dan izin platform. Preview bukti privat mengikuti hak akses dan tidak disimpan sebagai tautan yang dapat dibagikan.
- Navigasi kembali mempertahankan konteks filter. Jika sesi habis, tampilkan jalur login dan tujuan hanya bila akses terverifikasi.

[Spesifikasi layar](../SCREEN-SPECIFICATION/README.md) · [Navigasi per role](../NAVIGATION/README.md)

[Design system](design-system.md) · [Wireframe](wireframes/README.md) · [Review](review/WIREFRAME-REVIEW.md)
