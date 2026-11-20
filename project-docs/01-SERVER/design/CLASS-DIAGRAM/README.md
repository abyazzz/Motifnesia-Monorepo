# Class Diagram Server

## CURRENT / AS-IMPLEMENTED

Inventaris mencakup 101 class dalam `app/`, termasuk 41 Controller, 37 model, 7 service, 4 Form Request, 2 middleware, 4 observer, 4 class Support, 1 provider dan 1 command. Diagram dikelompokkan agar method terbaca. Untuk signature lengkap, cakupan route, dependensi lintas diagram dan sumber bukti, gunakan inventaris. [Draw.io](current.drawio) · [Controller](CONTROLLERS-CURRENT.md) · [Model dan pendukung](PENDUKUNG-CURRENT.md)

| Mermaid | Bagian | Class utama | Method |
| --- | --- | --- | --- |
| [current-01.mmd](current-01.mmd) | Pendukung · Console | 1 | 1 |
| [current-02.mmd](current-02.mmd) | Controller Admin Commerce | 11 | 56 |
| [current-03.mmd](current-03.mmd) | Controller Admin Warehouse | 4 | 18 |
| [current-04.mmd](current-04.mmd) | Controller Api | 6 | 37 |
| [current-05.mmd](current-05.mmd) | Controller Auth | 1 | 2 |
| [current-06.mmd](current-06.mmd) | Controller Controllers | 2 | 5 |
| [current-07.mmd](current-07.mmd) | Controller Customer Experience | 9 | 38 |
| [current-08.mmd](current-08.mmd) | Controller Customer Orders | 7 | 28 |
| [current-09.mmd](current-09.mmd) | Controller Supplier | 1 | 4 |
| [current-10.mmd](current-10.mmd) | Pendukung · Middleware | 2 | 5 |
| [current-11.mmd](current-11.mmd) | Pendukung · Requests | 4 | 16 |
| [current-12.mmd](current-12.mmd) | Model · Akun dan katalog | 11 | 33 |
| [current-13.mmd](current-13.mmd) | Model · Membership dan komunikasi | 6 | 18 |
| [current-14.mmd](current-14.mmd) | Model · Pesanan, pembayaran dan retur | 11 | 36 |
| [current-15.mmd](current-15.mmd) | Model · Model tanpa tabel dari migration | 3 | 6 |
| [current-16.mmd](current-16.mmd) | Model · Persediaan dan pengadaan | 6 | 19 |
| [current-17.mmd](current-17.mmd) | Pendukung · Observers | 4 | 7 |
| [current-18.mmd](current-18.mmd) | Pendukung · Providers | 1 | 2 |
| [current-19.mmd](current-19.mmd) | Pendukung · Services | 7 | 33 |
| [current-20.mmd](current-20.mmd) | Pendukung · Support | 4 | 10 |

## TARGET / PROPOSED

Ada 18 class usulan dari gap Use Case. Pilihan menambah class atau memperluas modul yang ada harus diputuskan bersama tim. [Draw.io](target.drawio) · [Tanggung jawab dan metode usulan](TARGET-DESIGN.md)

| Mermaid | Bagian | Class utama PROPOSED |
| --- | --- | --- |
| [target-01.mmd](target-01.mmd) | Akun, ulasan dan komunikasi | 6 |
| [target-02.mmd](target-02.mmd) | Pesanan, pembayaran dan pengiriman | 6 |
| [target-03.mmd](target-03.mmd) | Pengadaan, purnajual dan laporan | 6 |

Draw.io memakai tab per modul. Diagram menampilkan relasi waris, dependensi yang dapat dilacak, dan relasi model yang terlihat dalam scope diagram. Inventaris adalah daftar lengkap metode.
