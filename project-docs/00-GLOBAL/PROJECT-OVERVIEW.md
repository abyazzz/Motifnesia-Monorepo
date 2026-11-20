# Ikhtisar proyek

MotifNesia menghubungkan belanja produk batik dengan transaksi, inventaris, pengadaan, keanggotaan, dan layanan purnajual. Tim mengembangkan fondasi aplikasi yang sudah tersedia. Rancangan target mengikuti [sumber acuan](SOURCE-OF-TRUTH.md).

| Aplikasi | Tanggung jawab AS-IMPLEMENTED | Akses pengembangan |
| --- | --- | --- |
| Server | Laravel 12, database MySQL pada konfigurasi contoh, Sanctum, REST API v1, penyimpanan berkas dan bukti | `127.0.0.1:8000` |
| Client Web | Laravel 12, Blade dan Vite, proxy HTTP ke API, sesi token pada server Web | `127.0.0.1:8001` |
| Client Mobile | Flutter dan Dart, route per peran, HTTP langsung ke API, penyimpanan token aman pada platform native dan sesi memori pada web | `127.0.0.1:8002` dalam mode web |

Publik dan Customer mengakses katalog. Finance, Kasir, Gudang, dan Owner memperoleh kemampuan sesuai Gate. Aplikasi aktual juga mempunyai akun dan portal Supplier. Supplier berkomunikasi eksternal dalam target sehingga kebijakan pemindahan akses perlu keputusan tim. Gateway merupakan sistem eksternal pada target. [Arsitektur](architecture/README.md) · [Gap](GAP-ANALYSIS.md)

Sebelas dokumen sumber disalin sesuai scope. Temuan teknis membedakan registrasi route, kontrak yang disimpulkan dari kode, dan perilaku yang memerlukan uji runtime. [Indeks referensi](references/README.md) · [Traceability](TRACEABILITY-MATRIX.md)
