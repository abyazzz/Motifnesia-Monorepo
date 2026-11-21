# Instruksi kerja MotifNesia

MotifNesia adalah monorepo e-commerce batik untuk Toko Viera. `Motifnesia-Server/` menyediakan Laravel API v1, autentikasi, aturan bisnis, dan database. `Motifnesia-Client-Web/` menggunakan Laravel Blade dan Vite. `Motifnesia-Client-Mobile/` menggunakan Flutter dan Dart. Kedua client mengakses Server melalui API.

Sebelum bekerja, baca [instruksi global](project-docs/00-GLOBAL/AGENTS.md), [aturan global](project-docs/00-GLOBAL/GLOBAL-RULES.md), [sumber acuan](project-docs/00-GLOBAL/SOURCE-OF-TRUTH.md), serta instruksi pada aplikasi yang dikerjakan. [Indeks dokumentasi](project-docs/README.md) menghubungkan analisis, desain, dan traceability.

Instruksi pemilik proyek yang terbaru menjadi acuan. Untuk fakta target gunakan sumber yang relevan pada Source of Truth dan catat konflik. Source code membuktikan kondisi implementasi. Bedakan AS-IMPLEMENTED, TARGET, PROPOSED, dan TBD.

Periksa `git status` dan perubahan lokal sebelum mengedit. Lindungi pekerjaan anggota lain, kredensial, token, data pribadi, database, serta konfigurasi sensitif. Perubahan lintas aplikasi dan kontrak API dikoordinasikan dengan pemilik scope yang terdampak. Dokumentasikan keputusan, kebutuhan yang terdampak, hasil pengujian, dan keterbatasannya.

- [Instruksi Server](Motifnesia-Server/AGENTS.md)
- [Instruksi Web](Motifnesia-Client-Web/AGENTS.md)
- [Instruksi Mobile](Motifnesia-Client-Mobile/AGENTS.md)
