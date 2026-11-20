# Komponen Web

| Komponen | Aset atau kode sekarang | Rancangan penggunaan |
| --- | --- | --- |
| Layout dan navbar Customer | [Main layout](../../../../Motifnesia-Client-Web/resources/views/customer/layouts/mainLayout.blade.php) | Entry katalog, cart, favorit, profil. State aktif mengikuti route dan viewer. |
| Kartu produk | [Product card](../../../../Motifnesia-Client-Web/resources/views/customer/components/product-card.blade.php) | Gambar, harga, ketersediaan, detail. Aksi ukuran mengikuti kontrak. |
| Sidebar staf | [Sidebar admin](../../../../Motifnesia-Client-Web/resources/views/admin/components/sidebar.blade.php) | Render menu dari kemampuan. Sembunyikan aksi sesuai Gate dan beri label fokus. |
| Baris pesanan | [Order status row](../../../../Motifnesia-Client-Web/resources/views/admin/components/orderStatusRow.blade.php) | Status bayar dan kirim terpisah. Tindakan untuk role yang berwenang, status dari server. |
| Modal riwayat dan ulasan | [Histori pembelian](../../../../Motifnesia-Client-Web/resources/views/customer/modals/purchaseHistoryModal.blade.php) | Informasi item dan akses ulasan/retur. Tangani fokus, scroll dan validasi. |
| Retur dan bukti | [Retur admin](../../../../Motifnesia-Client-Web/resources/views/admin/pages/returnManagement.blade.php) | Pisahkan tampilan bukti, pemeriksaan, resolusi dan catatan status sesuai role. |
| Notifikasi | [Notification item](../../../../Motifnesia-Client-Web/resources/views/admin/components/notificationItem.blade.php) | Penanda belum dibaca dan tautan terotorisasi. Aksi hapus Customer menunggu kontrak. |

Komponen menggunakan input dan error yang dibuktikan API. Penyesuaian status mengikuti [spesifikasi target](../PAGE-SPECIFICATION/TARGET.md).
