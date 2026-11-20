# Indeks skenario Use Case TARGET

Ringkasan indeks memakai aktor, prasyarat, hasil, dan alternatif dari TA §3.2.2. Skenario lengkap, termasuk pembagian aksi, tersedia pada dokumen sumber. [TA 64 UC](references/Muhammad%20Abyaz%20Zaydan-Tugas%20Akhir_Lengkap_64_Use_Case.docx)

## UC-01 Login

**Aktor** Customer, Super Admin Owner, Admin Finance, Admin Kasir, Admin Gudang  
**Prasyarat** Akun telah terdaftar dan aktif; aktor belum terautentikasi.  
**Hasil** Identitas berhasil diautentikasi dan client menerima respons beserta sarana autentikasi yang berlaku.

Langkah utama. Backend memvalidasi input dan mencari akun → Backend memeriksa kredensial serta status akun dan membentuk sesi atau token sesuai mekanisme client yang ditetapkan → Backend mengirim hasil autentikasi dan informasi hak akses yang relevan.

Alternatif. 1.a Identitas atau kata sandi tidak valid.; 2.a Akun nonaktif atau akses ditolak.

## UC-02 Registrasi Akun

**Aktor** Guest  
**Prasyarat** Guest belum memiliki akun dengan identitas yang digunakan.  
**Hasil** Akun customer tersimpan dan respons pendaftaran dikirim.

Langkah utama. Backend memvalidasi kelengkapan, format, dan keunikan identitas → Backend menyimpan akun sebagai customer dan melindungi kata sandi → Backend mengirim status pendaftaran serta informasi tindak lanjut autentikasi.

Alternatif. 1.a Data tidak valid atau identitas telah digunakan.

## UC-03 Mengatur Ulang Kata Sandi

**Aktor** Guest, Customer, Super Admin Owner, Admin Finance, Admin Kasir, Admin Gudang  
**Prasyarat** Akun memiliki alamat email yang dapat digunakan dan layanan pemulihan tersedia.  
**Hasil** Kata sandi akun berubah setelah verifikasi pemulihan melalui email; sistem mengirim hasil kepada client.

Langkah utama. Backend memvalidasi permintaan dan mengirim instruksi pemulihan melalui email tanpa mengungkap keberadaan akun secara tidak perlu → Backend memeriksa validitas bukti pemulihan sesuai ketentuan pemulihan → Backend memvalidasi dan menyimpan hash kata sandi, menyelesaikan permintaan, dan mengirim respons.

Alternatif. 1.a Layanan email tidak dapat memproses permintaan.; 2.a Bukti pemulihan tidak sah atau tidak berlaku.; 3.a Kata sandi baru tidak memenuhi validasi.

## UC-04 Logout

**Aktor** Customer, Super Admin Owner, Admin Finance, Admin Kasir, Admin Gudang  
**Prasyarat** Aktor telah login menggunakan sesi atau token yang berlaku.  
**Hasil** Sesi atau token yang relevan tidak lagi berlaku untuk akses berikutnya.

Langkah utama. Backend mengidentifikasi sesi atau token aktif → Backend membatalkan sesi atau token terkait dan mengirim respons keberhasilan.

Alternatif. 1.a Kredensial sesi atau token sudah tidak berlaku.

## UC-05 Melihat Profil

**Aktor** Customer  
**Prasyarat** Customer telah terautentikasi.  
**Hasil** Data profil milik customer dikembalikan kepada client.

Langkah utama. Backend memverifikasi identitas dan mengambil profil yang terhubung dengan akun → Backend mengirim data profil yang diizinkan tanpa membocorkan kredensial.

Alternatif. 1.a Sesi tidak sah atau profil tidak ditemukan.

## UC-06 Mengelola Profil

**Aktor** Customer  
**Prasyarat** Customer telah login dan memiliki profil yang dapat diperbarui.  
**Hasil** Perubahan profil yang valid tersimpan pada akun customer.

Langkah utama. Backend mengembalikan data milik akun yang terautentikasi → Backend memvalidasi format, keunikan jika diperlukan, dan kepemilikan akun → Backend menyimpan perubahan dan mengirim respons profil terbaru.

Alternatif. 2.a Data tidak valid atau konflik dengan akun lain.; 2.b Aktor mencoba mengubah akun lain.

## UC-07 Mengelola Pengguna dan Hak Akses

**Aktor** Super Admin Owner  
**Prasyarat** Super Admin Owner terautentikasi dan akun sasaran adalah salah satu dari tiga peran admin yang boleh dikelola.  
**Hasil** Perubahan akun atau hak akses yang sah tersimpan dan memiliki catatan pelaku.

Langkah utama. Backend memverifikasi peran dan mengirim daftar akun yang boleh dikelola → Backend memvalidasi identitas dan memastikan akun target bukan Super Admin Owner lain → Backend menyimpan perubahan yang diperbolehkan serta riwayat tindakan dan mengirim respons.

Alternatif. 2.a Aktor mencoba mengelola akun Super Admin Owner lain.; 2.b Data tidak valid atau aktor tidak berwenang.

## UC-08 Mengelola Data Pelanggan

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Admin Kasir atau Super Admin Owner telah login.  
**Hasil** Data atau status pelanggan yang sah diperbarui dan dapat ditelusuri.

Langkah utama. Backend memeriksa peran dan mengambil data pelanggan sesuai izin → Backend memvalidasi identitas customer dan perubahan yang diajukan → Backend menyimpan perubahan dan mencatat pelaku serta hasilnya.

Alternatif. 2.a Customer tidak ditemukan atau data tidak sah.; 2.b Akun tidak memiliki izin pengelolaan.

## UC-09 Melihat Katalog Produk

**Aktor** Guest, Customer  
**Prasyarat** Client dapat mengakses layanan katalog publik.  
**Hasil** Daftar produk yang memenuhi ketentuan publik dikirim ke client.

Langkah utama. Backend mengambil produk yang boleh ditampilkan beserta ringkasan harga dan atribut → Backend mengirim data katalog sesuai parameter halaman.

Alternatif. 1.a Tidak ada produk yang dapat ditampilkan.

## UC-10 Mencari dan Memfilter Produk

**Aktor** Guest, Customer  
**Prasyarat** Katalog dapat diakses dan parameter pencarian didukung layanan.  
**Hasil** Daftar hasil yang sesuai kriteria dikembalikan tanpa mengubah data produk.

Langkah utama. Backend memvalidasi parameter dan menerapkan kriteria pada produk yang boleh ditampilkan → Backend mengembalikan produk yang cocok beserta informasi jumlah atau halaman jika tersedia.

Alternatif. 1.a Kriteria tidak sah.; 2.a Tidak ada produk yang cocok.

## UC-11 Melihat Detail Produk

**Aktor** Guest, Customer  
**Prasyarat** Produk terdaftar dan dapat dipublikasikan.  
**Hasil** Client menerima rincian produk yang dapat diakses.

Langkah utama. Backend memeriksa identitas dan visibilitas produk serta mengambil atribut, harga, gambar dan informasi stok yang diperbolehkan → Backend mengirim rincian produk kepada client.

Alternatif. 1.a Produk tidak tersedia atau tidak ditemukan.

## UC-12 Menambahkan Produk Baru

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Admin Gudang atau Super Admin Owner login dan memiliki data produk baru.  
**Hasil** Produk baru dan atribut yang valid tercatat dalam katalog.

Langkah utama. Backend memeriksa otorisasi dan memvalidasi kelengkapan, format serta hubungan data → Backend menyimpan produk dan referensi gambar dalam transaksi yang sesuai → Backend mengembalikan identitas dan status produk baru.

Alternatif. 1.a Data atau gambar tidak valid.; 2.a Penyimpanan gagal.

## UC-13 Mengelola Data Produk

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Produk ada dan Admin Gudang atau Super Admin Owner berwenang.  
**Hasil** Perubahan informasi produk tersimpan tanpa menghilangkan keterkaitan transaksi.

Langkah utama. Backend mengambil data produk beserta kategori, atribut, harga dan gambar → Backend memvalidasi izin, data dan keterkaitan transaksi serta persediaan → Backend menyimpan perubahan atau penghapusan sesuai aturan integritas dan mengirim hasil.

Alternatif. 2.a Data tidak valid atau produk tidak ditemukan.; 2.b Perubahan stok langsung berpotensi menduplikasi proses lain.

## UC-14 Mengelola Keranjang Belanja

**Aktor** Customer  
**Prasyarat** Customer login dan produk yang dipilih tersedia.  
**Hasil** Keranjang mencerminkan perubahan item yang diterima backend.

Langkah utama. Backend mengambil keranjang miliknya dan memeriksa ketersediaan varian → Backend memvalidasi kepemilikan, kuantitas dan stok yang relevan → Backend menyimpan perubahan keranjang dan mengirim item serta nilai ringkas yang mutakhir.

Alternatif. 2.a Stok tidak cukup atau jumlah tidak valid.; 2.b Item bukan milik customer.

## UC-15 Mengelola Alamat Pengiriman

**Aktor** Customer  
**Prasyarat** Customer telah login.  
**Hasil** Alamat milik customer yang valid tersimpan, diperbarui atau dihapus.

Langkah utama. Backend mengambil alamat yang terkait dengan akun → Backend memvalidasi data dan memeriksa kepemilikan alamat → Backend menerapkan perubahan dan mengembalikan daftar atau status terbaru.

Alternatif. 2.a Data alamat tidak valid.; 2.b Alamat bukan milik customer.

## UC-16 Membuat Pesanan / Checkout

**Aktor** Customer  
**Prasyarat** Customer login; keranjang berisi produk dan alamat pengiriman tersedia.  
**Hasil** Pesanan dan rinciannya tersimpan sebagai Menunggu Pembayaran; stok tersedia berkurang sebesar reservasi dan tenggat pembayaran pukul 23.59 pada tanggal checkout tercatat.

Langkah utama. Sistem memeriksa kepemilikan, produk, jumlah, alamat dan harga serta menampilkan ringkasan → Sistem memeriksa kembali ketersediaan, lalu mencatat pesanan dan mereservasi stok secara konsisten agar unit yang sama tidak dipesan dua kali → Sistem mengirim hasil: pesanan Menunggu Pembayaran beserta rinciannya, stok tersedia yang telah berkurang dan tenggat pukul 23.59 tanggal checkout → Sistem menyediakan identitas pesanan untuk memulai pembayaran melalui UC-20.

Alternatif. 1.a Customer mengirim keranjang kosong, alamat tidak sah atau jumlah tidak valid.; 2.a Customer mengonfirmasi ketika stok tidak mencukupi atau harga telah berubah.; 2.b Dua Customer bersamaan meminta unit terakhir.; 3.a Pencatatan pesanan atau reservasi gagal.

## UC-17 Melihat Riwayat Pesanan

**Aktor** Customer  
**Prasyarat** Customer telah terautentikasi.  
**Hasil** Daftar pesanan milik customer dikembalikan dengan statusnya.

Langkah utama. Backend mengambil pesanan berdasarkan identitas customer → Backend menerapkan kriteria yang valid dan mengirim daftar pesanan.

Alternatif. 1.a Customer belum memiliki pesanan.; 1.b Autentikasi tidak sah.

## UC-18 Melihat Detail Pesanan

**Aktor** Customer  
**Prasyarat** Customer login dan pesanan terkait dimiliki customer.  
**Hasil** Rincian item, nilai, pembayaran, dan status pesanan yang diizinkan dikirim.

Langkah utama. Backend memverifikasi kepemilikan dan mengambil rincian pesanan beserta status terkait → Backend mengirim respons yang memisahkan status pesanan dan pembayaran.

Alternatif. 1.a Pesanan tidak ditemukan atau bukan milik customer.

## UC-19 Mengelola Pesanan

**Aktor** Customer, Admin Kasir, Super Admin Owner  
**Prasyarat** Customer atau Admin Kasir/Super Admin Owner telah login sesuai perannya dan pesanan tercatat; untuk permohonan pembatalan berbayar, pesanan telah dibayar dan dimiliki Customer.  
**Hasil** Perubahan yang sah tercatat. Pembatalan pesanan berbayar terjadi setelah persetujuan admin dan Customer diberi notifikasi bahwa dana akan dikembalikan. Reservasi yang masih melekat dilepaskan satu kali; poin yang pernah diberikan dibalik jika belum dibalik, sesuai ketentuan yang berlaku.

Langkah utama. Sistem memeriksa kepemilikan dan status pesanan, lalu menyimpan permohonan beserta alasan → Sistem memeriksa kewenangan dan menampilkan permohonan, alasan Customer, serta status pesanan dan pembayaran secara terpisah → Sistem mencatat persetujuan, membatalkan pesanan, menyimpan riwayat dan mengirim notifikasi kepada Customer bahwa pembatalan disetujui serta dana akan dikembalikan; reservasi yang masih melekat dilepaskan satu kali dan poin yang pernah diberikan serta belum dibalik ditangani sesuai ketentuan → Sistem menampilkan status pembatalan yang telah dicatat; transfer refund dilakukan secara manual di luar sistem.

Alternatif. 1.a Permohonan tidak menyertakan alasan, pesanan bukan milik Customer, atau status tidak memenuhi ketentuan.; 2.a Admin meminta perubahan tanpa hak atau transisi yang tidak diperbolehkan.; 2.b Tenggat pukul 23.59 tanggal checkout tercapai sementara pesanan belum dibayar.; 2.c Pemicu pembatalan atau pelepasan stok diterima ulang.; 2.d Pesanan belum dibayar dibatalkan dan belum pernah menghasilkan poin.; 2.e Poin yang harus dibalik sudah digunakan.; 2.f Admin meminta verifikasi bukti transfer pembayaran.; 2.g Admin mengelola perubahan pesanan lain yang diperbolehkan sesuai kewenangan.; 3.a Permohonan pembatalan pesanan berbayar belum disetujui admin.

## UC-20 Memulai Pembayaran

**Aktor** Customer  
**Prasyarat** Customer login, memiliki pesanan yang belum lunas dan layak dibayar.  
**Hasil** Referensi transaksi gateway dan status awal dicatat; batas pembayaran tetap pukul 23.59 tanggal checkout.

Langkah utama. Backend memverifikasi kepemilikan, status, total, dan batas pembayaran pesanan → Backend mengajukan transaksi ke payment gateway generik dan menyimpan referensi serta status awal yang diperoleh → Backend mengirim instruksi atau referensi tanpa menyatakan pembayaran berhasil.

Alternatif. 1.a Pesanan sudah lunas, tidak dimiliki customer atau telah melewati tenggat.; 2.a Layanan gateway gagal atau hasil permintaan belum pasti.

## UC-21 Memproses Pembayaran

**Aktor** Payment Gateway  
**Prasyarat** Permintaan transaksi pembayaran untuk pesanan yang sah telah diajukan kepada Payment Gateway melalui UC-20.  
**Hasil** Payment Gateway menghasilkan respons atau informasi hasil pemrosesan transaksi di luar MotifNesia.

Langkah utama. Layanan Payment Gateway menerima informasi transaksi untuk diproses → Layanan Payment Gateway menjalankan pemrosesan melalui layanannya di luar MotifNesia → Layanan Payment Gateway menyediakan respons atau informasi transaksi yang relevan.

Alternatif. 2.a Payment Gateway belum memperoleh hasil akhir.; 3.a Pemrosesan gagal atau layanan Payment Gateway tidak tersedia.

## UC-22 Menerima Notifikasi Pembayaran

**Aktor** Payment Gateway  
**Prasyarat** Transaksi gateway telah dikaitkan dengan pesanan dan Payment Gateway dapat mengirim notifikasi kepada sistem.  
**Hasil** Notifikasi sah dicatat; pembayaran berhasil pada pesanan aktif sebelum tenggat memungkinkan pesanan Diproses tanpa mengurangi stok lagi. Hasil terlambat ditandai untuk rekonsiliasi.

Langkah utama. Sistem memvalidasi sumber, identitas transaksi, nominal, keterkaitan pesanan dan keadaan pembayaran → Sistem mencatat pembayaran Berhasil/Lunas dan mengubah status pesanan menjadi Diproses tanpa mengurangi stok yang telah direservasi saat checkout untuk kedua kalinya → Sistem mencatat pemrosesan dan menyampaikan hasil penerimaan tanpa menggandakan dampak transaksi.

Alternatif. 1.a Gateway mengirim notifikasi tidak sah atau transaksi dan pesanan tidak cocok.; 2.a Gateway melaporkan pembayaran menunggu atau gagal secara sah.; 2.b Gateway mengirim notifikasi duplikat atau status gagal yang lebih lama setelah keberhasilan.; 2.c Gateway melaporkan pembayaran berhasil setelah pesanan dibatalkan karena tenggat dan reservasi dilepaskan.

## UC-23 Melihat Informasi Pembayaran

**Aktor** Customer, Admin Finance, Super Admin Owner  
**Prasyarat** Customer pemilik pesanan atau Admin Finance/Super Admin Owner telah login.  
**Hasil** Informasi pembayaran dikirim sesuai hak akses dan status terbaru.

Langkah utama. Backend memverifikasi identitas, peran dan kepemilikan jika aktor customer → Backend mengirim status pembayaran, nilai dan informasi transaksi yang diizinkan secara terpisah dari status pesanan.

Alternatif. 1.a Pesanan bukan milik customer atau akses tidak diizinkan.; 1.b Transaksi belum tersedia.

## UC-24 Menyiapkan dan Mengemas Pesanan

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Pesanan telah lunas dan berstatus Diproses; Admin Gudang atau Super Admin Owner login.  
**Hasil** Progres penyiapan atau pengemasan pesanan tercatat untuk tindak lanjut pengiriman.

Langkah utama. Backend memeriksa izin dan menyajikan item serta kuantitas pesanan yang relevan → Backend tidak melakukan kegiatan fisik dan menunggu pencatatan oleh aktor → Backend memvalidasi transisi dan menyimpan status beserta waktu dan pelaku.

Alternatif. 3.a Pesanan belum memenuhi syarat atau status telah berubah.

## UC-25 Mencatat Informasi Pengiriman

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Pesanan siap dikirim; Admin Kasir atau Super Admin Owner memperoleh nama jasa pengiriman, sedangkan nomor resi dapat belum tersedia.  
**Hasil** Nama jasa pengiriman dan nomor resi jika tersedia tersimpan; resi dapat diperbarui kemudian.

Langkah utama. Backend memeriksa izin dan status pesanan → Backend memvalidasi data dan keterkaitan dengan pesanan → Backend menyimpan informasi pengiriman dan mengirim respons; jika resi belum tersedia, data dapat dilengkapi kemudian.

Alternatif. 2.a Resi belum tersedia.; 2.b Nama jasa pengiriman tidak valid atau status tidak memungkinkan.

## UC-26 Melihat Informasi Pengiriman

**Aktor** Customer  
**Prasyarat** Customer login dan memiliki pesanan yang diminta.  
**Hasil** Customer menerima status pengiriman dan resi yang telah dicatat jika tersedia.

Langkah utama. Backend memverifikasi kepemilikan dan mengambil status, nama ekspedisi, serta resi yang tercatat → Backend mengirim data yang tersedia tanpa mengklaim pelacakan otomatis.

Alternatif. 1.a Resi belum dicatat.; 1.b Pesanan bukan milik customer.

## UC-27 Mengonfirmasi Penerimaan Pesanan

**Aktor** Customer  
**Prasyarat** Customer login, memiliki pesanan, dan pesanan berada pada tahap yang dapat dikonfirmasi.  
**Hasil** Pesanan tercatat telah diterima sesuai transisi status yang sah.

Langkah utama. Backend memeriksa kepemilikan dan status pengiriman → Backend memperbarui status dan waktu penerimaan serta mengirim respons.

Alternatif. 1.a Pesanan tidak dimiliki customer.; 2.a Pesanan sudah dikonfirmasi atau belum dapat dikonfirmasi.

## UC-28 Mengelola Data Supplier

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Admin Gudang atau Super Admin Owner login.  
**Hasil** Data supplier yang valid tersimpan atau diperbarui untuk digunakan dalam pengadaan.

Langkah utama. Backend memeriksa izin dan mengambil data supplier → Backend memvalidasi identitas dan kontak yang diperlukan → Backend menyimpan data supplier dan mengembalikan hasil.

Alternatif. 2.a Data tidak sah atau supplier tidak ditemukan.; 2.b Supplier terkait pengadaan historis dinonaktifkan.

## UC-29 Membuat Pengadaan Produk

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Aktor berwenang login; supplier dan produk yang dipilih tersedia.  
**Hasil** Pengadaan berisi supplier, produk, varian, dan jumlah yang dipesan tercatat.

Langkah utama. Backend memvalidasi supplier, produk, varian dan jumlah yang sah → Backend menyimpan pengadaan dan rinciannya secara konsisten serta mengirim identitas pengadaan.

Alternatif. 1.a Supplier atau produk tidak sah, atau jumlah tidak valid.; 2.a Penyimpanan sebagian gagal.

## UC-30 Menghasilkan dan Mengunduh Dokumen Purchase Order

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Pengadaan valid tersedia untuk Admin Gudang atau Super Admin Owner.  
**Hasil** Dokumen PO tersedia untuk diunduh dan dapat dikirim aktor kepada supplier di luar sistem.

Langkah utama. Backend memeriksa otorisasi dan mengambil data supplier serta rincian pengadaan → Backend menyusun dokumen PO berformat PDF dari data pengadaan dan mengirim berkas kepada client → Backend tidak mengirim pesan tersebut secara otomatis; pencatatan konfirmasi dilakukan melalui UC-32.

Alternatif. 1.a Pengadaan tidak ditemukan atau data PO belum lengkap.; 2.a Pembuatan dokumen gagal.

## UC-31 Mengelola Pengadaan

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Aktor berwenang dan pengadaan tercatat.  
**Hasil** Perubahan pengadaan yang sah tersimpan tanpa merusak histori penerimaan.

Langkah utama. Backend mengambil supplier, status, item, dan ringkasan penerimaan yang tersedia → Backend memeriksa status dan dampak terhadap PO serta penerimaan yang sudah ada → Backend menyimpan perubahan dan mengembalikan data terkini.

Alternatif. 2.a Perubahan bertentangan dengan penerimaan atau status pengadaan.; 2.b Pengadaan tidak ditemukan.

## UC-32 Mencatat Konfirmasi Supplier

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** PO telah disampaikan kepada supplier dan aktor berwenang memiliki hasil komunikasi.  
**Hasil** Konfirmasi supplier tercatat pada pengadaan beserta informasi yang relevan.

Langkah utama. Backend tidak menerima konfirmasi langsung dari supplier → Backend memvalidasi identitas pengadaan, status, dan informasi konfirmasi → Backend menyimpan hasil dan memperbarui status pengadaan; penolakan dicatat sebagai tidak dilanjutkan.

Alternatif. 2.a Pengadaan tidak ditemukan atau status tidak sesuai.; 2.b Supplier belum memberikan jawaban.

## UC-33 Mencatat Penerimaan Barang

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Pengadaan berada pada tahap penerimaan dan Admin Gudang atau Super Admin Owner memeriksa jumlah barang yang secara fisik diterima, termasuk apabila melebihi sisa PO.  
**Hasil** Setiap batch dan seluruh jumlah aktual tersimpan dan stok penerimaan bertambah satu kali; kelebihan atas sisa PO dikembalikan kepada supplier secara manual. Barang yang telah dikembalikan tidak dianggap masih menjadi stok tersedia.

Langkah utama. Backend mengirim jumlah dipesan, total diterima dan sisa per varian → Backend memvalidasi produk, jumlah dan keterkaitan terhadap PO → Backend menyimpan batch dan rincian, menambah stok sesuai jumlah aktual satu kali serta menghitung sisa dan status penerimaan → Backend menampilkan jumlah kumulatif, sisa PO dan status penerimaan berdasarkan jumlah yang diterima.

Alternatif. 2.a Jumlah penerimaan tidak valid atau aktor tidak berwenang.; 2.b Barang diterima melebihi sisa PO dan aktor mencatat seluruh jumlah aktual.; 2.c Admin menangani dan mengembalikan selisih kelebihan barang kepada supplier secara manual melalui komunikasi eksternal.; 3.a Permintaan batch yang sama dikirim ulang.

## UC-34 Melihat Persediaan Gudang

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Admin Gudang atau Super Admin Owner login.  
**Hasil** Data stok produk dan variannya dikembalikan sesuai informasi yang tercatat.

Langkah utama. Backend memeriksa izin dan mengambil stok produk/varian dari sumber data gudang yang ditetapkan → Backend menerapkan parameter valid dan mengembalikan hasil terkini.

Alternatif. 1.a Tidak ada data yang cocok.

## UC-35 Mencatat Barang Masuk dan Barang Keluar

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Aktor berwenang; produk, varian, jumlah dan alasan tersedia.  
**Hasil** Pergerakan persediaan serta perubahan stok yang sah tersimpan satu kali.

Langkah utama. Backend memeriksa izin, validasi data, saldo dan kemungkinan referensi sudah diproses → Backend menyimpan pergerakan dan memperbarui stok dalam satu transaksi → Backend mengirim identitas pergerakan dan saldo terkini.

Alternatif. 1.a Jumlah tidak sah atau stok keluar tidak mencukupi.; 1.b Referensi telah memengaruhi stok melalui penerimaan/pesanan.

## UC-36 Melakukan Stock Opname

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Aktor berwenang telah melakukan penghitungan fisik produk/varian di gudang.  
**Hasil** Hasil penghitungan dan selisih terhadap stok tercatat untuk ditinjau.

Langkah utama. Backend mengambil saldo sistem per produk dan varian → Backend memvalidasi angka dan menghitung selisih terhadap saldo yang relevan → Backend mencatat hasil, waktu dan pelaku serta mengirim ringkasan selisih.

Alternatif. 2.a Jumlah fisik tidak valid atau data produk tidak ditemukan.; 3.a Saldo berubah sejak pemeriksaan dimulai.

## UC-37 Melakukan Penyesuaian Stok

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Ada hasil opname atau dasar koreksi yang dapat ditelusuri; aktor berwenang.  
**Hasil** Koreksi stok, riwayat pergerakan dan identitas aktor yang melakukan penyesuaian tersimpan tepat satu kali.

Langkah utama. Backend mengambil saldo sistem dan hasil opname terkait → Backend memvalidasi peran, sumber, saldo dan kelengkapan catatan → Backend langsung menyimpan stok baru, riwayat pergerakan dan identitas aktor satu kali tanpa meminta persetujuan Owner.

Alternatif. 2.a Koreksi tidak sah atau data sumber sudah diterapkan.; 3.a Saldo berubah saat konfirmasi.

## UC-38 Melihat Riwayat Pergerakan Stok

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Admin Gudang atau Super Admin Owner login.  
**Hasil** Riwayat perubahan stok yang sesuai filter dikirim ke client.

Langkah utama. Backend memeriksa izin dan mengambil catatan pergerakan, referensi dan waktu → Backend memvalidasi filter dan mengirim hasil yang sesuai.

Alternatif. 2.a Tidak ada catatan sesuai filter.

## UC-39 Mengajukan Retur Produk

**Aktor** Customer  
**Prasyarat** Customer login dan pesanan miliknya telah diterima; pengajuan dilakukan maksimal tiga hari setelah penerimaan.  
**Hasil** Pengajuan dengan alasan dan bukti foto atau video tersimpan untuk ditinjau.

Langkah utama. Backend memeriksa kepemilikan, waktu penerimaan maksimal tiga hari, kelengkapan bukti dan validitas input → Backend menyimpan retur beserta bukti dan status awal serta mengirim identitas pengajuan.

Alternatif. 1.a Lebih dari tiga hari setelah penerimaan atau item bukan milik customer.; 1.b Foto maupun video tidak dilampirkan atau bukti tidak valid.; 2.a Pengajuan yang sama sudah dicatat.

## UC-40 Melihat Status Pengajuan Retur

**Aktor** Customer  
**Prasyarat** Customer login dan memiliki pengajuan retur.  
**Hasil** Riwayat dan status retur yang diizinkan dikirim kepada customer.

Langkah utama. Backend memeriksa kepemilikan dan mengambil status, hasil tinjauan serta tindak lanjut yang tercatat → Backend mengirim informasi terbaru tanpa menyatakan tindakan fisik telah terjadi sebelum dicatat.

Alternatif. 1.a Retur tidak ditemukan atau bukan milik customer.

## UC-41 Meninjau dan Mengelola Pengajuan Retur

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Pengajuan telah dicatat; Admin Kasir atau Super Admin Owner login.  
**Hasil** Keputusan tinjauan dan alasan yang relevan tersimpan pada pengajuan.

Langkah utama. Backend memeriksa izin dan mengambil data pesanan serta pengajuan → Backend memvalidasi keputusan serta transisi status yang diperbolehkan → Backend menyimpan hasil tinjauan dan mengirim pembaruan status untuk customer.

Alternatif. 2.a Pengajuan ditolak setelah ditinjau.; 2.b Informasi belum cukup.; 2.c Status tidak memungkinkan peninjauan.

## UC-42 Mencatat Penerimaan dan Pemeriksaan Produk Retur

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Retur telah disetujui; customer mengirim barang kembali di luar sistem dan barang tiba di toko.  
**Hasil** Hasil penerimaan dan pemeriksaan tercatat; produk layak jual dapat dimasukkan ke stok tersedia sedangkan produk rusak tidak menambahnya.

Langkah utama. Backend menyediakan data pengajuan yang disetujui → Backend memvalidasi hak, status retur dan data pemeriksaan → Backend mencatat produk layak jual yang dimasukkan kembali ke stok tersedia dan pergerakannya; barang rusak tidak menambah stok tersedia.

Alternatif. 2.a Barang tidak sesuai pengajuan.; 3.a Barang rusak atau tidak layak jual.

## UC-43 Menentukan Penyelesaian Retur

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Hasil pemeriksaan produk tersedia; Admin Kasir atau Super Admin Owner berwenang.  
**Hasil** Keputusan penukaran produk sama, alternatif, atau refund dicatat sesuai hasil pemeriksaan dan komunikasi.

Langkah utama. Sistem menampilkan pengajuan, kondisi produk dan stok yang relevan → Sistem mencatat penukaran produk yang sama sebagai tindak lanjut → Sistem menyimpan pilihan penyelesaian untuk diteruskan ke proses penukaran UC-44.

Alternatif. 2.a Produk yang sama tidak tersedia dan admin menawarkan produk alternatif di luar sistem.; 2.b Customer menerima alternatif dan admin mencatat persetujuan tersebut.; 2.c Customer tidak bersedia menerima alternatif dan admin mencatat hasil komunikasi.; 2.d Customer belum memberikan keputusan.

## UC-44 Memproses Penukaran Produk

**Aktor** Admin Gudang, Admin Kasir, Super Admin Owner  
**Prasyarat** Retur disetujui untuk penukaran dan hasil pemeriksaan tersedia.  
**Hasil** Informasi penukaran dan perkembangan yang dicatat aktor tersimpan.

Langkah utama. Backend menyediakan data keputusan retur dan mencatat informasi pengganti yang dikirim aktor → Backend tidak melakukan pengiriman secara otomatis → Backend mencatat pergerakan stok keluar produk pengganti satu kali serta status penukaran tanpa menggandakan pergerakan.

Alternatif. 2.a Produk pengganti belum tersedia atau belum disepakati.; 2.b Data penukaran tidak valid.

## UC-45 Memproses Pengembalian Dana

**Aktor** Admin Finance  
**Prasyarat** Retur telah disetujui untuk refund atau pembatalan pesanan berbayar telah disetujui melalui UC-19; Admin Finance telah terautentikasi serta berwenang.  
**Hasil** Setelah transfer manual benar-benar dilakukan, nominal, tanggal, referensi, bukti dan status refund selesai tercatat; poin yang pernah diberikan dibalik jika belum dibalik sebelumnya.

Langkah utama. Sistem memeriksa izin, data retur atau pembatalan pesanan yang disetujui, serta nilai pengembalian yang tercatat → Sistem tidak melakukan transfer otomatis → Sistem memvalidasi data dan mencatat refund selesai beserta bukti → Sistem memeriksa riwayat poin dan membalik hanya poin transaksi yang pernah diberikan dan belum dibalik; hasilnya dicatat satu kali.

Alternatif. 2.a Transfer gagal atau belum dilakukan.; 3.a Bukti atau data wajib tidak lengkap atau aktor tidak berwenang.; 4.a Poin belum pernah diberikan atau sudah dibalik melalui UC-19.; 4.b Poin yang harus dibalik sudah digunakan.; 4.c Pencatatan refund yang sama diajukan kembali.

## UC-46 Melihat Status Pengembalian Dana

**Aktor** Customer  
**Prasyarat** Customer login dan memiliki pengajuan dengan penyelesaian refund.  
**Hasil** Status dan informasi refund yang diizinkan dikirim kepada customer.

Langkah utama. Backend memeriksa kepemilikan dan mengambil status refund serta catatan yang boleh dilihat → Backend mengirim status tanpa mengklaim transfer berhasil sebelum dicatat.

Alternatif. 1.a Tidak ada refund atau retur bukan milik customer.

## UC-47 Mengelola Percakapan Live Chat

**Aktor** Customer, Admin Kasir, Super Admin Owner  
**Prasyarat** Customer atau Admin Kasir/Super Admin Owner telah login dan berhak mengakses percakapan.  
**Hasil** Pesan dan riwayat percakapan tersimpan serta tersedia kepada pihak yang berwenang.

Langkah utama. Backend memeriksa akses dan mengambil riwayat yang relevan → Backend memvalidasi isi dan otorisasi, menyimpan pesan serta waktu pengiriman → Backend menyampaikan pesan secara real-time kepada pihak berwenang dan menyimpan riwayat.

Alternatif. 2.a Pesan kosong, tidak sah, atau percakapan bukan hak aktor.; 3.a Belum ada pesan baru.

## UC-48 Mengelola Produk Favorit

**Aktor** Customer  
**Prasyarat** Customer login.  
**Hasil** Daftar favorit mencerminkan produk yang ditambah atau dihapus oleh pemiliknya.

Langkah utama. Backend mengambil favorit milik akun terautentikasi → Backend memeriksa produk serta kepemilikan, kemudian menyimpan perubahan dan mengembalikan hasil.

Alternatif. 2.a Produk tidak ditemukan atau sudah tidak dapat ditambahkan.; 2.b Permintaan duplikat.

## UC-49 Mengirim Ulasan Produk

**Aktor** Customer  
**Prasyarat** Customer login dan pernah membeli produk terkait.  
**Hasil** Rating dan komentar valid tersimpan dan langsung dipublikasikan.

Langkah utama. Backend memeriksa identitas Customer dan riwayat pembelian produk → Backend memvalidasi format dan data ulasan → Backend menyimpan serta langsung mempublikasikan ulasan valid dan mengirim hasil.

Alternatif. 1.a Customer belum pernah membeli produk terkait.; 2.a Rating atau komentar tidak memenuhi validasi.

## UC-50 Melihat Ulasan Produk

**Aktor** Guest, Customer  
**Prasyarat** Produk dan ulasan valid yang dipublikasikan tersedia atau dapat diminta.  
**Hasil** Ulasan yang diizinkan dikirim tanpa data privat yang tidak diperlukan.

Langkah utama. Backend mengambil ulasan yang memenuhi status publikasi dan menghitung informasi rating yang relevan → Backend mengirim hasil sesuai parameter valid.

Alternatif. 1.a Belum ada ulasan yang boleh ditampilkan.; 1.b Produk tidak ditemukan atau tidak dapat ditampilkan.

## UC-51 Manajemen Ulasan Produk

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Admin Kasir atau Super Admin Owner terautentikasi dan memiliki kewenangan; ulasan telah dipublikasikan.  
**Hasil** Ulasan yang dipilih dan sah dihapus sesuai kebijakan penghapusan yang berlaku, dan hasil disampaikan kepada admin.

Langkah utama. Sistem memeriksa kewenangan dan menampilkan ulasan yang telah dipublikasikan → Sistem menampilkan ulasan yang dipilih dan meminta atau memproses konfirmasi sesuai rancangan antarmuka → Sistem memeriksa keberadaan dan kewenangan, menghapus ulasan sesuai kebijakan yang berlaku, lalu menyampaikan hasil.

Alternatif. 1.a Aktor tidak memiliki kewenangan.; 2.a Ulasan tidak ditemukan atau sudah dihapus.; 3.a Konfirmasi atau permintaan tidak valid, atau penghapusan gagal.; 3.b Admin meminta perubahan isi atau rating ulasan.

## UC-52 Melihat Informasi Membership

**Aktor** Customer  
**Prasyarat** Customer login.  
**Hasil** Informasi membership milik customer dikembalikan sesuai statusnya.

Langkah utama. Backend mengambil status, saldo poin, riwayat dan daftar reward yang dapat ditampilkan → Backend memverifikasi kepemilikan dan mengirim data yang relevan.

Alternatif. 1.a Customer belum menjadi member.

## UC-53 Mendaftar Membership

**Aktor** Customer  
**Prasyarat** Customer login dan belum memiliki membership aktif sesuai aturan program.  
**Hasil** Status pendaftaran membership dan data pendukung tersimpan.

Langkah utama. Backend memeriksa identitas customer dan status membership saat ini → Backend memvalidasi syarat yang telah disepakati → Backend menyimpan status membership dan mengirim hasil.

Alternatif. 1.a Customer sudah terdaftar.; 2.a Data belum memenuhi persyaratan yang telah ditetapkan.

## UC-54 Menukarkan Poin dengan Reward

**Aktor** Customer  
**Prasyarat** Customer login, membership memenuhi syarat, dan reward tersedia.  
**Hasil** Poin berkurang sesuai ketentuan yang berlaku dan voucher hasil penukaran tercatat satu kali.

Langkah utama. Backend memeriksa status member, ketersediaan reward, biaya poin dan saldo → Backend mengurangi poin dan membuat catatan penukaran secara konsisten dalam transaksi → Backend mengirim saldo dan informasi reward yang tercatat.

Alternatif. 1.a Poin tidak cukup atau reward tidak tersedia.; 2.a Permintaan berulang.

## UC-55 Mengelola Program Membership

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Admin Kasir atau Super Admin Owner login.  
**Hasil** Perubahan program atau status member yang valid tercatat.

Langkah utama. Backend memeriksa peran serta mengambil data program dan member → Backend memvalidasi data dan dampaknya terhadap akun member → Backend menyimpan perubahan dan mengembalikan hasil.

Alternatif. 2.a Pengaturan tidak valid atau member tidak ditemukan.; 2.b Pengaturan tidak memiliki aturan yang disepakati.

## UC-56 Mengelola Reward Membership

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Admin Kasir atau Super Admin Owner login.  
**Hasil** Reward baru atau perubahan reward yang sah tersimpan.

Langkah utama. Backend memeriksa izin dan mengambil data reward → Backend memvalidasi nilai dan syarat yang tersedia → Backend menyimpan reward tanpa menghilangkan histori penukaran yang ada.

Alternatif. 2.a Biaya poin atau nilai reward tidak valid.; 2.b Reward tidak ditemukan.

## UC-57 Mengelola Poin Membership

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Admin Kasir atau Super Admin Owner login; akun member tersedia.  
**Hasil** Perubahan saldo poin dan alasan atau riwayatnya tercatat.

Langkah utama. Backend mengambil saldo dan riwayat transaksi poin yang diizinkan → Backend memvalidasi jumlah, dampak terhadap saldo dan kewenangan → Backend menyimpan perubahan saldo dan riwayat dalam transaksi serta mengirim respons.

Alternatif. 2.a Penyesuaian tidak sah atau melebihi aturan saldo.; 2.b Member tidak ditemukan.

## UC-58 Melihat Notifikasi

**Aktor** Customer, Super Admin Owner, Admin Finance, Admin Kasir, Admin Gudang  
**Prasyarat** Aktor telah terautentikasi dan memiliki hak melihat notifikasi yang diminta.  
**Hasil** Daftar atau rincian notifikasi yang diizinkan dikembalikan.

Langkah utama. Backend memeriksa identitas serta batas akses dan mengambil data yang relevan → Backend mengembalikan informasi yang diizinkan beserta status baca.

Alternatif. 1.a Tidak ada notifikasi yang tersedia.; 2.a Notifikasi bukan hak aktor.

## UC-59 Mengelola Notifikasi

**Aktor** Customer  
**Prasyarat** Customer terautentikasi dan memiliki notifikasi yang dapat dikelola.  
**Hasil** Status atau penghapusan notifikasi milik Customer yang sah tercatat.

Langkah utama. Backend memverifikasi identitas dan mengirim daftar notifikasi → Backend memeriksa kepemilikan dan validitas tindakan → Backend memperbarui status atau menghapus notifikasi terkait dan mengirim hasil.

Alternatif. 2.a Notifikasi bukan milik Customer atau tidak ditemukan.

## UC-60 Mengelola Konten Promosi

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Admin Kasir atau Super Admin Owner login.  
**Hasil** Konten promosi yang valid tersimpan atau diperbarui beserta statusnya.

Langkah utama. Backend memeriksa peran dan mengambil konten yang tercatat → Backend memvalidasi informasi dan berkas yang diperlukan → Backend menyimpan konten dan mengembalikan hasil.

Alternatif. 2.a Konten atau berkas tidak valid.; 2.b Aktor tidak berwenang.

## UC-61 Mengirim Broadcast Promosi

**Aktor** Admin Kasir, Super Admin Owner  
**Prasyarat** Admin Kasir atau Super Admin Owner terautentikasi dan konten promosi tersedia.  
**Hasil** Permintaan broadcast dan hasil pengiriman atau status antreannya dicatat.

Langkah utama. Backend memvalidasi isi dan menyediakan data pratinjau → Backend menyiapkan seluruh Customer sebagai penerima dan meminta pengiriman melalui layanan email → Backend mencatat dan mengirim status yang diketahui, tanpa menyatakan pesan diterima bila belum ada buktinya.

Alternatif. 1.a Konten atau sasaran tidak valid.; 2.a Layanan email tidak tersedia atau sebagian pengiriman gagal.

## UC-62 Mengelola Laporan Penjualan

**Aktor** Admin Finance, Super Admin Owner  
**Prasyarat** Admin Finance atau Super Admin Owner login; data transaksi tersedia atau periode dapat dipilih.  
**Hasil** Ringkasan penjualan periode yang diminta dikirim atau diekspor sesuai hak akses.

Langkah utama. Backend memvalidasi periode dan mengambil transaksi berdasarkan waktu pembayaran berhasil → Backend menghitung nilai penjualan, tetap menyertakan transaksi yang direfund, serta menyajikan nilai refund secara terpisah berdasarkan data tercatat → Backend mengirim ringkasan atau berkas dalam format yang disediakan.

Alternatif. 1.a Periode tidak valid.; 2.a Tidak ada pembayaran berhasil pada periode.

## UC-63 Melihat Laporan Persediaan

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Admin Gudang atau Super Admin Owner login.  
**Hasil** Ringkasan persediaan dan pergerakan sesuai parameter dikirim kepada aktor.

Langkah utama. Backend memeriksa izin dan membaca stok per produk/varian, barang masuk dan keluar, hasil opname serta penyesuaian → Backend menyusun dan mengirim laporan termasuk informasi stok rendah berdasarkan kriteria yang ditetapkan.

Alternatif. 1.a Parameter tidak valid.; 2.a Tidak ada data sesuai filter.

## UC-64 Melihat Laporan Pengadaan

**Aktor** Admin Gudang, Super Admin Owner  
**Prasyarat** Admin Gudang atau Super Admin Owner login dan data pengadaan dapat diakses.  
**Hasil** Ringkasan pengadaan sesuai parameter disediakan kepada aktor.

Langkah utama. Backend memeriksa izin dan mengambil supplier, nomor PO, produk, jumlah dipesan, diterima, sisa dan status → Backend mengirim ringkasan termasuk nilai pembelian atau harga modal berdasarkan data yang tercatat.

Alternatif. 1.a Parameter tidak valid.; 2.a Belum ada pengadaan atau data penerimaan untuk kriteria tersebut.
