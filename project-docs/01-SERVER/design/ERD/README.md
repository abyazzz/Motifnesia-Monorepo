# ERD Server

## CURRENT / AS-IMPLEMENTED

Ringkasan memiliki 42 tabel. Hubungan diambil dari 53 definisi FK aktual. Atribut pada diagram menonjolkan PK, FK, dan UK. Tipe, nullable, FK, kardinalitas, relasi model dan bukti per baris tersedia dalam kamus data. Self-reference pada akun mencatat pengubah status. Morfisme token dan hubungan berbasis model dijelaskan di kamus data. [Mermaid keseluruhan](current-overview.mmd) · [Draw.io lima tab](current.drawio) · [Kamus skema](../DATABASE-DESIGN/SCHEMA-CURRENT.md)

| Diagram Mermaid | Kelompok | Entitas utama |
| --- | --- | --- |
| [current-01.mmd](current-01.mmd) | Akun dan katalog | 13 |
| [current-02.mmd](current-02.mmd) | Pesanan, pembayaran dan retur | 11 |
| [current-03.mmd](current-03.mmd) | Persediaan dan pengadaan | 6 |
| [current-04.mmd](current-04.mmd) | Membership dan komunikasi | 6 |
| [current-05.mmd](current-05.mmd) | Infrastruktur Laravel | 6 |

## TARGET / PROPOSED

Sumber proses target ada di TO-BE dan TA final. Diagram menawarkan 14 entitas teknis usulan. Node berlabel PROPOSED mendokumentasikan entitas baru. Nama tanpa label menandai tabel acuan yang sudah ada. [Draw.io empat tab](target.drawio) · [Aturan, atribut, dan keputusan](../DATABASE-DESIGN/SCHEMA-TARGET.md)

| Diagram Mermaid | Kelompok | Entitas PROPOSED |
| --- | --- | --- |
| [target-01.mmd](target-01.mmd) | Pembayaran dan pengiriman | 4 |
| [target-02.mmd](target-02.mmd) | PO dan penerimaan | 4 |
| [target-03.mmd](target-03.mmd) | Retur dan refund | 3 |
| [target-04.mmd](target-04.mmd) | Membership, broadcast dan akuntabilitas | 3 |

Garis satu-ke-banyak menggambarkan kemungkinan banyak child. Nol atau satu pada sisi parent berarti FK opsional. Indeks unik dan catatan constraint merujuk kamus data. Diagram ini diturunkan dari source dan tidak memeriksa data fisik instalasi lokal.
