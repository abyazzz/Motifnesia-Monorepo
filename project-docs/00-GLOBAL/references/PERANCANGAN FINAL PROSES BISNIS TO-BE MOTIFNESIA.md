# PERANCANGAN FINAL PROSES BISNIS TO-BE MOTIFNESIA

**Versi:** Revisi berdasarkan keputusan bisnis terbaru  
**Status:** Draft acuan untuk penyusunan BPMN, Use Case, Skenario Use Case, dan Kebutuhan Fungsional  
**Ruang Lingkup:** Tujuh proses bisnis TO-BE MotifNesia

---

# 1. Pendahuluan

Proses bisnis TO-BE MotifNesia merupakan rancangan proses bisnis usulan yang menggambarkan aktivitas operasional setelah penerapan sistem e-commerce MotifNesia. Proses ini disusun untuk mendukung pengelolaan produk batik, pengadaan dan persediaan, pemesanan dan pembayaran, pemenuhan pesanan, layanan purnajual, pelaporan, membership, promosi, serta interaksi pelanggan.

Rancangan TO-BE dibagi menjadi tujuh proses bisnis. Setiap proses memiliki tujuan, aktor, dan alur aktivitas yang saling berkaitan. Pembagian ini digunakan untuk memperjelas tanggung jawab setiap aktor serta menjadi dasar dalam penyusunan kebutuhan fungsional dan Use Case sistem.

Sistem MotifNesia dirancang menggunakan satu backend yang dapat digunakan oleh aplikasi web dan mobile. Aktivitas yang dilakukan melalui sistem dicatat dan dikelola secara terpusat. Sementara itu, aktivitas yang melibatkan pihak eksternal tetapi tidak memiliki akses langsung ke sistem tetap dilakukan melalui komunikasi di luar sistem dan hasilnya dicatat oleh pihak internal.

## 1.1 Aktor Sistem

Aktor yang terlibat dalam proses bisnis TO-BE MotifNesia adalah:

| No. | Aktor | Deskripsi |
|---|---|---|
| 1 | Guest | Pengunjung yang mengakses informasi produk dan informasi publik tanpa melakukan autentikasi. |
| 2 | Customer | Pengguna terdaftar yang dapat melakukan pemesanan, pembayaran, melihat transaksi, menggunakan fitur pelanggan, serta mengakses layanan setelah pembelian. |
| 3 | Super Admin Owner | Pengelola utama sistem yang memiliki kewenangan administratif sesuai hak akses yang ditetapkan. Dapat mengelola akun Admin Finance, Admin Kasir, dan Admin Gudang, tetapi tidak dapat mengelola akun Super Admin Owner lainnya. |
| 4 | Admin Finance | Admin yang bertanggung jawab terhadap aktivitas administrasi keuangan, pemantauan pembayaran, serta pencatatan pengembalian dana. |
| 5 | Admin Kasir | Admin yang bertanggung jawab terhadap administrasi pesanan, informasi transaksi, layanan pelanggan, serta pengelolaan promosi dan membership sesuai kewenangannya. |
| 6 | Admin Gudang | Admin yang bertanggung jawab terhadap pengelolaan produk, pengadaan, penerimaan barang, persediaan, penyiapan pesanan, serta pemeriksaan produk retur. |
| 7 | Payment Gateway | Layanan eksternal yang memproses pembayaran dan mengirimkan notifikasi hasil transaksi kepada backend MotifNesia. |

**Catatan pihak eksternal:**

Supplier dan jasa pengiriman tidak ditetapkan sebagai pengguna langsung sistem MotifNesia.

- Supplier berkomunikasi dengan pihak internal melalui kanal eksternal seperti WhatsApp atau email. Data konfirmasi dan informasi pengadaan dicatat oleh admin ke dalam sistem.
- Jasa pengiriman menerima paket dari pihak toko. Informasi jasa pengiriman dan nomor resi diperoleh oleh pihak internal dan dicatat ke dalam sistem.
- Tidak ditetapkan integrasi API dengan jasa pengiriman.

## 1.2 Prinsip Umum Proses TO-BE

1. Sistem MotifNesia menjadi pusat pengelolaan data produk, pesanan, pembayaran, pengadaan, persediaan, dan aktivitas pelanggan.
2. Setiap aktivitas yang menghasilkan perubahan data penting harus tercatat di sistem.
3. Hak akses pengguna dibedakan berdasarkan peran masing-masing.
4. Supplier dan jasa pengiriman tidak berinteraksi langsung dengan sistem.
5. Pembayaran pelanggan diproses melalui payment gateway, bukan melalui verifikasi bukti transfer manual.
6. Pengembalian dana dilakukan secara manual oleh Admin Finance di luar sistem, sedangkan pencatatan dan pemantauan status dilakukan melalui MotifNesia.
7. Pengiriman pesanan dilakukan melalui jasa pengiriman yang dipilih atau digunakan pihak toko, tanpa integrasi API ekspedisi.
8. Sistem menggunakan satu gudang sebagai lokasi pengelolaan persediaan.
9. Setiap perubahan stok harus dapat ditelusuri melalui pencatatan pergerakan persediaan.
10. Kebutuhan teknis yang belum ditetapkan tidak boleh dianggap sebagai keputusan bisnis final.

---

# 2. Daftar Proses Bisnis TO-BE

| No. | Subbab | Nama Proses Bisnis | Jumlah Alur |
|---|---|---|---:|
| 1 | 2.3.1 | Pengelolaan Katalog Produk | 2 |
| 2 | 2.3.2 | Pengelolaan Pengadaan dan Persediaan Produk | 4 |
| 3 | 2.3.3 | Pemesanan dan Pengelolaan Transaksi | 3 |
| 4 | 2.3.4 | Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual | 3 |
| 5 | 2.3.5 | Pengelolaan Informasi Penjualan dan Laporan | 1 |
| 6 | 2.3.6 | Pengelolaan Membership dan Promosi Pelanggan | 3 |
| 7 | 2.3.7 | Pengelolaan Interaksi dan Preferensi Pelanggan | 3 |
| | | **Total** | **19 alur** |

---

# 3. Deskripsi Proses Bisnis TO-BE

## 3.1 Pengelolaan Katalog Produk

**Jumlah alur proses: 2**

### Tujuan Proses

Mengelola informasi produk agar dapat disajikan secara terstruktur kepada Guest dan Customer MotifNesia, serta mendukung pengelolaan data produk oleh pihak internal.

### Use Case yang Menggambarkan Proses

| ID | Use Case | Aktor |
|---|---|---|
| UC-09 | Melihat Katalog Produk | Guest, Customer |
| UC-10 | Mencari dan Memfilter Produk | Guest, Customer |
| UC-11 | Melihat Detail Produk | Guest, Customer |
| UC-12 | Menambahkan Produk Baru | Admin Gudang, Super Admin Owner |
| UC-13 | Mengelola Data Produk | Admin Gudang, Super Admin Owner |

### Alur 1 — Pengelolaan Data Produk

**Aktor utama:** Admin Gudang dan Super Admin Owner.

1. Admin membuka halaman pengelolaan produk.
2. Sistem menampilkan daftar produk yang telah terdaftar.
3. Admin memilih tindakan untuk menambahkan produk baru atau mengelola produk yang sudah tersedia.
4. Jika menambahkan produk, admin memasukkan informasi produk, kategori, atribut, harga, dan gambar produk.
5. Jika mengelola produk yang sudah tersedia, admin memilih produk dan melakukan perubahan atau penghapusan data sesuai kebutuhan.
6. Sistem memvalidasi informasi produk yang dimasukkan.
7. Sistem menyimpan perubahan data produk.
8. Sistem menyediakan informasi produk terbaru untuk ditampilkan pada katalog.

### Alur 2 — Penelusuran Katalog Produk

**Aktor utama:** Guest dan Customer.

1. Pengguna membuka aplikasi MotifNesia.
2. Sistem menampilkan katalog produk yang tersedia untuk dilihat.
3. Pengguna dapat mencari atau memfilter produk berdasarkan kriteria yang disediakan.
4. Sistem memproses pencarian dan menampilkan hasil yang sesuai.
5. Pengguna memilih salah satu produk.
6. Sistem menampilkan detail produk, termasuk gambar, informasi produk, harga, serta informasi ketersediaan stok.
7. Pengguna dapat mempertimbangkan produk dan melanjutkan ke proses pemesanan apabila ingin melakukan pembelian.

### Penjelasan

Proses pengelolaan katalog produk berfokus pada pengelolaan dan penyajian informasi produk batik di MotifNesia. Pihak internal bertanggung jawab menambahkan produk baru serta memperbarui atau menghapus data produk yang telah tersedia.

Informasi produk mencakup data yang diperlukan untuk membantu calon pembeli memahami karakteristik produk. Kategori, gambar, harga, atribut produk, dan informasi ketersediaan stok menjadi bagian dari pengelolaan data produk, bukan proses bisnis yang berdiri sendiri.

Guest dan Customer dapat mengakses katalog, melakukan pencarian dan penyaringan produk, serta melihat detail produk. Informasi yang ditampilkan membantu pengguna memperoleh gambaran mengenai produk sebelum melakukan pemesanan.

Konsultasi pelanggan tidak dimasukkan ke dalam proses ini karena komunikasi langsung antara Customer dan pihak toko disediakan melalui fitur live chat pada proses 2.3.7. Dengan demikian, proses ini memiliki batas yang jelas pada pengelolaan informasi produk dan aktivitas penelusuran katalog.

---

## 3.2 Pengelolaan Pengadaan dan Persediaan Produk

**Jumlah alur proses: 4**

### Tujuan Proses

Mendukung pengelolaan data supplier, pengadaan produk, penerimaan barang, pencatatan pergerakan persediaan, stock opname, penyesuaian stok, serta penyajian laporan persediaan dan pengadaan pada satu gudang.

### Use Case yang Menggambarkan Proses

| ID | Use Case | Aktor |
|---|---|---|
| UC-28 | Mengelola Data Supplier | Admin Gudang, Super Admin Owner |
| UC-29 | Membuat Pengadaan Produk | Admin Gudang, Super Admin Owner |
| UC-30 | Menghasilkan dan Mengunduh Dokumen Purchase Order | Admin Gudang, Super Admin Owner |
| UC-31 | Mengelola Pengadaan | Admin Gudang, Super Admin Owner |
| UC-32 | Mencatat Konfirmasi Supplier | Admin Gudang, Super Admin Owner |
| UC-33 | Mencatat Penerimaan Barang | Admin Gudang, Super Admin Owner |
| UC-34 | Melihat Persediaan Gudang | Admin Gudang, Super Admin Owner |
| UC-35 | Mencatat Barang Masuk dan Barang Keluar | Admin Gudang, Super Admin Owner |
| UC-36 | Melakukan Stock Opname | Admin Gudang, Super Admin Owner |
| UC-37 | Melakukan Penyesuaian Stok | Admin Gudang, Super Admin Owner |
| UC-38 | Melihat Riwayat Pergerakan Stok | Admin Gudang, Super Admin Owner |
| UC-63 | Melihat Laporan Persediaan | Admin Gudang, Super Admin Owner |
| UC-64 | Melihat Laporan Pengadaan | Admin Gudang, Super Admin Owner |

### Alur 1 — Pengelolaan Data Supplier dan Pengadaan Produk

**Aktor utama:** Admin Gudang dan Super Admin Owner.

1. Admin membuka halaman pengelolaan supplier atau pengadaan produk.
2. Sistem menampilkan data supplier dan produk yang tersedia.
3. Admin memilih supplier dan produk yang akan dipesan.
4. Admin memasukkan jumlah produk yang dibutuhkan.
5. Sistem menyimpan data pengadaan dengan status awal sesuai tahapan pengadaan.
6. Admin menghasilkan dan mengunduh dokumen Purchase Order (PO).
7. Admin mengirimkan dokumen PO kepada supplier melalui kanal komunikasi eksternal, seperti WhatsApp atau email.
8. Supplier memberikan konfirmasi melalui kanal komunikasi eksternal.
9. Admin mencatat hasil konfirmasi supplier ke dalam sistem.
10. Sistem memperbarui status pengadaan berdasarkan hasil konfirmasi tersebut.

Jika supplier tidak menyetujui pengadaan, admin mencatat bahwa pengadaan tidak dilanjutkan. Jika supplier menyetujui pengadaan, proses dilanjutkan ke tahap pengiriman dan penerimaan barang.

Apabila PO telah disampaikan kepada supplier, perubahan atau pembatalan pengadaan harus memperhatikan komunikasi lanjutan dengan supplier melalui kanal eksternal. Hasil komunikasi dan perubahan yang disepakati harus dicatat oleh admin ke sistem.

### Alur 2 — Pencatatan Penerimaan Barang

**Aktor utama:** Admin Gudang dan Super Admin Owner.

1. Barang dari supplier diterima oleh pihak toko.
2. Admin memeriksa kondisi dan jumlah barang yang diterima.
3. Admin memilih data pengadaan atau PO yang berkaitan dengan penerimaan tersebut.
4. Admin mencatat jumlah aktual barang yang diterima.
5. Sistem memvalidasi data penerimaan terhadap pengadaan terkait.
6. Sistem menyimpan catatan penerimaan barang.
7. Sistem menambahkan stok berdasarkan jumlah aktual barang yang diterima.
8. Sistem membandingkan jumlah kumulatif penerimaan dengan jumlah barang yang dipesan.
9. Jika seluruh barang telah diterima, sistem memperbarui status pengadaan menjadi Diterima Lengkap.
10. Jika jumlah barang yang diterima belum memenuhi jumlah pesanan, sistem memperbarui status menjadi Diterima Sebagian dan mencatat sisa barang yang belum diterima.

**Skenario penerimaan parsial:**

Satu PO berisi 100 produk. Supplier mengirimkan 60 produk terlebih dahulu. Admin mencatat penerimaan sebanyak 60 produk, kemudian sistem menambahkan stok sebanyak 60 produk. Sisa 40 produk tetap tercatat belum diterima.

Ketika supplier mengirimkan sisa 40 produk, admin melakukan pencatatan penerimaan berikutnya. Sistem menambahkan stok sebanyak 40 produk dan memperbarui status pengadaan menjadi Diterima Lengkap.

Setiap pencatatan penerimaan harus berdasarkan jumlah barang yang benar-benar diterima, bukan jumlah yang tercantum pada PO.

### Alur 3 — Pengelolaan Pergerakan Persediaan

**Aktor utama:** Admin Gudang dan Super Admin Owner.

1. Admin membuka halaman persediaan gudang.
2. Sistem menampilkan saldo stok produk yang tercatat.
3. Admin mencatat barang masuk atau barang keluar apabila terdapat pergerakan persediaan yang tidak tercatat melalui proses penerimaan pengadaan atau pemenuhan pesanan.
4. Admin memasukkan informasi produk, kuantitas, jenis pergerakan, dan keterangan yang diperlukan.
5. Sistem memvalidasi data pergerakan persediaan.
6. Sistem menyimpan transaksi pergerakan stok.
7. Sistem memperbarui saldo persediaan sesuai transaksi yang dicatat.
8. Sistem menyimpan riwayat pergerakan stok agar perubahan persediaan dapat ditelusuri.

**Catatan:** Pengurangan stok akibat pembayaran pesanan pelanggan dan penambahan stok dari penerimaan pengadaan harus terhubung dengan proses terkait. Admin tidak boleh mencatat ulang pergerakan yang sudah dihasilkan oleh proses tersebut karena dapat menyebabkan perubahan stok ganda.

### Alur 4 — Stock Opname dan Pelaporan Persediaan

**Aktor utama:** Admin Gudang dan Super Admin Owner.

1. Admin melakukan pemeriksaan fisik persediaan di gudang.
2. Admin mencatat jumlah stok fisik setiap produk atau varian yang diperiksa.
3. Sistem membandingkan jumlah stok fisik dengan saldo persediaan yang tercatat.
4. Jika jumlah sesuai, sistem menyimpan hasil pemeriksaan stock opname.
5. Jika ditemukan selisih, admin dapat memeriksa riwayat pergerakan stok untuk menelusuri perubahan persediaan.
6. Admin mencatat penyesuaian stok berdasarkan hasil pemeriksaan.
7. Sistem menyimpan catatan penyesuaian dan memperbarui saldo persediaan.
8. Sistem mempertahankan riwayat penyesuaian agar perubahan dapat ditelusuri.
9. Admin dapat melihat laporan persediaan dan laporan pengadaan berdasarkan data yang telah tersimpan.

Penyesuaian stok dilakukan oleh admin yang berwenang tanpa memerlukan persetujuan Owner. Setiap penyesuaian harus memiliki catatan yang menjelaskan perubahan dan hasil pemeriksaan.

### Penjelasan

Proses ini mencakup aktivitas pengadaan dan pengendalian persediaan produk MotifNesia. Pengelolaan supplier, pembuatan PO, komunikasi konfirmasi, dan pencatatan penerimaan dilakukan oleh pihak internal toko.

Supplier tidak memiliki akun atau portal pada sistem MotifNesia. Admin bertanggung jawab mengirimkan PO dan melakukan komunikasi eksternal dengan supplier. Informasi yang diperoleh dari komunikasi tersebut kemudian dicatat ke dalam sistem.

Penerimaan barang dapat dilakukan secara penuh maupun parsial. Sistem hanya menambahkan stok berdasarkan jumlah aktual barang yang diterima. Apabila penerimaan dilakukan secara bertahap, sisa barang tetap tercatat sebagai jumlah yang belum diterima hingga seluruh barang terpenuhi atau pengadaan diselesaikan sesuai keputusan yang berlaku.

Pengelolaan persediaan dilakukan pada satu gudang. Setiap pergerakan stok, baik barang masuk maupun barang keluar, perlu dicatat secara konsisten. Stock opname digunakan untuk membandingkan catatan sistem dengan kondisi fisik persediaan. Apabila terdapat selisih, admin dapat melakukan penyesuaian stok dan sistem menyimpan riwayat perubahan tersebut.

Laporan persediaan mencakup stok per produk atau varian, barang masuk dan keluar, stock opname, penyesuaian stok, serta informasi stok rendah. Laporan pengadaan mencakup data supplier, nomor PO, produk, jumlah pesanan, jumlah yang telah diterima, sisa penerimaan, status pengadaan, dan nilai pembelian atau harga modal.

---

## 3.3 Pemesanan dan Pengelolaan Transaksi

**Jumlah alur proses: 3**

### Tujuan Proses

Mengelola aktivitas pemesanan produk oleh Customer, pencatatan transaksi, pembayaran melalui payment gateway, serta pemantauan status pesanan dan pembayaran.

### Use Case yang Menggambarkan Proses

| ID | Use Case | Aktor |
|---|---|---|
| UC-14 | Mengelola Keranjang Belanja | Customer |
| UC-15 | Mengelola Alamat Pengiriman | Customer |
| UC-16 | Membuat Pesanan / Checkout | Customer |
| UC-17 | Melihat Riwayat Pesanan | Customer |
| UC-18 | Melihat Detail Pesanan | Customer |
| UC-19 | Mengelola Pesanan | Admin Kasir, Super Admin Owner |
| UC-20 | Memulai Pembayaran | Customer |
| UC-21 | Memproses Pembayaran | Payment Gateway |
| UC-22 | Menerima Notifikasi Pembayaran | Payment Gateway |
| UC-23 | Melihat Informasi Pembayaran | Customer, Admin Finance, Super Admin Owner |

### Alur 1 — Pemesanan Produk oleh Customer

**Aktor utama:** Customer.

1. Customer memilih produk dan memasukkannya ke dalam keranjang belanja.
2. Customer membuka keranjang untuk memeriksa produk dan jumlah yang dipilih.
3. Customer melanjutkan ke halaman checkout.
4. Customer memilih atau memasukkan alamat pengiriman.
5. Sistem memeriksa ketersediaan produk dan jumlah yang diminta.
6. Sistem menghitung nilai transaksi berdasarkan produk, kuantitas, dan ketentuan harga yang berlaku.
7. Sistem menampilkan ringkasan pesanan kepada Customer.
8. Customer memeriksa dan mengonfirmasi pesanan.
9. Sistem menyimpan data pesanan dan menghasilkan identitas pesanan.
10. Sistem menetapkan batas pembayaran sampai pukul 23.59 pada tanggal checkout.
11. Customer melanjutkan ke proses pembayaran melalui payment gateway.

Jika produk tidak tersedia atau jumlahnya tidak mencukupi, sistem menampilkan informasi bahwa pesanan tidak dapat dipenuhi sesuai permintaan. Customer perlu menyesuaikan keranjang sebelum melanjutkan checkout.

### Alur 2 — Pembayaran melalui Payment Gateway

**Aktor utama:** Customer dan Payment Gateway.

1. Customer memilih metode pembayaran yang tersedia.
2. Customer memulai pembayaran melalui MotifNesia.
3. Backend MotifNesia membuat permintaan transaksi kepada payment gateway berdasarkan data pesanan.
4. Payment gateway memproses permintaan dan menyediakan instruksi atau halaman pembayaran kepada Customer.
5. Customer menyelesaikan pembayaran melalui mekanisme yang disediakan payment gateway.
6. Payment gateway memproses transaksi pembayaran.
7. Payment gateway mengirimkan notifikasi hasil pembayaran kepada backend MotifNesia melalui mekanisme server-to-server.
8. Backend memvalidasi keaslian dan informasi notifikasi yang diterima.
9. Sistem memeriksa konsistensi transaksi dan memastikan notifikasi tidak diproses lebih dari satu kali.
10. Jika pembayaran berhasil dan notifikasi valid, sistem memperbarui status pembayaran menjadi Berhasil/Lunas.
11. Sistem memperbarui status pesanan menjadi Diproses.
12. Sistem mencatat pergerakan stok keluar berdasarkan jumlah produk dalam pesanan yang berhasil dibayar.
13. Jika pembayaran gagal, sistem mempertahankan status transaksi sesuai hasil yang diterima dari payment gateway.
14. Customer dapat melihat informasi pembayaran dan status pesanan melalui MotifNesia.

**Ketentuan batas waktu pembayaran:**

1. Batas pembayaran adalah pukul 23.59 pada tanggal checkout.
2. Jika pembayaran belum berhasil hingga batas waktu tersebut, sistem membatalkan pesanan secara otomatis.
3. Sistem memperbarui status pesanan menjadi Dibatalkan dan status pembayaran sesuai kondisi transaksi.
4. Jika stok sebelumnya telah dicadangkan atau dikurangi untuk pesanan tersebut, sistem mengembalikan stok sesuai jumlah yang terkait.
5. Perubahan stok dan status pembatalan harus dicatat agar tidak terjadi pengembalian stok ganda.
6. Apabila terdapat notifikasi pembayaran yang datang terlambat, backend harus memeriksa status transaksi dan batas waktu sebelum melakukan perubahan data. Penanganan kasus transaksi yang tidak konsisten perlu mengikuti mekanisme validasi dan rekonsiliasi yang dirancang.

**Catatan:** Payment gateway masih bersifat generik. Vendor, format callback, dan detail teknis integrasi belum ditetapkan.

### Alur 3 — Pengelolaan dan Pemantauan Pesanan

**Aktor utama:** Admin Kasir, Admin Finance, dan Super Admin Owner.

1. Admin membuka halaman pengelolaan pesanan.
2. Sistem menampilkan daftar pesanan beserta informasi status pesanan dan pembayaran.
3. Admin memilih pesanan untuk melihat informasi detail.
4. Sistem menampilkan rincian produk, customer, alamat pengiriman, nilai transaksi, dan informasi pembayaran sesuai hak akses.
5. Admin memantau perkembangan pesanan dan informasi transaksi.
6. Admin melakukan tindakan administratif yang diizinkan sesuai kondisi pesanan dan kewenangannya.
7. Sistem memvalidasi tindakan yang dilakukan.
8. Sistem menyimpan perubahan data dan riwayat pesanan.
9. Customer dapat melihat perkembangan pesanan melalui akun masing-masing.

### Penjelasan

Proses ini mengelola aktivitas pemesanan produk hingga pembayaran melalui payment gateway. Customer dapat memilih produk, mengelola keranjang, menentukan alamat pengiriman, dan mengonfirmasi pesanan melalui proses checkout.

Pembayaran dilakukan melalui payment gateway yang terhubung dengan backend MotifNesia. Customer tidak perlu mengunggah bukti pembayaran dan admin tidak melakukan verifikasi pembayaran secara manual.

Setelah menerima notifikasi pembayaran yang valid, backend memperbarui status pembayaran dan pesanan. Status pembayaran dan status pesanan merupakan dua informasi yang berbeda. Pembayaran yang berhasil menghasilkan status pembayaran Berhasil/Lunas dan status pesanan Diproses.

Batas pembayaran ditetapkan sampai pukul 23.59 pada tanggal checkout. Pesanan yang belum berhasil dibayar hingga batas tersebut dibatalkan secara otomatis dan stok dikembalikan sesuai jumlah yang terkait.

Admin Kasir berperan dalam pemantauan dan administrasi pesanan. Admin Finance dapat melihat informasi pembayaran untuk kebutuhan administrasi keuangan, sedangkan Super Admin Owner memiliki akses sesuai kewenangan administratifnya.

Backend harus menjaga konsistensi transaksi, mencegah pemrosesan notifikasi pembayaran berulang, dan memastikan perubahan status serta stok tidak tercatat lebih dari satu kali.

---

## 3.4 Pemenuhan Pesanan, Informasi Pengiriman, dan Layanan Purnajual

**Jumlah alur proses: 3**

### Tujuan Proses

Mendukung penyiapan dan pengiriman pesanan pelanggan, pencatatan informasi pengiriman, serta penanganan pengajuan retur, pemeriksaan produk, penukaran produk, dan pengembalian dana.

### Use Case yang Menggambarkan Proses

| ID | Use Case | Aktor |
|---|---|---|
| UC-24 | Menyiapkan dan Mengemas Pesanan | Admin Gudang, Super Admin Owner |
| UC-25 | Mencatat Informasi Pengiriman | Admin Kasir, Super Admin Owner |
| UC-26 | Melihat Informasi Pengiriman | Customer |
| UC-27 | Mengonfirmasi Penerimaan Pesanan | Customer |
| UC-39 | Mengajukan Retur Produk | Customer |
| UC-40 | Melihat Status Pengajuan Retur | Customer |
| UC-41 | Meninjau dan Mengelola Pengajuan Retur | Admin Kasir, Super Admin Owner |
| UC-42 | Mencatat Penerimaan dan Pemeriksaan Produk Retur | Admin Gudang, Super Admin Owner |
| UC-43 | Menentukan Penyelesaian Retur | Admin Kasir, Super Admin Owner |
| UC-44 | Memproses Penukaran Produk | Admin Gudang, Admin Kasir, Super Admin Owner |
| UC-45 | Memproses Pengembalian Dana | Admin Finance, Super Admin Owner |
| UC-46 | Melihat Status Pengembalian Dana | Customer |

### Alur 1 — Pemenuhan dan Pengiriman Pesanan

**Aktor utama:** Admin Gudang, Admin Kasir, dan Customer.

1. Pesanan yang telah berhasil dibayar dan berstatus Diproses diteruskan ke bagian gudang.
2. Admin Gudang membuka informasi pesanan yang harus dipenuhi.
3. Sistem menampilkan detail produk dan kuantitas sesuai pesanan.
4. Admin Gudang menyiapkan produk berdasarkan informasi pesanan.
5. Admin Gudang memeriksa kesesuaian produk dan jumlah barang.
6. Admin Gudang mengemas produk yang akan dikirim.
7. Paket diserahkan kepada jasa pengiriman.
8. Admin memperoleh informasi jasa pengiriman dan nomor resi apabila tersedia.
9. Admin Kasir mencatat nama jasa pengiriman dan nomor resi ke dalam MotifNesia.
10. Sistem menyimpan informasi pengiriman dan menghubungkannya dengan pesanan.
11. Customer melihat informasi pengiriman melalui detail pesanan.
12. Setelah barang diterima, Customer mengonfirmasi penerimaan pesanan melalui sistem.

Jika nomor resi belum tersedia, informasi pengiriman dapat dicatat terlebih dahulu tanpa nomor resi. Admin dapat memperbarui informasi tersebut setelah memperoleh nomor resi dari jasa pengiriman.

### Alur 2 — Pengajuan dan Pemeriksaan Retur

**Aktor utama:** Customer, Admin Kasir, dan Admin Gudang.

1. Customer membuka riwayat atau detail pesanan yang telah diterima.
2. Customer memilih produk yang ingin diajukan untuk retur.
3. Sistem memeriksa kelayakan pengajuan berdasarkan waktu penerimaan pesanan.
4. Pengajuan retur hanya dapat dilakukan maksimal tiga hari setelah Customer menerima produk.
5. Customer menjelaskan alasan pengajuan retur.
6. Customer wajib melampirkan foto atau video sebagai bukti kondisi produk.
7. Sistem memvalidasi kelengkapan pengajuan dan menyimpan data retur.
8. Admin Kasir meninjau pengajuan serta bukti yang diberikan Customer.
9. Admin menyetujui atau menolak pengajuan retur berdasarkan ketentuan yang berlaku.
10. Sistem menyimpan keputusan dan menginformasikannya kepada Customer.
11. Jika pengajuan ditolak, proses pengajuan retur berakhir dengan status penolakan.
12. Jika pengajuan disetujui, Customer mengirimkan produk kembali kepada pihak toko melalui mekanisme pengiriman yang ditentukan.
13. Admin Gudang menerima produk retur.
14. Admin Gudang memeriksa kondisi dan kesesuaian produk dengan pengajuan.
15. Admin mencatat hasil pemeriksaan ke dalam sistem.
16. Hasil pemeriksaan menjadi dasar penentuan penyelesaian retur oleh admin.

### Alur 3 — Penyelesaian Retur melalui Penukaran atau Refund

**Aktor utama:** Customer, Admin Kasir, Admin Gudang, dan Admin Finance.

1. Admin Kasir meninjau hasil pemeriksaan produk retur.
2. Admin menentukan tindak lanjut penyelesaian berdasarkan kondisi produk dan ketersediaan stok.
3. Jika produk yang diretur mengalami cacat dan produk yang sama masih tersedia, admin menetapkan penukaran dengan produk yang sama.
4. Jika produk yang sama tidak tersedia, admin mencari produk alternatif yang dapat ditawarkan kepada Customer.
5. Admin menyampaikan pilihan produk alternatif kepada Customer.
6. Jika Customer menyetujui produk alternatif, proses penukaran dilanjutkan.
7. Jika Customer tidak tertarik dengan produk alternatif, admin dapat menawarkan opsi pengembalian dana.
8. Jika Customer menerima opsi refund, proses pengembalian dana dilanjutkan.
9. Jika penyelesaian berupa penukaran:
   - Admin mencatat produk pengganti yang akan diberikan.
   - Admin Gudang memeriksa dan menyiapkan produk pengganti.
   - Pengiriman produk pengganti dilakukan secara manual di luar sistem.
   - Admin mencatat informasi penukaran dan status penyelesaiannya ke dalam MotifNesia.
10. Jika penyelesaian berupa refund:
    - Sistem mencatat keputusan pengembalian dana.
    - Admin Finance melakukan transfer dana secara manual melalui metode yang disepakati.
    - Admin Finance mencatat nominal, tanggal, referensi transaksi, dan bukti transfer.
    - Sistem memperbarui status pengembalian dana.
    - Customer dapat melihat status pengembalian dana melalui MotifNesia.
11. Sistem menyimpan hasil akhir penyelesaian retur.

**Ketentuan pencatatan stok barang retur:**

- Produk retur yang telah diperiksa dan dinyatakan layak dijual kembali dapat dimasukkan ke stok tersedia.
- Produk retur yang rusak atau tidak layak jual tidak boleh menambah stok tersedia.
- Status dan pencatatan barang retur harus dapat dibedakan dari stok produk yang siap dijual.
- Produk pengganti yang dikeluarkan untuk proses penukaran harus dicatat sebagai pergerakan stok keluar agar tidak terjadi pencatatan ganda.

### Penjelasan

Proses ini mencakup pemenuhan pesanan sejak pesanan siap diproses hingga produk diterima Customer, serta aktivitas layanan purnajual apabila terdapat pengajuan retur.

Pada pemenuhan pesanan, Admin Gudang menyiapkan dan mengemas produk berdasarkan informasi pesanan. Informasi jasa pengiriman dan nomor resi diperoleh melalui aktivitas operasional di luar sistem, kemudian dicatat oleh Admin Kasir ke dalam MotifNesia. Customer dapat melihat informasi tersebut dan mengonfirmasi penerimaan produk.

Pengajuan retur hanya dapat dilakukan maksimal tiga hari setelah produk diterima. Customer wajib menyertakan foto atau video sebagai bukti kondisi produk. Admin meninjau pengajuan dan menentukan apakah retur dapat dilanjutkan. Apabila disetujui, produk dikirim kembali oleh Customer dan diperiksa oleh Admin Gudang.

Hasil pemeriksaan menjadi dasar bagi admin untuk menentukan penyelesaian. Apabila produk cacat dan produk yang sama masih tersedia, admin menetapkan penggantian dengan produk yang sama. Jika produk yang sama tidak tersedia, admin menawarkan produk alternatif. Refund dapat ditawarkan apabila Customer tidak tertarik dengan produk alternatif tersebut.

Proses pengiriman produk pengganti dan transfer refund dilakukan secara manual di luar sistem. MotifNesia digunakan untuk mencatat informasi, status, dan hasil penyelesaian. Admin Finance bertanggung jawab mencatat proses refund beserta bukti transfer.

---

## 3.5 Pengelolaan Informasi Penjualan dan Laporan

**Jumlah alur proses: 1**

### Tujuan Proses

Menyediakan informasi penjualan berdasarkan data transaksi yang tersimpan di MotifNesia untuk mendukung pemantauan dan evaluasi aktivitas penjualan.

### Use Case yang Menggambarkan Proses

| ID | Use Case | Aktor |
|---|---|---|
| UC-62 | Mengelola Laporan Penjualan | Admin Finance, Super Admin Owner |

### Alur 1 — Pengelolaan Laporan Penjualan

**Aktor utama:** Admin Finance dan Super Admin Owner.

1. Admin membuka halaman laporan penjualan.
2. Sistem menampilkan pilihan periode laporan.
3. Admin menentukan periode yang ingin ditinjau.
4. Sistem mengambil data transaksi berdasarkan waktu pembayaran berhasil dalam periode yang dipilih.
5. Sistem mengolah data penjualan berdasarkan transaksi yang memenuhi ketentuan pelaporan.
6. Sistem menghitung nilai penjualan dan informasi transaksi terkait.
7. Sistem menghitung dan menampilkan nilai refund secara terpisah dari nilai penjualan.
8. Sistem menampilkan ringkasan laporan penjualan.
9. Admin meninjau informasi penjualan.
10. Admin dapat mengekspor laporan sesuai format yang disediakan sistem.

### Penjelasan

Proses ini memanfaatkan data transaksi yang telah tersimpan di MotifNesia untuk menyediakan informasi penjualan berdasarkan periode tertentu. Laporan digunakan oleh Admin Finance dan Super Admin Owner untuk memantau aktivitas transaksi serta mendukung evaluasi usaha.

Dasar pencatatan penjualan menggunakan waktu pembayaran berhasil, bukan hanya waktu pembuatan pesanan. Dengan demikian, transaksi yang belum berhasil dibayar tidak dianggap sebagai penjualan berhasil.

Transaksi yang mengalami refund tetap diperhitungkan dalam pelaporan, tetapi nilai refund ditampilkan secara terpisah. Pemisahan tersebut diperlukan agar informasi penjualan dan pengembalian dana dapat ditinjau secara jelas tanpa mencampurkan status pembayaran dengan status pesanan.

Laporan persediaan dan pengadaan tidak dimasukkan ke dalam proses ini karena telah dicakup dalam proses 2.3.2.

---

## 3.6 Pengelolaan Membership dan Promosi Pelanggan

**Jumlah alur proses: 3**

### Tujuan Proses

Mendukung program loyalitas pelanggan melalui pendaftaran membership, pengelolaan poin dan reward, serta penyampaian informasi promosi kepada seluruh Customer melalui email.

### Use Case yang Menggambarkan Proses

| ID | Use Case | Aktor |
|---|---|---|
| UC-52 | Melihat Informasi Membership | Customer |
| UC-53 | Mendaftar Membership | Customer |
| UC-54 | Menukarkan Poin dengan Reward | Customer |
| UC-55 | Mengelola Program Membership | Admin Kasir, Super Admin Owner |
| UC-56 | Mengelola Reward Membership | Admin Kasir, Super Admin Owner |
| UC-57 | Mengelola Poin Membership | Admin Kasir, Super Admin Owner |
| UC-58 | Melihat Notifikasi | Customer, Admin Finance, Admin Kasir, Admin Gudang, Super Admin Owner |
| UC-59 | Mengelola Notifikasi | Customer |
| UC-60 | Mengelola Konten Promosi | Admin Kasir, Super Admin Owner |
| UC-61 | Mengirim Broadcast Promosi | Admin Kasir, Super Admin Owner |

### Alur 1 — Pengelolaan Program Membership dan Reward

**Aktor utama:** Admin Kasir dan Super Admin Owner.

1. Admin membuka halaman pengelolaan membership.
2. Sistem menampilkan informasi program membership yang tersedia.
3. Admin membuat atau memperbarui informasi program membership sesuai kewenangannya.
4. Admin mengelola data reward yang tersedia.
5. Admin menentukan informasi kebutuhan poin untuk penukaran reward sesuai ketentuan program yang berlaku.
6. Sistem memvalidasi dan menyimpan perubahan program membership serta reward.
7. Sistem menyediakan informasi membership dan reward untuk dilihat Customer.
8. Sistem mencatat perubahan data program dan reward.

**Catatan:** Mekanisme perolehan poin, rasio pemberian poin, masa berlaku poin, dan ketentuan lain yang belum disepakati tidak boleh dianggap sebagai aturan final.

### Alur 2 — Pendaftaran dan Penukaran Reward Membership

**Aktor utama:** Customer.

1. Customer membuka halaman informasi membership.
2. Sistem menampilkan informasi program membership dan status keanggotaan Customer.
3. Customer mendaftar membership apabila belum terdaftar.
4. Sistem memvalidasi dan menyimpan status membership Customer.
5. Customer melihat jumlah poin dan informasi reward yang tersedia.
6. Customer memilih reward berbentuk voucher yang ingin ditukarkan.
7. Sistem memeriksa saldo poin serta ketentuan penukaran reward.
8. Jika memenuhi ketentuan, sistem mengurangi poin dan mencatat transaksi penukaran.
9. Sistem memperbarui informasi saldo poin dan riwayat penukaran.
10. Customer menerima informasi hasil penukaran reward.

Jika poin tidak mencukupi atau reward tidak tersedia, sistem menampilkan informasi bahwa penukaran tidak dapat dilanjutkan.

**Ketentuan pembatalan atau refund transaksi:**

Apabila transaksi yang sebelumnya menghasilkan poin dibatalkan atau direfund, poin yang telah diberikan dari transaksi tersebut harus dikurangi kembali sesuai jumlah poin yang sebelumnya diperoleh Customer dari transaksi tersebut.

### Alur 3 — Pengelolaan dan Pengiriman Broadcast Promosi

**Aktor utama:** Admin Kasir dan Super Admin Owner.

1. Admin membuka halaman pengelolaan promosi.
2. Sistem menampilkan konten promosi yang tersedia.
3. Admin membuat atau memilih konten promosi yang akan disampaikan.
4. Admin menyusun pesan broadcast berdasarkan konten promosi.
5. Sistem memvalidasi kelengkapan informasi dan menampilkan pratinjau pesan.
6. Admin memeriksa isi pesan dan mengonfirmasi pengiriman.
7. Sistem menyiapkan daftar seluruh Customer sebagai penerima broadcast.
8. Sistem mengirimkan pesan promosi melalui email.
9. Sistem mencatat informasi broadcast dan hasil pemrosesan pengiriman.
10. Customer menerima pesan melalui email sesuai hasil pengiriman layanan email.

### Penjelasan

Proses ini mendukung pengelolaan program loyalitas dan penyampaian informasi promosi kepada Customer. Program membership menyediakan fasilitas pendaftaran, informasi poin, riwayat poin, serta penukaran poin dengan reward berbentuk voucher.

Admin Kasir dan Super Admin Owner bertanggung jawab mengelola program membership, reward, serta informasi poin sesuai kewenangannya. Customer dapat melihat informasi keanggotaan dan melakukan penukaran reward apabila memenuhi ketentuan yang berlaku.

Mekanisme perolehan poin belum ditetapkan secara final sehingga rasio pemberian poin, masa berlaku, dan ketentuan tambahan perlu ditentukan pada tahap perancangan aturan bisnis. Namun, apabila transaksi yang menghasilkan poin dibatalkan atau direfund, poin yang sebelumnya diberikan harus dikurangi kembali.

Promosi disampaikan melalui email kepada seluruh Customer. Broadcast merupakan komunikasi satu arah yang digunakan untuk menyampaikan informasi promosi, sedangkan live chat merupakan komunikasi dua arah yang dibahas dalam proses 2.3.7.

Notifikasi dapat diakses oleh Customer dan seluruh peran admin sesuai hak aksesnya. Customer dapat mengelola notifikasi miliknya, termasuk menghapus notifikasi yang tidak lagi diperlukan.

---

## 3.7 Pengelolaan Interaksi dan Preferensi Pelanggan

**Jumlah alur proses: 3**

### Tujuan Proses

Menyediakan fasilitas komunikasi antara Customer dan pihak toko melalui live chat serta mendukung pengelolaan preferensi produk dan penyampaian ulasan produk.

### Use Case yang Menggambarkan Proses

| ID | Use Case | Aktor |
|---|---|---|
| UC-47 | Mengelola Percakapan Live Chat | Customer, Admin Kasir, Super Admin Owner |
| UC-48 | Mengelola Produk Favorit | Customer |
| UC-49 | Mengirim Ulasan Produk | Customer |
| UC-50 | Melihat Ulasan Produk | Guest, Customer |
| UC-51 | Memoderasi Ulasan Produk | Tidak menjadi aktivitas TO-BE yang disepakati; perlu evaluasi atau penghapusan dari cakupan proses |

### Alur 1 — Interaksi Customer melalui Live Chat

**Aktor utama:** Customer, Admin Kasir, dan Super Admin Owner.

1. Customer membuka fitur live chat pada MotifNesia.
2. Sistem menampilkan percakapan yang telah tersedia atau menyediakan fasilitas percakapan baru.
3. Customer mengirimkan pesan kepada pihak toko.
4. Sistem menyimpan pesan dan menyampaikannya kepada pihak admin secara real-time.
5. Admin Kasir atau Super Admin Owner membuka percakapan pelanggan sesuai hak aksesnya.
6. Admin membaca pesan yang dikirimkan Customer.
7. Admin memberikan balasan melalui fitur live chat.
8. Sistem menyimpan dan menyampaikan balasan kepada Customer secara real-time.
9. Customer dan admin dapat melanjutkan percakapan sesuai kebutuhan.
10. Sistem menyimpan riwayat percakapan agar dapat diakses kembali oleh pihak yang berwenang.

### Alur 2 — Pengelolaan Produk Favorit

**Aktor utama:** Customer.

1. Customer membuka katalog atau detail produk.
2. Customer memilih produk yang ingin disimpan sebagai favorit.
3. Sistem memeriksa keberadaan produk dan identitas Customer.
4. Sistem menyimpan produk ke dalam daftar favorit milik Customer.
5. Customer membuka halaman produk favorit.
6. Sistem menampilkan daftar produk yang telah disimpan.
7. Customer dapat menghapus produk dari daftar favorit atau membuka detail produk untuk melihat informasi lebih lanjut.

### Alur 3 — Pengiriman dan Penampilan Ulasan Produk

**Aktor utama:** Customer dan Guest.

1. Customer membuka detail produk yang pernah dibelinya.
2. Customer memilih produk yang ingin diberikan ulasan.
3. Sistem memeriksa riwayat transaksi untuk memastikan Customer pernah membeli produk tersebut.
4. Jika memenuhi ketentuan, Customer memberikan rating dan komentar terhadap produk.
5. Sistem memvalidasi kelengkapan dan format ulasan.
6. Sistem menyimpan ulasan yang valid.
7. Sistem mempublikasikan ulasan secara langsung tanpa menunggu persetujuan admin.
8. Guest dan Customer dapat melihat ulasan yang telah dipublikasikan pada halaman produk.

Jika Customer belum pernah membeli produk terkait atau data ulasan tidak memenuhi validasi, sistem menolak penyimpanan ulasan dan memberikan informasi yang sesuai.

### Penjelasan

Proses ini mendukung komunikasi dan interaksi pelanggan dengan pihak toko melalui fitur live chat, pengelolaan produk favorit, serta ulasan produk.

Live chat digunakan sebagai sarana komunikasi dua arah antara Customer dan pihak toko. Customer dapat menyampaikan pertanyaan mengenai produk, ukuran, bahan, ketersediaan, atau informasi lain yang berkaitan dengan pembelian. Admin dapat membaca dan membalas pesan melalui sistem. Pertukaran pesan dirancang berlangsung secara real-time, sedangkan teknologi yang digunakan akan ditentukan pada tahap perancangan teknis.

Fitur produk favorit memungkinkan Customer menyimpan produk yang ingin dilihat kembali. Daftar tersebut dikelola berdasarkan akun Customer sehingga setiap pengguna hanya dapat mengelola daftar favorit miliknya.

Customer yang pernah membeli produk dapat memberikan rating dan ulasan terhadap produk tersebut. Ulasan yang valid langsung dipublikasikan sehingga dapat dilihat oleh Guest dan Customer lainnya. Rancangan TO-BE terbaru tidak menetapkan proses moderasi admin sebelum publikasi ulasan. Oleh karena itu, aktivitas moderasi tidak menjadi bagian dari alur utama proses ini.

Dengan pembagian tersebut, proses 2.3.1 berfokus pada pengelolaan informasi katalog, sedangkan proses 2.3.7 berfokus pada komunikasi, preferensi, dan interaksi pelanggan.

---

# 4. Aturan Bisnis Lintas Proses

Bagian ini merangkum aturan bisnis yang berlaku pada lebih dari satu proses TO-BE.

| ID | Area | Aturan Bisnis |
|---|---|---|
| RB-01 | Hak Akses | Setiap admin memiliki hak akses sesuai perannya. Super Admin Owner dapat mengelola Admin Finance, Admin Kasir, dan Admin Gudang, tetapi tidak dapat mengelola akun Owner lainnya. |
| RB-02 | Supplier | Supplier tidak memiliki akun sistem. Komunikasi pengadaan dilakukan melalui kanal eksternal dan hasilnya dicatat admin. |
| RB-03 | Pengiriman | Tidak terdapat integrasi API jasa pengiriman. Informasi pengiriman dan nomor resi dicatat secara manual oleh pihak internal. |
| RB-04 | Persediaan | Sistem menggunakan satu gudang sebagai lokasi pengelolaan stok. |
| RB-05 | Pembayaran | Pembayaran diproses melalui payment gateway generik. Tidak menggunakan verifikasi bukti transfer manual. |
| RB-06 | Batas Pembayaran | Pembayaran harus berhasil paling lambat pukul 23.59 pada tanggal checkout. |
| RB-07 | Pembatalan Pesanan | Pesanan yang belum berhasil dibayar sampai batas waktu otomatis dibatalkan. |
| RB-08 | Pengembalian Stok | Pembatalan pesanan yang sebelumnya mengurangi atau mencadangkan stok harus mengembalikan stok sesuai jumlah yang terkait. |
| RB-09 | Status Transaksi | Status pembayaran dan status pesanan dikelola secara terpisah. |
| RB-10 | Penerimaan Barang | Stok bertambah berdasarkan jumlah aktual barang yang diterima, termasuk penerimaan parsial. |
| RB-11 | Stock Opname | Penyesuaian stok dapat dilakukan admin berwenang tanpa persetujuan Owner dan harus memiliki catatan. |
| RB-12 | Barang Retur | Barang retur yang layak jual dapat masuk stok tersedia. Barang rusak tidak boleh menambah stok tersedia. |
| RB-13 | Batas Retur | Pengajuan retur maksimal tiga hari setelah produk diterima Customer. |
| RB-14 | Bukti Retur | Pengajuan retur wajib disertai foto atau video bukti kondisi produk. |
| RB-15 | Penyelesaian Retur | Admin menentukan penyelesaian berdasarkan hasil pemeriksaan, dengan prioritas penggantian produk yang sama jika tersedia. |
| RB-16 | Refund | Pengembalian dana dilakukan manual oleh Admin Finance dan dicatat dalam sistem beserta bukti transfer. |
| RB-17 | Membership | Sistem mendukung membership, poin, dan reward berbentuk voucher. |
| RB-18 | Pengurangan Poin | Poin yang telah diperoleh dari transaksi harus dikurangi kembali apabila transaksi tersebut dibatalkan atau direfund. |
| RB-19 | Ulasan | Hanya Customer yang pernah membeli produk terkait yang dapat mengirim ulasan. Ulasan valid langsung dipublikasikan. |
| RB-20 | Live Chat | Komunikasi live chat dirancang berlangsung secara real-time. Detail teknologi ditetapkan pada tahap perancangan. |
| RB-21 | Broadcast | Broadcast promosi dikirim melalui email kepada seluruh Customer. |
| RB-22 | Notifikasi | Customer dan seluruh peran admin dapat mengakses notifikasi sesuai hak akses. Customer dapat menghapus notifikasi miliknya. |
| RB-23 | Laporan Penjualan | Dasar pencatatan penjualan adalah waktu pembayaran berhasil. |
| RB-24 | Laporan Refund | Transaksi yang direfund tetap diperhitungkan dan nilai refund ditampilkan secara terpisah. |
| RB-25 | Riwayat Perubahan | Perubahan penting pada transaksi, pengadaan, dan persediaan harus dapat ditelusuri melalui pencatatan sistem. |

---

# 5. Hal yang Masih Memerlukan Keputusan atau Evaluasi

Aturan berikut belum ditetapkan secara lengkap. Oleh karena itu, jangan menganggapnya sebagai ketentuan final dalam pemodelan kebutuhan sistem.

| No. | Area | Hal yang Belum Diputuskan | Dampak |
|---|---|---|---|
| 1 | Payment Gateway | Vendor payment gateway dan spesifikasi integrasi. | Perancangan API dan mekanisme komunikasi eksternal. |
| 2 | Payment Gateway | Detail validasi signature, autentikasi callback, idempotency key, retry, dan rekonsiliasi transaksi. | Keamanan dan konsistensi status pembayaran. |
| 3 | Payment Gateway | Penanganan kasus callback terlambat atau pembayaran terkonfirmasi setelah pesanan kedaluwarsa. | Konsistensi pembayaran, pesanan, dan stok. |
| 4 | Pengadaan | Format, penomoran, dan versi dokumen PO. | Standar dokumen pengadaan. |
| 5 | Pengadaan | Ketentuan detail perubahan atau pembatalan PO setelah dikirim kepada supplier. | Pengelolaan komunikasi eksternal dan status pengadaan. |
| 6 | Pengadaan | Penanganan apabila jumlah barang yang diterima melebihi jumlah PO. | Validasi penerimaan dan penambahan stok. |
| 7 | Retur | Biaya pengiriman produk retur dan pihak yang menanggungnya. | Ketentuan operasional retur. |
| 8 | Retur | Detail kondisi produk yang dapat diterima sebagai retur selain ketentuan produk cacat. | Proses pemeriksaan produk. |
| 9 | Retur | Metode dan batas waktu pengiriman produk retur. | Proses penerimaan produk retur. |
| 10 | Membership | Rasio perolehan poin dari transaksi atau aktivitas pelanggan. | Perhitungan poin. |
| 11 | Membership | Masa berlaku poin dan aturan kedaluwarsa. | Pengelolaan saldo poin. |
| 12 | Membership | Detail ketentuan penggunaan voucher dan masa berlaku reward. | Penukaran reward. |
| 13 | Live Chat | Teknologi dan mekanisme teknis komunikasi real-time. | Perancangan backend dan komunikasi client. |
| 14 | Broadcast Email | Layanan email, mekanisme retry, serta pencatatan status diterima atau gagal dikirim. | Pengiriman dan pemantauan broadcast. |
| 15 | Notifikasi | Kebijakan penyimpanan, retensi, dan penghapusan notifikasi. | Pengelolaan data notifikasi. |
| 16 | Laporan | Detail format ekspor dan periode laporan yang disediakan. | Penyajian laporan. |

Keputusan atas hal-hal tersebut dapat dilakukan pada tahap analisis lanjutan dan perancangan sistem. Sampai keputusan ditetapkan, dokumen kebutuhan harus tetap membedakan aturan yang telah disepakati dari hal yang masih memerlukan evaluasi.

---

# 6. Catatan Sinkronisasi Use Case

Daftar Use Case dalam dokumen ini merupakan pemetaan awal berdasarkan proses TO-BE. Pemetaan akhir harus diselaraskan dengan daftar 64 UC, Kebutuhan Fungsional, dan Skenario Use Case.

Beberapa hal yang perlu diperhatikan:

1. UC-01 sampai UC-08 berkaitan dengan autentikasi, akun, profil, hak akses, dan pengelolaan pelanggan. Fungsi tersebut merupakan fungsi pendukung lintas proses dan perlu dipetakan secara eksplisit ke KF.
2. UC-51 Memoderasi Ulasan Produk tidak lagi sesuai dengan alur TO-BE terbaru karena ulasan valid langsung dipublikasikan. UC tersebut perlu dievaluasi untuk dihapus dari kebutuhan target atau ditetapkan ulang jika ditemukan kebutuhan moderasi yang benar-benar disepakati.
3. UC-58 Melihat Notifikasi melibatkan Customer dan seluruh peran admin.
4. UC-59 Mengelola Notifikasi pada rancangan ini berfokus pada pengelolaan notifikasi milik Customer, termasuk penghapusan.
5. UC-62 menggunakan waktu pembayaran berhasil sebagai dasar periode penjualan dan memisahkan nilai refund.
6. UC-63 dan UC-64 merupakan bagian dari proses pengadaan dan persediaan, bukan proses laporan penjualan.
7. Seluruh UC yang tidak tercantum pada tabel proses tertentu tetap harus diperiksa dan diberikan hubungan yang jelas dengan KF atau ditandai sebagai fungsi pendukung yang perlu dievaluasi.

---

# 7. Penutup

Ketujuh proses bisnis TO-BE MotifNesia menggambarkan rancangan aktivitas sistem yang mencakup pengelolaan katalog, pengadaan dan persediaan, pemesanan dan transaksi, pemenuhan pesanan dan layanan purnajual, pelaporan penjualan, membership dan promosi, serta interaksi dan preferensi pelanggan.

Pembagian proses tersebut digunakan sebagai acuan untuk menyusun BPMN, Kebutuhan Fungsional, Use Case, dan Skenario Use Case. Setiap artefak kebutuhan harus memiliki hubungan yang jelas dengan proses bisnis yang digambarkan.

Keputusan bisnis yang telah ditetapkan harus diterapkan secara konsisten pada seluruh dokumen. Sementara itu, hal-hal yang belum diputuskan harus ditandai sebagai kebutuhan yang memerlukan evaluasi lebih lanjut dan tidak boleh diisi menggunakan asumsi tanpa dasar.

Dengan demikian, dokumen ini menjadi acuan struktur proses bisnis TO-BE dalam sinkronisasi kebutuhan sistem MotifNesia.
