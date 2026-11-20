# Rencana implementasi Client Mobile

1. Mulai dari [spesifikasi layar](../design/SCREEN-SPECIFICATION/README.md), [navigation map](../design/NAVIGATION/README.md) dan [screen flow](../design/USER-FLOW/README.md). Selesaikan keputusan cakupan rilis admin bersama tim.
2. Gunakan API yang disepakati. Pertahankan struktur file route dan layar per role. Reuse core API, sesi, dan widget lintas fitur.
3. Uji alur normal, loading/refresh, jaringan gagal, sesi hilang, deep link, upload, perubahan orientasi dan area aman. Gunakan browser untuk viewport mobile dan validasi perangkat sesuai cakupan rilis.
4. Catat keputusan dan hasil pengujian di [traceability](../../00-GLOBAL/TRACEABILITY-MATRIX.md). Cegah status transaksi palsu dengan membaca hasil dari Server.
