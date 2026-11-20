# Tes browser Motifnesia

Jalankan dari folder `Motifnesia` dengan PHP, Node.js 18 atau lebih baru, Google Chrome, dan aset client yang sudah dibangun.

```bash
node tests/browser/run.mjs
```

Gunakan `MOTIFNESIA_CHROME` bila executable Chrome berada di lokasi lain. Suite memakai dua port loopback yang tersedia, profil Chrome baru, SQLite sementara, dan mailer `array`. Tes mencakup login per peran, checkout dengan unggahan bukti, akses bukti berdasarkan peran, persetujuan pengadaan supplier, penerapan stok gudang, dan render katalog mobile. Screenshot tersimpan di folder sementara yang dicetak setelah tes.

Chrome dan Firefox gagal dimulai di sandbox sesi ini. Chrome melaporkan `setsockopt: Operation not permitted` sebelum mengirim respons DevTools, jadi suite belum mencapai navigasi halaman.
