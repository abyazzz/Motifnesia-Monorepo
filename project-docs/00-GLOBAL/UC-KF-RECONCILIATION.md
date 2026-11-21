# Rekonsiliasi UC dan KF — Phase 3

Bukti diperiksa langsung pada teks dan tabel dokumen TA asli §2.5.3, §3.2.1 dan §3.2.2, lalu dibandingkan dengan TO-BE dan matriks. Relasi banyak-ke-banyak diperbolehkan. Klasifikasi analitis di bawah membedakan realisasi langsung, dukungan, dan invarian. Ketidakpastian tetap membutuhkan konfirmasi. Isi sumber dipertahankan. [TA asli salinan](references/Muhammad%20Abyaz%20Zaydan-Tugas%20Akhir_Lengkap_64_Use_Case.docx) · [TO-BE](references/PERANCANGAN%20FINAL%20PROSES%20BISNIS%20TO-BE%20MOTIFNESIA.md) · [Matriks](TRACEABILITY-MATRIX.md)

<a name="uc-15"></a>

## UC-15 Mengelola Alamat Pengiriman

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-15 Mengelola Alamat Pengiriman |
| Proses TO-BE | 2.3.3 Pemesanan dan Pengelolaan Transaksi |
| TA §2.5.3 | KF-11 |
| TA §3.2.1 | KF-06, KF-11 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-06, KF-11 dengan dua arah dicatat |
| Skenario normal | 1 → Customer meminta daftar alamatnya. → Backend mengambil alamat yang terkait dengan akun.; 2 → Customer mengirim alamat baru, perubahan, penghapusan atau pilihan alamat utama. → Backend memvalidasi data dan memeriksa kepemilikan alamat.; 3 → Customer mengonfirmasi tindakan. → Backend menerapkan perubahan dan mengembalikan daftar atau status terbaru. |
| Skenario alternatif | 2.a → Data alamat tidak valid. → Backend menolak perubahan.; 2.b → Alamat bukan milik customer. → Backend menolak akses. |
| Aturan bisnis terkait | RB-03 |
| Analisis | Alamat dikelola sebagai profil dan juga menjadi data untuk pemenuhan. KF-06 dapat dipandang sebagai hubungan pendukung, bukan aksi pengiriman. |
| Rekomendasi PROPOSED | KF-11, KF-06 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | VERIFIED — klasifikasi berdasarkan skenario, pemetaan sumber berbeda dicatat |

| Direct | KF-11 |
| Supporting | KF-06 |
| Invariant / Constraint | — |
| Analisis Phase 3 | Alamat adalah data profil; KF-06 mendukung penggunaan alamat dalam pengiriman. |

<a name="uc-16"></a>

## UC-16 Membuat Pesanan / Checkout

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-16 Membuat Pesanan / Checkout |
| Proses TO-BE | 2.3.3 Pemesanan dan Pengelolaan Transaksi |
| TA §2.5.3 | KF-03, KF-04 |
| TA §3.2.1 | KF-04, KF-05 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-03, KF-04, KF-05 dengan dua arah dicatat |
| Skenario normal | 1 → Customer memilih barang dan alamat lalu meminta ringkasan checkout. → Sistem memeriksa kepemilikan, produk, jumlah, alamat dan harga serta menampilkan ringkasan.; 2 → Customer mengonfirmasi checkout. → Sistem memeriksa kembali ketersediaan, lalu mencatat pesanan dan mereservasi stok secara konsisten agar unit yang sama tidak dipesan dua kali.; 3 → Customer menerima hasil checkout. → Sistem mengirim hasil: pesanan Menunggu Pembayaran beserta rinciannya, stok tersedia yang telah berkurang dan tenggat pukul 23.59 tanggal checkout.; 4 → Customer meminta informasi untuk membayar. → Sistem menyediakan identitas pesanan untuk memulai pembayaran melalui UC-20. |
| Skenario alternatif | 1.a → Customer mengirim keranjang kosong, alamat tidak sah atau jumlah tidak valid. → Sistem menolak checkout dan menjelaskan data yang perlu diperbaiki.; 2.a → Customer mengonfirmasi ketika stok tidak mencukupi atau harga telah berubah. → Sistem menolak checkout dengan data lama dan menyampaikan kondisi yang relevan tanpa membuat reservasi.; 2.b → Dua Customer bersamaan meminta unit terakhir. → Hanya checkout yang berhasil memesan unit tersebut memperoleh reservasi; permintaan lain ditolak karena stok tidak lagi tersedia.; 3.a → Pencatatan pesanan atau reservasi gagal. → Sistem tidak meninggalkan pesanan berhasil dengan stok yang tidak sesuai dan menyampaikan kegagalan. |
| Aturan bisnis terkait | RB-06, RB-08, RB-09 |
| Analisis | Checkout menyimpan pesanan dan mereservasi stok. Pembayaran adalah tahap berikutnya dan skenario memuat tenggat. Pertimbangkan KF-05 sebagai keterkaitan pendukung. |
| Rekomendasi PROPOSED | KF-03, KF-04, KF-05 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | VERIFIED — klasifikasi berdasarkan skenario, pemetaan sumber berbeda dicatat |

| Direct | KF-04, KF-03 |
| Supporting | KF-05 |
| Invariant / Constraint | — |
| Analisis Phase 3 | Checkout membentuk order dan reservasi. Tenggat pembayaran mendukung proses; pemrosesan gateway ada pada UC-20–22. |

<a name="uc-19"></a>

## UC-19 Mengelola Pesanan

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-19 Mengelola Pesanan |
| Proses TO-BE | 2.3.3 Pemesanan dan Pengelolaan Transaksi |
| TA §2.5.3 | KF-03, KF-04, KF-16 |
| TA §3.2.1 | KF-04, KF-16 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-03, KF-04, KF-16 dengan dua arah dicatat |
| Skenario normal | 1 → Customer mengajukan pembatalan pesanan miliknya yang sudah dibayar dengan menyertakan alasan. → Sistem memeriksa kepemilikan dan status pesanan, lalu menyimpan permohonan beserta alasan.; 2 → Admin Kasir atau Super Admin Owner meminta daftar atau detail permohonan pembatalan. → Sistem memeriksa kewenangan dan menampilkan permohonan, alasan Customer, serta status pesanan dan pembayaran secara terpisah.; 3 → Admin meninjau alasan dan menyetujui permohonan melalui tindakan persetujuan. → Sistem mencatat persetujuan, membatalkan pesanan, menyimpan riwayat dan mengirim notifikasi kepada Customer bahwa pembatalan disetujui serta dana akan dikembalikan; reservasi yang masih melekat dilepaskan satu kali dan poin yang pernah diberikan serta belum dibalik ditangani sesuai ketentuan.; 4 → Admin meninjau hasil persetujuan. → Sistem menampilkan status pembatalan yang telah dicatat; transfer refund dilakukan secara manual di luar sistem. |
| Skenario alternatif | 1.a → Permohonan tidak menyertakan alasan, pesanan bukan milik Customer, atau status tidak memenuhi ketentuan. → Sistem menolak permohonan dan tidak membatalkan pesanan.; 2.a → Admin meminta perubahan tanpa hak atau transisi yang tidak diperbolehkan. → Sistem menolak dan mempertahankan data.; 2.b → Tenggat pukul 23.59 tanggal checkout tercapai sementara pesanan belum dibayar. → Pemicu waktu menyebabkan sistem membatalkan pesanan otomatis, mempertahankan riwayat dan melepaskan reservasi aktif pesanan itu satu kali.; 2.c → Pemicu pembatalan atau pelepasan stok diterima ulang. → Sistem tidak melepaskan reservasi dua kali atau mengembalikan stok milik transaksi lain.; 2.d → Pesanan belum dibayar dibatalkan dan belum pernah menghasilkan poin. → Sistem tidak mengurangi poin Customer.; 2.e → Poin yang harus dibalik sudah digunakan. → Sistem mencatat kasus untuk penanganan sesuai kebijakan yang akan ditetapkan, tanpa menetapkan saldo atau penyelesaian baru.; 2.f → Admin meminta verifikasi bukti transfer pembayaran. → Sistem tidak menjalankan verifikasi manual; hasil pembayaran mengikuti UC-22.; 2.g → Admin mengelola perubahan pesanan lain yang diperbolehkan sesuai kewenangan. → Sistem memeriksa status dan dampaknya terhadap reservasi serta riwayat poin, lalu menyimpan perubahan yang dikonfirmasi dan riwayatnya.; 3.a → Permohonan pembatalan pesanan berbayar belum disetujui admin. → Sistem tidak membatalkan pesanan berdasarkan permohonan tersebut. |
| Aturan bisnis terkait | RB-08, RB-18 |
| Analisis | Pembatalan mengelola pesanan, pelepasan reservasi dan pembalikan poin. Ketiganya disebut dalam skenario. |
| Rekomendasi PROPOSED | KF-03, KF-04, KF-16 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | VERIFIED — klasifikasi berdasarkan skenario, pemetaan sumber berbeda dicatat |

| Direct | KF-04, KF-03, KF-16 |
| Supporting | — |
| Invariant / Constraint | — |
| Analisis Phase 3 | Pembatalan mencatat status, melepas reservasi dan membalik poin yang sudah diberikan. |

<a name="uc-22"></a>

## UC-22 Menerima Notifikasi Pembayaran

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-22 Menerima Notifikasi Pembayaran |
| Proses TO-BE | 2.3.3 Pemesanan dan Pengelolaan Transaksi |
| TA §2.5.3 | KF-05 |
| TA §3.2.1 | KF-03, KF-05 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-03, KF-05 dengan dua arah dicatat |
| Skenario normal | 1 → Payment Gateway mengirim notifikasi hasil pembayaran. → Sistem memvalidasi sumber, identitas transaksi, nominal, keterkaitan pesanan dan keadaan pembayaran.; 2 → Payment Gateway menyampaikan hasil berhasil yang sah sebelum tenggat untuk pesanan aktif. → Sistem mencatat pembayaran Berhasil/Lunas dan mengubah status pesanan menjadi Diproses tanpa mengurangi stok yang telah direservasi saat checkout untuk kedua kalinya.; 3 → Payment Gateway menerima tanggapan atas notifikasi. → Sistem mencatat pemrosesan dan menyampaikan hasil penerimaan tanpa menggandakan dampak transaksi. |
| Skenario alternatif | 1.a → Gateway mengirim notifikasi tidak sah atau transaksi dan pesanan tidak cocok. → Sistem tidak menyatakan pembayaran berhasil dan menolak atau menandai notifikasi untuk pemeriksaan.; 2.a → Gateway melaporkan pembayaran menunggu atau gagal secara sah. → Sistem mencatat status pembayaran yang relevan tanpa menyatakan pesanan lunas.; 2.b → Gateway mengirim notifikasi duplikat atau status gagal yang lebih lama setelah keberhasilan. → Sistem tidak menerapkan efek dua kali dan tidak menurunkan status pembayaran berhasil menjadi gagal.; 2.c → Gateway melaporkan pembayaran berhasil setelah pesanan dibatalkan karena tenggat dan reservasi dilepaskan. → Sistem tetap memvalidasi dan mencatat hasil pembayaran serta menandai kasus untuk rekonsiliasi; pesanan tidak otomatis diaktifkan kembali, refund tidak otomatis dinyatakan berhasil, dan transaksi pengganti tidak otomatis dibuat. |
| Aturan bisnis terkait | RB-08, RB-09 |
| Analisis | Skenario melarang pengurangan stok lagi saat callback. KF-03 relevan sebagai invarian persediaan, bukan aktivitas mutasi baru. |
| Rekomendasi PROPOSED | KF-05, KF-03 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | VERIFIED — klasifikasi berdasarkan skenario, pemetaan sumber berbeda dicatat |

| Direct | KF-05 |
| Supporting | — |
| Invariant / Constraint | KF-03 |
| Analisis Phase 3 | Callback memvalidasi hasil pembayaran dan menjaga agar stok yang telah direservasi tidak dikurangi kembali. |

<a name="uc-24"></a>

## UC-24 Menyiapkan dan Mengemas Pesanan

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-24 Menyiapkan dan Mengemas Pesanan |
| Proses TO-BE | 2.3.4 Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual |
| TA §2.5.3 | KF-03, KF-06 |
| TA §3.2.1 | KF-06 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-03, KF-06 dengan dua arah dicatat |
| Skenario normal | 1 → Aktor meminta daftar pesanan yang siap dipenuhi. → Backend memeriksa izin dan menyajikan item serta kuantitas pesanan yang relevan.; 2 → Aktor menyiapkan dan mengemas barang secara fisik. → Backend tidak melakukan kegiatan fisik dan menunggu pencatatan oleh aktor.; 3 → Aktor mengirim hasil pengemasan atau perubahan status. → Backend memvalidasi transisi dan menyimpan status beserta waktu dan pelaku. |
| Skenario alternatif | 3.a → Pesanan belum memenuhi syarat atau status telah berubah. → Backend menolak perubahan status dan mengembalikan kondisi terkini. |
| Aturan bisnis terkait | RB-25 |
| Analisis | Pengemasan mencatat penyiapan fisik, dan KF-03 mencantumkan UC-24. Periksa apakah pergerakan fisik dicatat oleh UC ini atau UC-35. |
| Rekomendasi PROPOSED | KF-06, KF-03 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | NEEDS OWNER CONFIRMATION |

| Direct | KF-06 |
| Supporting | — |
| Invariant / Constraint | KF-03 · NEEDS OWNER CONFIRMATION |
| Analisis Phase 3 | Skenario mencatat pengemasan dan status, tanpa menyebut mutasi stok. KF-03 mencantumkan UC-24; hubungan pencatatan keluar dengan UC-35 perlu konfirmasi. |

<a name="uc-42"></a>

## UC-42 Mencatat Penerimaan dan Pemeriksaan Produk Retur

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-42 Mencatat Penerimaan dan Pemeriksaan Produk Retur |
| Proses TO-BE | 2.3.4 Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual |
| TA §2.5.3 | KF-08 |
| TA §3.2.1 | KF-03, KF-08 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-03, KF-08 dengan dua arah dicatat |
| Skenario normal | 1 → Aktor menerima dan memeriksa barang retur secara fisik. → Backend menyediakan data pengajuan yang disetujui.; 2 → Aktor mengirim kondisi, jumlah dan hasil pemeriksaan. → Backend memvalidasi hak, status retur dan data pemeriksaan.; 3 → Aktor mencatat tindak lanjut stok sesuai kondisi. → Backend mencatat produk layak jual yang dimasukkan kembali ke stok tersedia dan pergerakannya; barang rusak tidak menambah stok tersedia. |
| Skenario alternatif | 2.a → Barang tidak sesuai pengajuan. → Backend mempertahankan kasus untuk peninjauan lebih lanjut.; 3.a → Barang rusak atau tidak layak jual. → Backend mencatat kondisinya tanpa menambah stok tersedia. |
| Aturan bisnis terkait | RB-12 |
| Analisis | Pemeriksaan retur mencatat kondisi, dan barang layak jual dapat masuk stok. KF-03 adalah dampak persediaan lintas proses. |
| Rekomendasi PROPOSED | KF-08, KF-03 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | VERIFIED — klasifikasi berdasarkan skenario, pemetaan sumber berbeda dicatat |

| Direct | KF-08, KF-03 |
| Supporting | — |
| Invariant / Constraint | — |
| Analisis Phase 3 | Pemeriksaan retur serta pencatatan penambahan stok layak jual dan pergerakannya termasuk langkah normal. |

<a name="uc-43"></a>

## UC-43 Menentukan Penyelesaian Retur

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-43 Menentukan Penyelesaian Retur |
| Proses TO-BE | 2.3.4 Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual |
| TA §2.5.3 | KF-08, KF-16 |
| TA §3.2.1 | KF-08 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-08, KF-16 dengan dua arah dicatat |
| Skenario normal | 1 → Admin meninjau hasil pemeriksaan dan meminta informasi ketersediaan. → Sistem menampilkan pengajuan, kondisi produk dan stok yang relevan.; 2 → Admin mencatat penyelesaian untuk produk cacat ketika produk yang sama tersedia. → Sistem mencatat penukaran produk yang sama sebagai tindak lanjut.; 3 → Admin mengonfirmasi keputusan. → Sistem menyimpan pilihan penyelesaian untuk diteruskan ke proses penukaran UC-44. |
| Skenario alternatif | 2.a → Produk yang sama tidak tersedia dan admin menawarkan produk alternatif di luar sistem. → Sistem mencatat alternatif yang ditawarkan berdasarkan informasi admin.; 2.b → Customer menerima alternatif dan admin mencatat persetujuan tersebut. → Sistem mencatat penukaran alternatif untuk ditindaklanjuti.; 2.c → Customer tidak bersedia menerima alternatif dan admin mencatat hasil komunikasi. → Sistem mencatat pilihan refund untuk ditindaklanjuti melalui UC-45.; 2.d → Customer belum memberikan keputusan. → Sistem mempertahankan proses menunggu tindak lanjut. |
| Aturan bisnis terkait | RB-15, RB-18 |
| Analisis | Memilih solusi retur termasuk KF-08. Reversal poin pada KF-16 tampak merupakan konsekuensi proses pembatalan/refund; perlu memastikan apakah keputusan UC-43 sendiri memicu perubahan poin. |
| Rekomendasi PROPOSED | KF-08 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | NEEDS OWNER CONFIRMATION |

| Direct | KF-08 |
| Supporting | — |
| Invariant / Constraint | KF-16 · NEEDS OWNER CONFIRMATION |
| Analisis Phase 3 | Keputusan retur sendiri tidak menyebut perubahan poin. KF-16 mencantumkan UC-43; RB-18 berlaku pada pembatalan atau refund, tetapi pemicunya perlu konfirmasi. |

<a name="uc-44"></a>

## UC-44 Memproses Penukaran Produk

| Elemen | Isi |
| --- | --- |
| ID dan nama | UC-44 Memproses Penukaran Produk |
| Proses TO-BE | 2.3.4 Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual |
| TA §2.5.3 | KF-08, KF-16 |
| TA §3.2.1 | KF-03, KF-08 |
| Matriks Phase 2 sebelum klasifikasi | Gabungan KF-03, KF-08, KF-16 dengan dua arah dicatat |
| Skenario normal | 1 → Aktor memeriksa dan menentukan produk pengganti secara manual sesuai hasil retur. → Backend menyediakan data keputusan retur dan mencatat informasi pengganti yang dikirim aktor.; 2 → Aktor menyiapkan produk pengganti dan mengirimkannya secara manual di luar sistem. → Backend tidak melakukan pengiriman secara otomatis.; 3 → Aktor mencatat pengeluaran produk dan status penyelesaian. → Backend mencatat pergerakan stok keluar produk pengganti satu kali serta status penukaran tanpa menggandakan pergerakan. |
| Skenario alternatif | 2.a → Produk pengganti belum tersedia atau belum disepakati. → Backend mempertahankan proses menunggu tindak lanjut.; 2.b → Data penukaran tidak valid. → Backend menolak perubahan. |
| Aturan bisnis terkait | RB-12, RB-18 |
| Analisis | Penukaran berkaitan dengan stok dan retur. KF-16 mencantumkan UC-44, namun perlu konfirmasi kondisi pembalikan poin dalam penukaran. |
| Rekomendasi PROPOSED | KF-08, KF-03 dengan hubungan langsung dan pendukung dikonfirmasi. |
| Status | NEEDS OWNER CONFIRMATION |

| Direct | KF-08, KF-03 |
| Supporting | — |
| Invariant / Constraint | KF-16 · NEEDS OWNER CONFIRMATION |
| Analisis Phase 3 | Penukaran mencatat pengeluaran stok produk pengganti. Skenario tidak menyebut pembalikan poin; kaitan KF-16 pada penukaran perlu konfirmasi. |

## Pertanyaan keputusan

1. Apakah KF pendukung dan invarian dicatat sebagai relasi UC setara atau diberi jenis hubungan tersendiri, terutama UC-15, UC-16 dan UC-22?
2. Apakah UC-24 mencatat pergerakan stok atau menyerahkan pencatatannya ke UC-35?
3. Apakah pemilihan resolusi UC-43 atau penukaran UC-44 dapat memicu reversal poin, dan kapan aturan RB-18 berlaku?

Setelah keputusan, sinkronkan matriks dan kedua bagian TA secara terkontrol.

## Konflik nama dalam instruksi Phase 3

Instruksi terbaru menyebut UC-42 sebagai Ajukan Retur, UC-43 sebagai Meninjau dan Memutuskan Retur, serta UC-44 sebagai Menangani Hasil Pemeriksaan Retur. TA §3.2.1–3.2.2 memakai UC-39 Mengajukan Retur Produk, UC-42 Mencatat Penerimaan dan Pemeriksaan Produk Retur, UC-43 Menentukan Penyelesaian Retur, dan UC-44 Memproses Penukaran Produk. Analisis menggunakan ID dan nama TA yang tersimpan. **NEEDS OWNER CONFIRMATION** apakah nama pada instruksi merupakan rujukan informal atau perubahan resmi kebutuhan.
