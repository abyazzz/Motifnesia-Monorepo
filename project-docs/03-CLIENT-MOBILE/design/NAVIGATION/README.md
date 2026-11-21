# Navigation Map Client Mobile

[Diagram menyeluruh aktual](current-overview.mmd) · [Diagram menyeluruh target](target-overview.mmd) · [Pemetaan layar ke UC dan API](../SCREEN-SPECIFICATION/README.md)

Jalur dalam diagram aktual mengelompokkan halaman yang dicapai melalui navigasi utama. Detail dinamis, form create/edit, dan tindakan terotorisasi dapat muncul melalui halaman induk. Server tetap memeriksa akses per tindakan. Alias Web dan route tindakan ada di audit. Peta target mengikuti UC akhir per aktor dan tidak membuka menu sebelum ada kontrak yang sesuai.

| Role | Navigasi AS-IMPLEMENTED | Jumlah halaman/layar yang dapat dicapai | Jejak UC TARGET menurut aktor |
| --- | --- | --- | --- |
| Guest | [diagram aktual](guest.mmd) | 5 | UC-02, UC-03, UC-09, UC-10, UC-11, UC-50 |
| Customer | [diagram aktual](customer.mmd) | 16 | UC-01, UC-03, UC-04, UC-05, UC-06, UC-09, UC-10, UC-11, UC-14, UC-15, UC-16, UC-17, UC-18, UC-19, UC-20, UC-23, UC-26, UC-27, UC-39, UC-40, UC-46, UC-47, UC-48, UC-49, UC-50, UC-52, UC-53, UC-54, UC-58, UC-59 |
| Super Admin Owner | [diagram aktual](super-admin-owner.mmd) | 22 | UC-01, UC-03, UC-04, UC-07, UC-08, UC-12, UC-13, UC-19, UC-23, UC-24, UC-25, UC-28, UC-29, UC-30, UC-31, UC-32, UC-33, UC-34, UC-35, UC-36, UC-37, UC-38, UC-41, UC-42, UC-43, UC-44, UC-47, UC-51, UC-55, UC-56, UC-57, UC-58, UC-60, UC-61, UC-62, UC-63, UC-64 |
| Admin Finance | [diagram aktual](admin-finance.mmd) | 3 | UC-01, UC-03, UC-04, UC-23, UC-45, UC-58, UC-62 |
| Admin Kasir | [diagram aktual](admin-kasir.mmd) | 7 | UC-01, UC-03, UC-04, UC-08, UC-19, UC-25, UC-41, UC-43, UC-44, UC-47, UC-51, UC-55, UC-56, UC-57, UC-58, UC-60, UC-61 |
| Admin Gudang | [diagram aktual](admin-gudang.mmd) | 7 | UC-01, UC-03, UC-04, UC-12, UC-13, UC-24, UC-28, UC-29, UC-30, UC-31, UC-32, UC-33, UC-34, UC-35, UC-36, UC-37, UC-38, UC-42, UC-44, UC-58, UC-63, UC-64 |
| Supplier | [diagram aktual](supplier.mmd) | 2 | Pihak eksternal pada TO-BE |

Target menempatkan Supplier dan jasa pengiriman di luar sesi pengguna serta gateway sebagai sistem eksternal. Informasi yang dicatat dikirim melalui alur internal. Kesetaraan target dan transisi akses aktual tercatat di [log keputusan](../../../00-GLOBAL/DECISION-LOG.md).


## Navigasi TARGET per aktor

Node UC memetakan tujuan pengguna. Satu halaman dapat mendukung beberapa UC. Lihat spesifikasi untuk penempatan halaman, dan flow untuk urutan serta kondisi alternatif. Gateway dan Supplier tidak memperoleh menu pengguna.

| Role | Diagram target | UC terkait | Ketentuan |
| --- | --- | --- | --- |
| Guest | [akses dan tujuan per UC](target-guest.mmd) | 6 | Akses sesuai prakondisi skenario |
| Customer | [akses dan tujuan per UC](target-customer.mmd) | 30 | Akses sesuai prakondisi skenario |
| Super Admin Owner | [akses dan tujuan per UC](target-super-admin-owner.mmd) | 37 | Target 1:1 dengan akses Web untuk role yang sama |
| Admin Finance | [akses dan tujuan per UC](target-admin-finance.mmd) | 7 | Target 1:1 dengan akses Web untuk role yang sama |
| Admin Kasir | [akses dan tujuan per UC](target-admin-kasir.mmd) | 17 | Target 1:1 dengan akses Web untuk role yang sama |
| Admin Gudang | [akses dan tujuan per UC](target-admin-gudang.mmd) | 22 | Target 1:1 dengan akses Web untuk role yang sama |
