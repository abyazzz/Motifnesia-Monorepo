# Hierarki instruksi

Instruksi terbaru pemilik proyek diterapkan bersama instruksi sistem dan developer yang berlaku. Di repo, agent membaca AGENTS root lalu AGENTS pada aplikasi terkait. Setiap file aplikasi mengarah ke AGENTS global, aturan global, AGENTS scope, RULES, SCOPE, indeks referensi dan desain. Instruksi yang lebih spesifik harus dibaca dalam konteks hierarki yang berlaku.

| Pekerjaan | Urutan penemuan |
| --- | --- |
| Controller Server | [Root](../../AGENTS.md) → [Server](../../Motifnesia-Server/AGENTS.md) → [Scope Server](../01-SERVER/AGENTS.md) |
| Blade Web | [Root](../../AGENTS.md) → [Web](../../Motifnesia-Client-Web/AGENTS.md) → [Scope Web](../02-CLIENT-WEB/AGENTS.md) |
| Widget Flutter | [Root](../../AGENTS.md) → [Mobile](../../Motifnesia-Client-Mobile/AGENTS.md) → [Scope Mobile](../03-CLIENT-MOBILE/AGENTS.md) |

Audit awal menemukan lima AGENTS sebelumnya, satu di root dan empat pada folder dokumentasi. Tidak ditemukan AGENTS di dalam ketiga source aplikasi atau subdirektorinya. Tiga entry aplikasi ditambahkan. Bila instruksi masa depan bertentangan, catat konflik dan ikuti instruksi berprioritas lebih tinggi. [Source of Truth](SOURCE-OF-TRUTH.md)
