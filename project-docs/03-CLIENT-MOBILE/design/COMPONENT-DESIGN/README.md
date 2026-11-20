# Komponen Flutter

| Komponen | Kode saat ini | Rancangan penggunaan |
| --- | --- | --- |
| AppScaffold | [Scaffold](../../../../Motifnesia-Client-Mobile/lib/shared/layouts/app_scaffold.dart) | Bottom navigation, drawer, target aktif, entry notifikasi dan logout. |
| ApiPage | [ApiPage](../../../../Motifnesia-Client-Mobile/lib/shared/layouts/api_page.dart) | Progres, refresh, error, dialog konfirmasi, pagination dan retry konsisten. |
| FormView | [FormView](../../../../Motifnesia-Client-Mobile/lib/shared/forms/form_view.dart) | Input, unggah, field error, kondisi busy dan CTA. |
| Katalog | [Product grid](../../../../Motifnesia-Client-Mobile/lib/views/customer/components/product_grid.dart) | Fitur scroll, kartu responsif dan stok ukuran dari API. |
| Chat | [ChatPanel](../../../../Motifnesia-Client-Mobile/lib/shared/widgets/chat_panel.dart) | Thread, kirim/refresh, retry terkontrol dan lifecycle timer; transport target menunggu keputusan. |
| Retur dan notifikasi | [Widgets](../../../../Motifnesia-Client-Mobile/lib/shared/widgets) | Kartu ringkas dengan status dan tindakan yang diotorisasi backend. |
| Pembayaran | [Payment page](../../../../Motifnesia-Client-Mobile/lib/views/customer/pages/checkout/payment_page.dart) | Informasi pembayaran dan tenggat. Untuk gateway, cek ulang status setelah kembali ke aplikasi. |

State khusus widget tetap dekat dengan komponennya. Routing, HTTP, sesi dan parsing kontrak memakai modul yang ada. [Rancangan layar target](../SCREEN-SPECIFICATION/TARGET.md)
