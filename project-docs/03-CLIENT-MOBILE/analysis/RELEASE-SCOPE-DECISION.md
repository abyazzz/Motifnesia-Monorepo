# Keputusan scope Web dan Mobile — FINAL

Pemilik proyek menetapkan cakupan fitur, 18 KF, 64 UC, aktor, kewenangan, dan proses bisnis yang berlaku **1:1** pada Web dan Mobile. Keduanya memakai API Server yang sama. Perbedaan layout, navigasi, interaksi dan kemampuan perangkat dapat disesuaikan. Ini adalah target bisnis, bukan bukti semua fitur sudah berjalan saat ini.

Aktor aktual mencakup Guest, Customer, Owner, Finance, Kasir, Gudang dan Supplier. Aktor target TA dan TO-BE mencakup enam role manusia serta Payment Gateway sebagai sistem eksternal. RB-02 menyebut Supplier pihak eksternal. Instruksi Phase 3 menyebut kemampuan Supplier setara Web dan Mobile. Kesetaraan di kedua client berlaku untuk setiap kemampuan Supplier yang disetujui, tetapi pemberian akses langsung Supplier dalam target tetap **NEEDS OWNER CONFIRMATION** karena konflik dengan RB-02. Portal Supplier aktual harus dinilai transisinya tanpa menghapus akses sepihak.

[Matriks 1:1 per UC, KF dan aktor](../../PARITAS-WEB-MOBILE.md) · [Keputusan](../../00-GLOBAL/DECISION-LOG.md)

## Riwayat Phase 2

Analisis alternatif berikut dipertahankan sebagai konteks historis. Status NEEDS APPROVAL tentang pilihan A/B/C telah digantikan oleh keputusan 1:1 Phase 3. Pernyataan opsi dan status dalam kutipan merupakan kondisi Phase 2.

<details><summary>Analisis historis Phase 2</summary>

# Analisis scope rilis Mobile · NEEDS APPROVAL

Flutter saat ini memiliki 43 route, termasuk 3 autentikasi, 16 publik/Customer, 22 admin, dan 2 supplier. [Registri route](../../../Motifnesia-Client-Mobile/lib/app/routes) · [Audit Mobile](AUDIT.md). Draft TA Mobile menekankan calon pelanggan dan pelanggan, sedangkan daftar 64 UC memetakan aktor sistem tanpa menetapkan seluruh platform. [Referensi](../REFERENCES-INDEX.md)

TO-BE RB-02 menetapkan supplier sebagai pihak eksternal. Karena itu portal Supplier yang saat ini ada merupakan pilihan transisi yang perlu keputusan eksplisit jika dipertahankan. Tidak ada pilihan rilis yang diputuskan dalam analisis ini.

| Alternatif | UC dan screen | API dan dampak Flutter | Pengujian | Kelebihan | Kekurangan dan risiko |
| --- | --- | --- | --- | --- | --- |
| A · Guest dan Customer | UC-01–06, 09–11, 14–18, 20/23, 26/27, 39/40/46–50, 52–54, 58/59 sesuai aktor; 19 layar publik/Customer termasuk auth. Admin melalui Web. Portal supplier Web hanya opsi transisi yang bertentangan dengan target RB-02. | Gunakan API v1 customer, gateway dan retur target TBD. Batasi entry/menu role lain setelah keputusan. | Autentikasi, sesi, katalog, checkout, gateway, pengiriman, retur, akses milik akun dan perangkat. | Fokus pada pemakai utama draft TA Mobile dan cakupan uji lebih kecil. | Admin membutuhkan Web. Portal supplier perlu keputusan transisi dan akhirnya penyesuaian terhadap RB-02. |
| B · Semua role | Seluruh screen Customer, 22 route admin dan 2 route supplier aktual; UC sesuai aktor. | Pertahankan registri role dan sinkronkan izin, kontrak dan alur target. Supplier direct access memerlukan perubahan keputusan RB-02 atau periode transisi disepakati. | Matriks seluruh role, perangkat, Gate, keamanan, regresi Web dan Mobile. | Satu client dapat melayani seluruh role saat operasional. | Lingkup dan biaya uji besar, akses supplier berbeda dengan target final dan belum memiliki dasar sebagai aktor target. |
| C · Customer dan Admin Gudang sebagai opsi | Customer serta UC-12/13, 24/25, 28–38, 42, 63/64 sesuai peran Gudang; screen produk, stok, PO, penerimaan, pengiriman dan inspeksi. Supplier eksternal. | Perlu perubahan Gate produk dan kontrak PO, resi, penerimaan parsial dan inspeksi. Sebagian API target belum ada. Scope Gudang dan peran Owner sebagai admin penuh perlu diputuskan. | Alur gudang, offline/interupsi, transaksi stok, duplikasi aksi, role, serta seluruh flow Customer. | Mendukung kerja gudang pada perangkat genggam. | Kebutuhan operasional Mobile Gudang belum dibuktikan, risiko migrasi hak akses dan ketergantungan endpoint. |

UC-21 dan UC-22 merupakan interaksi gateway–Server. UI Customer menampilkan inisiasi serta hasil melalui kontrak yang disepakati. [Wireframe Customer dan opsi bersyarat](../design/UI-UX/wireframes/README.md) · [Keputusan O-04](../../00-GLOBAL/DECISION-LOG.md)

Keputusan pemilik proyek diperlukan untuk memilih role per platform, Owner pada alternatif C, kebijakan portal Supplier selama transisi, dan cakupan pengujian perangkat.


</details>
