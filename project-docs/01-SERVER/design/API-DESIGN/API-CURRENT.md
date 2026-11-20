# Kontrak API v1 AS-IMPLEMENTED

Daftar ini diambil dari `php artisan route:list --json` dengan config/route cache diabaikan, memakai override konfigurasi in-memory. Controller dan Form Request ditelaah statis. `GET` dalam daftar juga mendaftarkan `HEAD`. Semua path di bawah memakai prefiks `/api/v1`. [Manifest Server](../../../../Motifnesia-Server/routes/motifnesia.php) · [Kontrak integrasi](../../../../Motifnesia-Server/API-V1.md)

## Aturan bersama

- Route berotorisasi memerlukan bearer Sanctum dengan kemampuan `motifnesia:v1`. `WebApi` memeriksa role route dan status akun non-admin. Token tidak valid atau absen pada route privat menghasilkan 401. Role atau Gate ditolak dengan 403. Login/registrasi/reset saat sesi aktif menghasilkan 409. Throttling auth menghasilkan 429. Controller tetap bertanggung jawab memeriksa objek milik pengguna dan kemampuan per aksi.
- Query memakai parameter pada aksi. Form JSON dikirim melalui Content-Type JSON dan unggahan menggunakan multipart. Request mengikuti aturan validasi di bawah serta business check dalam aksi. Route model binding/lookup dapat memberi 404. Validasi Laravel atau redirect dengan error menjadi 422. Body aksi sukses biasanya 200, sedangkan status eksplisit dan variasi dinyatakan per endpoint. Branch helper dan error framework perlu uji kontrak.
- Envelope halaman mencakup `page`, `data`, `viewer`. `Page` menormalisasi record, collection dan pagination. Respons redirect diubah middleware selama diproses. Preview broadcast dan draft checkout memakai cache workflow per token dan lock. Bukti privat dan ekspor dikirim sebagai berkas.

### Indeks endpoint v1

| ID | Method dan path relatif | Aksi | Akses awal | UC terkait |
| --- | --- | --- | --- | --- |
| [API-001](#api-001) | `GET /admin/customers` | [CustomerController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php#L20) | Bearer v1 · admin · is-owner | UC-08 |
| [API-002](#api-002) | `DELETE /admin/customers/{id}` | [CustomerController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php#L54) | Bearer v1 · admin · is-owner | UC-08 |
| [API-003](#api-003) | `GET /admin/daftar-produk` | [AdminProductController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L21) | Bearer v1 · admin · is-kasir | Pendukung aktual atau alur lama |
| [API-004](#api-004) | `GET /admin/konten` | [StaticContentController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L24) | Bearer v1 · admin · is-owner | UC-60 |
| [API-005](#api-005) | `POST /admin/konten/slides/create` | [StaticContentController::storeSlide](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L185) | Bearer v1 · admin · is-owner | UC-60 |
| [API-006](#api-006) | `POST /admin/konten/slides/{id}/delete` | [StaticContentController::deleteSlide](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L230) | Bearer v1 · admin · is-owner | UC-60 |
| [API-007](#api-007) | `POST /admin/konten/slides/{id}/update` | [StaticContentController::updateSlide](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L207) | Bearer v1 · admin · is-owner | UC-60 |
| [API-008](#api-008) | `POST /admin/konten/slideshow` | [StaticContentController::updateSlideshow](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L151) | Bearer v1 · admin · is-owner | UC-60 |
| [API-009](#api-009) | `GET /admin/live-chat` | [ChatController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L27) | Bearer v1 · admin · is-kasir | UC-47 |
| [API-010](#api-010) | `GET /admin/live-chat/list` | [ChatController::getChatList](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L126) | Bearer v1 · admin · is-kasir | UC-47 |
| [API-011](#api-011) | `POST /admin/live-chat/send` | [ChatController::sendMessage](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L53) | Bearer v1 · admin · is-kasir | UC-47 |
| [API-012](#api-012) | `GET /admin/live-chat/{chatId}/messages` | [ChatController::getNewMessages](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L92) | Bearer v1 · admin · is-kasir | UC-47 |
| [API-013](#api-013) | `GET /admin/membership-broadcast` | [MembershipController::broadcastForm](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L192) | Bearer v1 · admin · is-owner | UC-61 |
| [API-014](#api-014) | `POST /admin/membership-broadcast` | [MembershipController::broadcast](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L211) | Bearer v1 · admin · is-owner | UC-61 |
| [API-015](#api-015) | `GET /admin/membership-rewards` | [MembershipController::rewards](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L126) | Bearer v1 · admin · is-owner | UC-56 |
| [API-016](#api-016) | `POST /admin/membership-rewards` | [MembershipController::storeReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L147) | Bearer v1 · admin · is-owner | UC-56 |
| [API-017](#api-017) | `GET /admin/membership-rewards/create` | [MembershipController::createReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L138) | Bearer v1 · admin · is-owner | UC-56 |
| [API-018](#api-018) | `PUT /admin/membership-rewards/{id}` | [MembershipController::updateReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L170) | Bearer v1 · admin · is-owner | UC-56 |
| [API-019](#api-019) | `DELETE /admin/membership-rewards/{id}` | [MembershipController::destroyReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L181) | Bearer v1 · admin · is-owner | UC-56 |
| [API-020](#api-020) | `GET /admin/membership-rewards/{id}/edit` | [MembershipController::editReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L159) | Bearer v1 · admin · is-owner | UC-56 |
| [API-021](#api-021) | `GET /admin/memberships` | [MembershipController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L31) | Bearer v1 · admin · is-owner | UC-55, UC-57 |
| [API-022](#api-022) | `POST /admin/memberships/{id}/points` | [MembershipController::adjustPoints](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L78) | Bearer v1 · admin · is-owner | UC-57 |
| [API-023](#api-023) | `POST /admin/memberships/{id}/status` | [MembershipController::updateMemberStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L44) | Bearer v1 · admin · is-owner | UC-55 |
| [API-024](#api-024) | `GET /admin/notifications` | [NotificationController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L16) | Bearer v1 · admin | UC-58 |
| [API-025](#api-025) | `POST /admin/notifications/clear-read` | [NotificationController::clearRead](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L109) | Bearer v1 · admin | Pendukung aktual atau alur lama |
| [API-026](#api-026) | `POST /admin/notifications/mark-all-read` | [NotificationController::markAllRead](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L84) | Bearer v1 · admin | Pendukung aktual atau alur lama |
| [API-027](#api-027) | `DELETE /admin/notifications/{id}` | [NotificationController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L95) | Bearer v1 · admin | Pendukung aktual atau alur lama |
| [API-028](#api-028) | `POST /admin/notifications/{id}/toggle-read` | [NotificationController::toggleRead](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L69) | Bearer v1 · admin | Pendukung aktual atau alur lama |
| [API-029](#api-029) | `GET /admin/order-status` | [OrderStatusController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L21) | Bearer v1 · admin | UC-19, UC-23, UC-24, UC-25 |
| [API-030](#api-030) | `POST /admin/order-status/{id}/payment` | [OrderStatusController::updatePaymentStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L85) | Bearer v1 · admin · is-finance | UC-23 |
| [API-031](#api-031) | `POST /admin/order-status/{id}/update` | [OrderStatusController::updateStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L47) | Bearer v1 · admin · is-kasir | UC-19, UC-24, UC-25 |
| [API-032](#api-032) | `GET /admin/order-status/{order}/payment-proof` | [ProofController::payment](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L14) | Bearer v1 · admin · is-finance | UC-23 |
| [API-033](#api-033) | `GET /admin/product-management` | [AdminProductController::manage](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L113) | Bearer v1 · admin · is-kasir | UC-13 |
| [API-034](#api-034) | `GET /admin/product-reviews` | [ProductReviewController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L19) | Bearer v1 · admin | UC-51 |
| [API-035](#api-035) | `GET /admin/product-reviews/{id}` | [ProductReviewController::show](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L75) | Bearer v1 · admin | UC-51 |
| [API-036](#api-036) | `POST /admin/product-reviews/{id}/moderate` | [ProductReviewController::moderate](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L111) | Bearer v1 · admin | UC-51 |
| [API-037](#api-037) | `GET&#124;POST /admin/products/create` | [AdminProductController::createOrStore](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L30) | Bearer v1 · admin · is-owner | UC-12 |
| [API-038](#api-038) | `POST /admin/products/{id}/delete` | [AdminProductController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L193) | Bearer v1 · admin · is-owner | UC-13 |
| [API-039](#api-039) | `POST /admin/products/{id}/update` | [AdminProductController::update](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L129) | Bearer v1 · admin · is-owner | UC-13 |
| [API-040](#api-040) | `GET /admin/returns` | [ReturnController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L25) | Bearer v1 · admin · is-kasir | UC-41 |
| [API-041](#api-041) | `DELETE /admin/returns/{id}` | [ReturnController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L111) | Bearer v1 · admin · is-kasir | Pendukung aktual atau alur lama |
| [API-042](#api-042) | `POST /admin/returns/{id}/update-status` | [ReturnController::updateStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L58) | Bearer v1 · admin · is-kasir | UC-41, UC-42, UC-43, UC-44, UC-45 |
| [API-043](#api-043) | `GET /admin/returns/{return}/proof/{kind}` | [ProofController::adminReturn](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L28) | Bearer v1 · admin · is-kasir | UC-41 |
| [API-044](#api-044) | `GET /admin/sales-report` | [ReportController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L22) | Bearer v1 · admin · is-finance | UC-62 |
| [API-045](#api-045) | `GET /admin/sales-report/export` | [ReportController::export](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L160) | Bearer v1 · admin · is-finance | UC-62 |
| [API-046](#api-046) | `GET /admin/stock-opname` | [StockOpnameController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php#L15) | Bearer v1 · admin · is-gudang | UC-36, UC-37, UC-63 |
| [API-047](#api-047) | `POST /admin/stock-opname/adjust` | [StockOpnameController::adjust](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php#L27) | Bearer v1 · admin · is-gudang | UC-36, UC-37 |
| [API-048](#api-048) | `GET /admin/stock-procurements` | [StockProcurementController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L17) | Bearer v1 · admin · is-gudang | UC-29, UC-31, UC-64 |
| [API-049](#api-049) | `POST /admin/stock-procurements` | [StockProcurementController::store](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L63) | Bearer v1 · admin · is-gudang | UC-29 |
| [API-050](#api-050) | `GET /admin/stock-procurements/create` | [StockProcurementController::create](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L45) | Bearer v1 · admin · is-gudang | UC-29 |
| [API-051](#api-051) | `GET /admin/stock-procurements/{stockProcurement}` | [StockProcurementController::show](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L104) | Bearer v1 · admin · is-gudang | UC-29, UC-31, UC-32, UC-33, UC-64 |
| [API-052](#api-052) | `POST /admin/stock-procurements/{stockProcurement}/apply-stock` | [StockProcurementController::applyStock](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L135) | Bearer v1 · admin · is-gudang | UC-31, UC-33, UC-35 |
| [API-053](#api-053) | `POST /admin/stock-procurements/{stockProcurement}/confirm-arrived` | [StockProcurementController::confirmArrived](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L118) | Bearer v1 · admin · is-gudang | UC-31, UC-33 |
| [API-054](#api-054) | `GET /admin/suppliers` | [SupplierController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L18) | Bearer v1 · admin · is-owner | UC-28 |
| [API-055](#api-055) | `POST /admin/suppliers` | [SupplierController::store](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L34) | Bearer v1 · admin · is-owner | UC-28 |
| [API-056](#api-056) | `PUT /admin/suppliers/{supplier}` | [SupplierController::update](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L52) | Bearer v1 · admin · is-owner | UC-28 |
| [API-057](#api-057) | `DELETE /admin/suppliers/{supplier}` | [SupplierController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L69) | Bearer v1 · admin · is-owner | UC-28 |
| [API-058](#api-058) | `GET /admin/warehouse` | [WarehouseController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/WarehouseController.php#L13) | Bearer v1 · admin · is-gudang | UC-34, UC-35, UC-38, UC-63 |
| [API-059](#api-059) | `GET /cart` | [ShoppingCardController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L20) | Bearer v1 · customer | UC-14 |
| [API-060](#api-060) | `POST /cart/add` | [ShoppingCardController::add](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L45) | Bearer v1 · customer | UC-14 |
| [API-061](#api-061) | `POST /cart/checkout` | [ShoppingCardController::checkout](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L201) | Bearer v1 · customer | UC-16 |
| [API-062](#api-062) | `POST /cart/update` | [ShoppingCardController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L99) | Bearer v1 · customer | UC-14 |
| [API-063](#api-063) | `DELETE /cart/{id}` | [ShoppingCardController::delete](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L169) | Bearer v1 · customer | UC-14 |
| [API-064](#api-064) | `GET /chat` | [ChatController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L18) | Bearer v1 · customer | UC-47 |
| [API-065](#api-065) | `POST /chat/get-or-create` | [ChatController::getOrCreateChat](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L37) | Bearer v1 · customer | UC-47 |
| [API-066](#api-066) | `POST /chat/product/{productId}/ask` | [ChatController::askProduct](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L103) | Bearer v1 · customer | UC-47 |
| [API-067](#api-067) | `POST /chat/send` | [ChatController::sendMessage](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L65) | Bearer v1 · customer | UC-47 |
| [API-068](#api-068) | `POST /chat/{chatId}/close` | [ChatController::closeChat](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L201) | Bearer v1 · customer | UC-47 |
| [API-069](#api-069) | `GET /chat/{chatId}/messages` | [ChatController::getNewMessages](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L160) | Bearer v1 · customer | UC-47 |
| [API-070](#api-070) | `GET /checkout` | [CheckOutController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L23) | Bearer v1 · customer | UC-16 |
| [API-071](#api-071) | `POST /checkout/store` | [CheckOutController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L106) | Bearer v1 · customer | UC-16 |
| [API-072](#api-072) | `GET /favorites` | [ProductFavoriteController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L18) | Bearer v1 · customer | UC-48 |
| [API-073](#api-073) | `POST /favorites/store` | [ProductFavoriteController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L36) | Bearer v1 · customer | UC-48 |
| [API-074](#api-074) | `DELETE /favorites/{id}` | [ProductFavoriteController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L76) | Bearer v1 · customer | UC-48 |
| [API-075](#api-075) | `POST /favorites/{id}/add-to-cart` | [ProductFavoriteController::addToCart](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L98) | Bearer v1 · customer | UC-48 |
| [API-076](#api-076) | `POST /forgot` | [UserController::doForgot](../../../../Motifnesia-Server/app/Http/Controllers/Auth/UserController.php#L45) | Guest · rate limiter, sesi aktif ditolak | UC-03 |
| [API-077](#api-077) | `GET /homePage` | [CustomerProductController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L18) | Publik · bearer opsional | UC-09, UC-10 |
| [API-078](#api-078) | `POST /login` | [WebAuthController::login](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L15) | Guest · rate limiter, sesi aktif ditolak | UC-01 |
| [API-079](#api-079) | `POST /logout` | [WebAuthController::logout](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L55) | Publik · bearer opsional | UC-04 |
| [API-080](#api-080) | `GET /membership` | [MembershipController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L16) | Bearer v1 · customer | UC-52, UC-53, UC-54 |
| [API-081](#api-081) | `GET /membership/history` | [MembershipController::history](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L122) | Bearer v1 · customer | UC-52, UC-57 |
| [API-082](#api-082) | `POST /membership/redeem/{reward}` | [MembershipController::redeem](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L85) | Bearer v1 · customer | UC-54 |
| [API-083](#api-083) | `POST /membership/register` | [MembershipController::register](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L44) | Bearer v1 · customer | UC-53 |
| [API-084](#api-084) | `GET /membership/vouchers` | [MembershipController::myVouchers](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L139) | Bearer v1 · customer | UC-52, UC-54 |
| [API-085](#api-085) | `GET /notifications` | [NotificationController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L16) | Bearer v1 · customer | UC-58, UC-59 |
| [API-086](#api-086) | `POST /notifications/mark-all-read` | [NotificationController::markAllAsRead](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L49) | Bearer v1 · customer | UC-59 |
| [API-087](#api-087) | `POST /notifications/{id}/read` | [NotificationController::markAsRead](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L33) | Bearer v1 · customer | UC-59 |
| [API-088](#api-088) | `POST /order-reviews` | [OrderReviewController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L18) | Bearer v1 · customer | UC-49 |
| [API-089](#api-089) | `GET /order-reviews/{orderItemId}` | [OrderReviewController::show](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L73) | Bearer v1 · customer | UC-49 |
| [API-090](#api-090) | `POST /orders/{order}/confirm-arrived` | [PurchaseHistoryController::confirmArrived](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PurchaseHistoryController.php#L98) | Bearer v1 · customer | UC-27 |
| [API-091](#api-091) | `GET /payment` | [PaymentController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L21) | Bearer v1 · customer | UC-16, UC-20, UC-23 |
| [API-092](#api-092) | `POST /payment/store` | [PaymentController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L45) | Bearer v1 · customer | UC-16, UC-20 |
| [API-093](#api-093) | `POST /product-reviews` | [ReviewController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L20) | Bearer v1 · customer | Pendukung aktual atau alur lama |
| [API-094](#api-094) | `PUT /product-reviews/{id}` | [ReviewController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L41) | Bearer v1 · customer | Pendukung aktual atau alur lama |
| [API-095](#api-095) | `DELETE /product-reviews/{id}` | [ReviewController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L63) | Bearer v1 · customer | Pendukung aktual atau alur lama |
| [API-096](#api-096) | `GET /products/{id}` | [CustomerProductController::show](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L80) | Publik · bearer opsional | UC-11, UC-50 |
| [API-097](#api-097) | `GET /products/{id}/reviews` | [ReviewController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L13) | Bearer v1 · customer | UC-50 |
| [API-098](#api-098) | `GET /profile` | [UserProfileController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L17) | Bearer v1 · customer | UC-05, UC-15, UC-17, UC-18, UC-26, UC-27 |
| [API-099](#api-099) | `POST /profile/addresses` | [UserAddressController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L16) | Bearer v1 · customer | UC-15 |
| [API-100](#api-100) | `DELETE /profile/addresses/{id}` | [UserAddressController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L142) | Bearer v1 · customer | UC-15 |
| [API-101](#api-101) | `POST /profile/addresses/{id}/set-primary` | [UserAddressController::setPrimary](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L114) | Bearer v1 · customer | UC-15 |
| [API-102](#api-102) | `POST /profile/addresses/{id}/update` | [UserAddressController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L62) | Bearer v1 · customer | UC-15 |
| [API-103](#api-103) | `GET /profile/edit` | [UserProfileController::edit](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L44) | Bearer v1 · customer | UC-06 |
| [API-104](#api-104) | `POST /profile/edit` | [UserProfileController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L84) | Bearer v1 · customer | UC-06 |
| [API-105](#api-105) | `POST /register` | [UserController::doRegister](../../../../Motifnesia-Server/app/Http/Controllers/Auth/UserController.php#L14) | Guest · rate limiter, sesi aktif ditolak | UC-02 |
| [API-106](#api-106) | `GET /returns` | [ReturnController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L109) | Bearer v1 · customer | UC-40, UC-46 |
| [API-107](#api-107) | `POST /returns` | [ReturnController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L52) | Bearer v1 · customer | UC-39 |
| [API-108](#api-108) | `GET /returns/create/{orderItemId}` | [ReturnController::create](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L20) | Bearer v1 · customer | UC-39 |
| [API-109](#api-109) | `PATCH /returns/{id}/cancel` | [ReturnController::cancel](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L124) | Bearer v1 · customer | Pendukung aktual atau alur lama |
| [API-110](#api-110) | `POST /returns/{id}/courier-proof` | [ReturnController::submitCourierProof](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L146) | Bearer v1 · customer | UC-42 |
| [API-111](#api-111) | `GET /returns/{return}/proof/{kind}` | [ProofController::customerReturn](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L21) | Bearer v1 · customer | UC-40 |
| [API-112](#api-112) | `GET /search/live` | [CustomerProductController::liveSearch](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L135) | Publik · bearer opsional | UC-10 |
| [API-113](#api-113) | `GET /supplier/procurements` | [ProcurementController::index](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L13) | Bearer v1 · supplier | UC-32 |
| [API-114](#api-114) | `GET /supplier/procurements/{procurement}` | [ProcurementController::show](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L29) | Bearer v1 · supplier | UC-32 |
| [API-115](#api-115) | `POST /supplier/procurements/{procurement}/status` | [ProcurementController::updateStatus](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L43) | Bearer v1 · supplier | UC-32 |
| [API-116](#api-116) | `GET /transaction/success/{orderId}` | [PaymentController::success](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L100) | Bearer v1 · customer | UC-18, UC-23, UC-26 |
| [API-117](#api-117) | `GET /viewer` | [WebAuthController::viewer](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L49) | Publik · bearer opsional | UC-01 |

### API-001

`GET /api/v1/admin/customers`

- Aksi dan bukti. [CustomerController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php#L20)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-08 · KF-12.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.customerList`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-002

`DELETE /api/v1/admin/customers/{id}`

- Aksi dan bukti. [CustomerController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php#L54)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-08 · KF-12.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-003

`GET /api/v1/admin/daftar-produk`

- Aksi dan bukti. [AdminProductController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L21)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-004

`GET /api/v1/admin/konten`

- Aksi dan bukti. [StaticContentController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L24)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-60 · KF-18.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.kontenStatis`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-005

`POST /api/v1/admin/konten/slides/create`

- Aksi dan bukti. [StaticContentController::storeSlide](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L185)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-60 · KF-18.
- Respons. Key JSON terlihat pada cabang respons. `success, slide`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `file('gambar')`.

```php
['judul' => 'nullable|string|max:255', 'gambar' => 'required|image|max:10240']
```

### API-006

`POST /api/v1/admin/konten/slides/{id}/delete`

- Aksi dan bukti. [StaticContentController::deleteSlide](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L230)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-60 · KF-18.
- Respons. Key JSON terlihat pada cabang respons. `success`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-007

`POST /api/v1/admin/konten/slides/{id}/update`

- Aksi dan bukti. [StaticContentController::updateSlide](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L207)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-60 · KF-18.
- Respons. Key JSON terlihat pada cabang respons. `success, slide`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

Pembacaan input di controller. `hasFile('gambar')`, `file('gambar')`.

```php
['judul' => 'nullable|string|max:255', 'gambar' => 'nullable|image|max:10240']
```

### API-008

`POST /api/v1/admin/konten/slideshow`

- Aksi dan bukti. [StaticContentController::updateSlideshow](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L151)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-60 · KF-18.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['banner1_name' => 'nullable|string|max:255', 'banner1_gambar' => 'nullable|image|max:10240', 'banner2_name' => 'nullable|string|max:255', 'banner2_gambar' => 'nullable|image|max:10240', 'banner3_name' => 'nullable|string|max:255', 'banner3_gambar' => 'nullable|image|max:10240']
```

### API-009

`GET /api/v1/admin/live-chat`

- Aksi dan bukti. [ChatController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L27)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.liveChatSupport`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `query('chat_id')`.

### API-010

`GET /api/v1/admin/live-chat/list`

- Aksi dan bukti. [ChatController::getChatList](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L126)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Key JSON terlihat pada cabang respons. `success, chats, id, user_name, last_message, unread_count, last_message_at`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-011

`POST /api/v1/admin/live-chat/send`

- Aksi dan bukti. [ChatController::sendMessage](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L53)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Key JSON terlihat pada cabang respons. `success, message, id, created_at, sender_name, is_admin`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['chat_id' => 'required|exists:chats,id', 'message' => 'required|string|max:1000']
```

### API-012

`GET /api/v1/admin/live-chat/{chatId}/messages`

- Aksi dan bukti. [ChatController::getNewMessages](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L92)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Key JSON terlihat pada cabang respons. `success, messages, id, message, created_at, sender_name, is_admin`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `chatId`.

Pembacaan input di controller. `query('last_message_id')`.

### API-013

`GET /api/v1/admin/membership-broadcast`

- Aksi dan bukti. [MembershipController::broadcastForm](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L192)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-61 · KF-18.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.memberships.broadcast`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-014

`POST /api/v1/admin/membership-broadcast`

- Aksi dan bukti. [MembershipController::broadcast](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L211)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-61 · KF-18.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['title' => ['required', 'string', 'max:255'], 'message' => ['required', 'string', 'max:2000'], 'caption' => ['nullable', 'string', 'max:1000']]
```

### API-015

`GET /api/v1/admin/membership-rewards`

- Aksi dan bukti. [MembershipController::rewards](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L126)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-56 · KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.memberships.rewards`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-016

`POST /api/v1/admin/membership-rewards`

- Aksi dan bukti. [MembershipController::storeReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L147)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-56 · KF-16.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-017

`GET /api/v1/admin/membership-rewards/create`

- Aksi dan bukti. [MembershipController::createReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L138)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-56 · KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.memberships.rewardForm`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-018

`PUT /api/v1/admin/membership-rewards/{id}`

- Aksi dan bukti. [MembershipController::updateReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L170)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-56 · KF-16.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-019

`DELETE /api/v1/admin/membership-rewards/{id}`

- Aksi dan bukti. [MembershipController::destroyReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L181)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-56 · KF-16.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-020

`GET /api/v1/admin/membership-rewards/{id}/edit`

- Aksi dan bukti. [MembershipController::editReward](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L159)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-56 · KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.memberships.rewardForm`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-021

`GET /api/v1/admin/memberships`

- Aksi dan bukti. [MembershipController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L31)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-55, UC-57 · KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.memberships.index`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-022

`POST /api/v1/admin/memberships/{id}/points`

- Aksi dan bukti. [MembershipController::adjustPoints](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L78)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-57 · KF-16.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

```php
['points' => ['required', 'integer', 'not_in:0'], 'description' => ['nullable', 'string', 'max:1000']]
```

### API-023

`POST /api/v1/admin/memberships/{id}/status`

- Aksi dan bukti. [MembershipController::updateMemberStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L44)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-55 · KF-16.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

```php
['membership_status' => ['required', \Illuminate\Validation\Rule::in(['active', 'inactive'])]]
```

### API-024

`GET /api/v1/admin/notifications`

- Aksi dan bukti. [NotificationController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L16)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-58 · KF-17.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.notifications`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `get('filter')`, `get('search')`.

### API-025

`POST /api/v1/admin/notifications/clear-read`

- Aksi dan bukti. [NotificationController::clearRead](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L109)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-026

`POST /api/v1/admin/notifications/mark-all-read`

- Aksi dan bukti. [NotificationController::markAllRead](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L84)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-027

`DELETE /api/v1/admin/notifications/{id}`

- Aksi dan bukti. [NotificationController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L95)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-028

`POST /api/v1/admin/notifications/{id}/toggle-read`

- Aksi dan bukti. [NotificationController::toggleRead](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L69)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Key JSON terlihat pada cabang respons. `success, is_read`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-029

`GET /api/v1/admin/order-status`

- Aksi dan bukti. [OrderStatusController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L21)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-19, UC-23, UC-24, UC-25 · KF-03, KF-04, KF-05, KF-06, KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.orderStatus`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-030

`POST /api/v1/admin/order-status/{id}/payment`

- Aksi dan bukti. [OrderStatusController::updatePaymentStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L85)
- Akses. Bearer v1 · admin · is-finance. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-23 · KF-05.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

```php
['payment_status' => 'required|in:waiting_verification,verified,rejected', 'payment_note' => 'nullable|string|max:500']
```

### API-031

`POST /api/v1/admin/order-status/{id}/update`

- Aksi dan bukti. [OrderStatusController::updateStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L47)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-19, UC-24, UC-25 · KF-03, KF-04, KF-06, KF-16.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

```php
['delivery_status_id' => 'required|exists:delivery_status,id']
```

### API-032

`GET /api/v1/admin/order-status/{order}/payment-proof`

- Aksi dan bukti. [ProofController::payment](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L14)
- Akses. Bearer v1 · admin · is-finance. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-23 · KF-05.
- Respons. Berkas bukti privat dengan jenis gambar dibatasi dan kontrol akses.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `order`.

### API-033

`GET /api/v1/admin/product-management`

- Aksi dan bukti. [AdminProductController::manage](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L113)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-13 · KF-01.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.productManagement`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-034

`GET /api/v1/admin/product-reviews`

- Aksi dan bukti. [ProductReviewController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L19)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-51 · KF-15.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.reviewModeration`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `get('filter')`.

### API-035

`GET /api/v1/admin/product-reviews/{id}`

- Aksi dan bukti. [ProductReviewController::show](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L75)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-51 · KF-15.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.productReviewDetail`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-036

`POST /api/v1/admin/product-reviews/{id}/moderate`

- Aksi dan bukti. [ProductReviewController::moderate](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L111)
- Akses. Bearer v1 · admin. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-51 · KF-15.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

```php
['moderation_status' => ['required', \Illuminate\Validation\Rule::in(['approved', 'hidden', 'rejected'])], 'moderation_note' => ['nullable', 'string', 'max:1000']]
```

### API-037

`GET|POST /api/v1/admin/products/create`

- Aksi dan bukti. [AdminProductController::createOrStore](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L30)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-12 · KF-01.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.addProduct`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `hasFile('image')`, `file('image')`, `boolean('notify_members')`.

```php
['name' => 'required|string|max:255', 'description' => 'required|string', 'price' => 'required|numeric|min:0', 'category' => 'required|string', 'stock' => 'required|integer|min:0', 'size_stocks' => 'nullable|array', 'size_stocks.*' => 'nullable|integer|min:0', 'material' => 'required|string', 'process' => 'required|string', 'sku' => 'required|string|unique:produk,sku', 'tags' => 'required|string', 'ukuran' => 'required|string', 'jenis_lengan' => 'required|string', 'diskon_persen' => 'required|integer|min:0|max:100', 'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048', 'notify_members' => 'nullable|boolean', 'filosofi_motif' => 'nullable|string']
```

### API-038

`POST /api/v1/admin/products/{id}/delete`

- Aksi dan bukti. [AdminProductController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L193)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-13 · KF-01.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-039

`POST /api/v1/admin/products/{id}/update`

- Aksi dan bukti. [AdminProductController::update](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L129)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-13 · KF-01.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

Pembacaan input di controller. `hasFile('image')`, `file('image')`, `boolean('notify_members')`.

Form Request. [UpdateProductRequest](../../../../Motifnesia-Server/app/Http/Requests/UpdateProductRequest.php).

### API-040

`GET /api/v1/admin/returns`

- Aksi dan bukti. [ReturnController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L25)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-41 · KF-08.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.returnManagement`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `get('status')`.

### API-041

`DELETE /api/v1/admin/returns/{id}`

- Aksi dan bukti. [ReturnController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L111)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-042

`POST /api/v1/admin/returns/{id}/update-status`

- Aksi dan bukti. [ReturnController::updateStatus](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L58)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-41, UC-42, UC-43, UC-44, UC-45 · KF-03, KF-08, KF-16.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

```php
['status' => 'required|in:Pending,Disetujui,Ditolak,Diproses,Selesai', 'admin_note' => 'nullable|string|max:500']
```

### API-043

`GET /api/v1/admin/returns/{return}/proof/{kind}`

- Aksi dan bukti. [ProofController::adminReturn](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L28)
- Akses. Bearer v1 · admin · is-kasir. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-41 · KF-08.
- Respons. Berkas bukti privat dengan jenis gambar dibatasi dan kontrol akses.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `return`, `kind`.

### API-044

`GET /api/v1/admin/sales-report`

- Aksi dan bukti. [ReportController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L22)
- Akses. Bearer v1 · admin · is-finance. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-62 · KF-07.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.salesReport`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `get('period')`.

### API-045

`GET /api/v1/admin/sales-report/export`

- Aksi dan bukti. [ReportController::export](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L160)
- Akses. Bearer v1 · admin · is-finance. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-62 · KF-07.
- Respons. Streaming CSV dan header unduhan.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `get('period')`.

### API-046

`GET /api/v1/admin/stock-opname`

- Aksi dan bukti. [StockOpnameController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php#L15)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-36, UC-37, UC-63 · KF-03.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.stockOpname.index`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-047

`POST /api/v1/admin/stock-opname/adjust`

- Aksi dan bukti. [StockOpnameController::adjust](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php#L27)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-36, UC-37 · KF-03.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['produk_id' => 'required|exists:produk,id', 'ukuran' => 'required|in:S,M,L,XL', 'note' => 'nullable|string|max:1000']
```

### API-048

`GET /api/v1/admin/stock-procurements`

- Aksi dan bukti. [StockProcurementController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L17)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-29, UC-31, UC-64 · KF-09.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.stockProcurements.index`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `get('status')`.

### API-049

`POST /api/v1/admin/stock-procurements`

- Aksi dan bukti. [StockProcurementController::store](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L63)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-29 · KF-09.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['supplier_id' => 'required|exists:suppliers,id', 'note' => 'nullable|string|max:1000', 'items' => 'required|array', 'items.*.qty_s' => 'nullable|integer|min:0', 'items.*.qty_m' => 'nullable|integer|min:0', 'items.*.qty_l' => 'nullable|integer|min:0', 'items.*.qty_xl' => 'nullable|integer|min:0']
```

### API-050

`GET /api/v1/admin/stock-procurements/create`

- Aksi dan bukti. [StockProcurementController::create](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L45)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-29 · KF-09.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.stockProcurements.create`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-051

`GET /api/v1/admin/stock-procurements/{stockProcurement}`

- Aksi dan bukti. [StockProcurementController::show](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L104)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-29, UC-31, UC-32, UC-33, UC-64 · KF-03, KF-09.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.stockProcurements.show`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `stockProcurement`.

### API-052

`POST /api/v1/admin/stock-procurements/{stockProcurement}/apply-stock`

- Aksi dan bukti. [StockProcurementController::applyStock](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L135)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-31, UC-33, UC-35 · KF-03, KF-09.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `stockProcurement`.

### API-053

`POST /api/v1/admin/stock-procurements/{stockProcurement}/confirm-arrived`

- Aksi dan bukti. [StockProcurementController::confirmArrived](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L118)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-31, UC-33 · KF-03, KF-09.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `stockProcurement`.

### API-054

`GET /api/v1/admin/suppliers`

- Aksi dan bukti. [SupplierController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L18)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-28 · KF-09.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.suppliers.index`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-055

`POST /api/v1/admin/suppliers`

- Aksi dan bukti. [SupplierController::store](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L34)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-28 · KF-09.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-056

`PUT /api/v1/admin/suppliers/{supplier}`

- Aksi dan bukti. [SupplierController::update](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L52)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-28 · KF-09.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `supplier`.

### API-057

`DELETE /api/v1/admin/suppliers/{supplier}`

- Aksi dan bukti. [SupplierController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L69)
- Akses. Bearer v1 · admin · is-owner. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-28 · KF-09.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `supplier`.

### API-058

`GET /api/v1/admin/warehouse`

- Aksi dan bukti. [WarehouseController::index](../../../../Motifnesia-Server/app/Http/Controllers/Admin/WarehouseController.php#L13)
- Akses. Bearer v1 · admin · is-gudang. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-34, UC-35, UC-38, UC-63 · KF-03.
- Respons. Envelope `page`, `data`, `viewer` untuk `admin.pages.warehouse.index`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-059

`GET /api/v1/cart`

- Aksi dan bukti. [ShoppingCardController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L20)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-14 · KF-04.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.shoppingCard`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `items`, `total`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-060

`POST /api/v1/cart/add`

- Aksi dan bukti. [ShoppingCardController::add](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L45)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-14 · KF-04.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Form Request. [AddToCartRequest](../../../../Motifnesia-Server/app/Http/Requests/AddToCartRequest.php).

### API-061

`POST /api/v1/cart/checkout`

- Aksi dan bukti. [ShoppingCardController::checkout](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L201)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-16 · KF-03, KF-04, KF-05.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `input('selected_items')`.

### API-062

`POST /api/v1/cart/update`

- Aksi dan bukti. [ShoppingCardController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L99)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-14 · KF-04.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 401, 404, 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `input('cart_id')`, `input('qty')`.

### API-063

`DELETE /api/v1/cart/{id}`

- Aksi dan bukti. [ShoppingCardController::delete](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L169)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-14 · KF-04.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 401, 404 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-064

`GET /api/v1/chat`

- Aksi dan bukti. [ChatController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L18)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.liveChat`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-065

`POST /api/v1/chat/get-or-create`

- Aksi dan bukti. [ChatController::getOrCreateChat](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L37)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Key JSON terlihat pada cabang respons. `success, chat_id`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-066

`POST /api/v1/chat/product/{productId}/ask`

- Aksi dan bukti. [ChatController::askProduct](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L103)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `productId`.

Pembacaan input di controller. `input('question')`.

```php
['question' => 'nullable|string|max:600']
```

### API-067

`POST /api/v1/chat/send`

- Aksi dan bukti. [ChatController::sendMessage](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L65)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Key JSON terlihat pada cabang respons. `error` · `success, message, id, created_at, sender_name, is_admin`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['chat_id' => 'required|exists:chats,id', 'message' => 'required|string|max:1000']
```

### API-068

`POST /api/v1/chat/{chatId}/close`

- Aksi dan bukti. [ChatController::closeChat](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L201)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Key JSON terlihat pada cabang respons. `error` · `success`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `chatId`.

### API-069

`GET /api/v1/chat/{chatId}/messages`

- Aksi dan bukti. [ChatController::getNewMessages](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L160)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-47 · KF-13.
- Respons. Key JSON terlihat pada cabang respons. `error` · `success, messages, id, message, created_at, sender_name, is_admin`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `chatId`.

Pembacaan input di controller. `query('last_message_id')`.

### API-070

`GET /api/v1/checkout`

- Aksi dan bukti. [CheckOutController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L23)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-16 · KF-03, KF-04, KF-05.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.checkOut`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `products`, `subtotalProduk`, `defaultAddress`, `metodePengiriman`, `metodePembayaran`, `memberVouchers`, `tierDiscount`, `tierDiscountPercent`, `user`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-071

`POST /api/v1/checkout/store`

- Aksi dan bukti. [CheckOutController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L106)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-16 · KF-03, KF-04, KF-05.
- Respons. Key JSON terlihat pada cabang respons. `success, message` · `success, message, redirect_url`.
- Status. 200 umum; 400, 404, 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Form Request. [CheckoutRequest](../../../../Motifnesia-Server/app/Http/Requests/CheckoutRequest.php).

### API-072

`GET /api/v1/favorites`

- Aksi dan bukti. [ProductFavoriteController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L18)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-48 · KF-14.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.productFavorite`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `favorites`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-073

`POST /api/v1/favorites/store`

- Aksi dan bukti. [ProductFavoriteController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L36)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-48 · KF-14.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 400, 401 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['produk_id' => 'required|exists:produk,id']
```

### API-074

`DELETE /api/v1/favorites/{id}`

- Aksi dan bukti. [ProductFavoriteController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L76)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-48 · KF-14.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-075

`POST /api/v1/favorites/{id}/add-to-cart`

- Aksi dan bukti. [ProductFavoriteController::addToCart](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L98)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-48 · KF-14.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-076

`POST /api/v1/forgot`

- Aksi dan bukti. [UserController::doForgot](../../../../Motifnesia-Server/app/Http/Controllers/Auth/UserController.php#L45)
- Akses. Guest · rate limiter, sesi aktif ditolak. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-03 · KF-10.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['username' => 'required', 'secret_question' => 'required', 'secret_answer' => 'required', 'new_password' => 'required|min:6', 'new_password_confirmation' => 'required|same:new_password']
```

### API-077

`GET /api/v1/homePage`

- Aksi dan bukti. [CustomerProductController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L18)
- Akses. Publik · bearer opsional. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-09, UC-10 · KF-01, KF-02.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.homePage`. Key data halaman yang terlihat. `products`, `slides`, `filterOptions`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `input('search')`, `input('gender')`, `input('jenis_lengan')`, `input('price_range')`.

### API-078

`POST /api/v1/login`

- Aksi dan bukti. [WebAuthController::login](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L15)
- Akses. Guest · rate limiter, sesi aktif ditolak. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-01 · KF-10.
- Respons. Key JSON terlihat pada cabang respons. `message` · `token, message, viewer`.
- Status. 200 umum; 403, 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['username' => 'required|string|max:255', 'password' => 'required|string|max:1024']
```

### API-079

`POST /api/v1/logout`

- Aksi dan bukti. [WebAuthController::logout](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L55)
- Akses. Publik · bearer opsional. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-04 · KF-10.
- Respons. Key JSON terlihat pada cabang respons. `success`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-080

`GET /api/v1/membership`

- Aksi dan bukti. [MembershipController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L16)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-52, UC-53, UC-54 · KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.membership`. Key data halaman yang terlihat. `user`, `rewards`, `pointTransactions`, `vouchers`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-081

`GET /api/v1/membership/history`

- Aksi dan bukti. [MembershipController::history](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L122)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-52, UC-57 · KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.membershipHistory`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `user`, `pointTransactions`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-082

`POST /api/v1/membership/redeem/{reward}`

- Aksi dan bukti. [MembershipController::redeem](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L85)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-54 · KF-16.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `reward`.

### API-083

`POST /api/v1/membership/register`

- Aksi dan bukti. [MembershipController::register](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L44)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-53 · KF-16.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['name' => ['required', 'string', 'max:255'], 'email' => ['required', 'email', 'max:255', \Illuminate\Validation\Rule::unique('users', 'email')->ignore($user->id)], 'phone' => ['required', 'string', 'max:30']]
```

### API-084

`GET /api/v1/membership/vouchers`

- Aksi dan bukti. [MembershipController::myVouchers](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L139)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-52, UC-54 · KF-16.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.membershipVouchers`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `user`, `vouchers`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-085

`GET /api/v1/notifications`

- Aksi dan bukti. [NotificationController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L16)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-58, UC-59 · KF-17.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.notifications`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `notifications`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-086

`POST /api/v1/notifications/mark-all-read`

- Aksi dan bukti. [NotificationController::markAllAsRead](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L49)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-59 · KF-17.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-087

`POST /api/v1/notifications/{id}/read`

- Aksi dan bukti. [NotificationController::markAsRead](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L33)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-59 · KF-17.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-088

`POST /api/v1/order-reviews`

- Aksi dan bukti. [OrderReviewController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L18)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-49 · KF-15.
- Respons. Key JSON terlihat pada cabang respons. `success, message` · `success, message, review`.
- Status. 200 umum; 400, 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['order_item_id' => 'required|exists:order_items,id', 'rating' => 'required|integer|min:1|max:5', 'deskripsi_ulasan' => 'nullable|string|max:1000']
```

### API-089

`GET /api/v1/order-reviews/{orderItemId}`

- Aksi dan bukti. [OrderReviewController::show](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L73)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-49 · KF-15.
- Respons. Key JSON terlihat pada cabang respons. `success, message` · `success, message, debug, order_item_id, user_id` · `success, review, rating, deskripsi_ulasan, created_at`.
- Status. 200 umum; 401, 404 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `orderItemId`.

### API-090

`POST /api/v1/orders/{order}/confirm-arrived`

- Aksi dan bukti. [PurchaseHistoryController::confirmArrived](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PurchaseHistoryController.php#L98)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-27 · KF-06.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `order`.

### API-091

`GET /api/v1/payment`

- Aksi dan bukti. [PaymentController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L21)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-16, UC-20, UC-23 · KF-03, KF-04, KF-05.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.payment`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `checkoutData`, `paymentDeadline`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-092

`POST /api/v1/payment/store`

- Aksi dan bukti. [PaymentController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L45)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-16, UC-20 · KF-03, KF-04, KF-05.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `file('payment_proof')`.

### API-093

`POST /api/v1/product-reviews`

- Aksi dan bukti. [ReviewController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L20)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Key JSON terlihat pada cabang respons. `success, review`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['product_id' => 'required|integer', 'rating' => 'required|integer|min:1|max:5', 'comment' => 'nullable|string|max:2000']
```

### API-094

`PUT /api/v1/product-reviews/{id}`

- Aksi dan bukti. [ReviewController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L41)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Key JSON terlihat pada cabang respons. `error` · `success, review`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

```php
['rating' => 'required|integer|min:1|max:5', 'comment' => 'nullable|string|max:2000']
```

### API-095

`DELETE /api/v1/product-reviews/{id}`

- Aksi dan bukti. [ReviewController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L63)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Key JSON terlihat pada cabang respons. `error` · `success`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-096

`GET /api/v1/products/{id}`

- Aksi dan bukti. [CustomerProductController::show](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L80)
- Akses. Publik · bearer opsional. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-11, UC-50 · KF-01, KF-15.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.detailProduct`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-097

`GET /api/v1/products/{id}/reviews`

- Aksi dan bukti. [ReviewController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L13)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-50 · KF-15.
- Respons. Respons mengikuti aksi yang dirujuk. Telusuri delegasi helper atau rule request di sumber aksi.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-098

`GET /api/v1/profile`

- Aksi dan bukti. [UserProfileController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L17)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-05, UC-15, UC-17, UC-18, UC-26, UC-27 · KF-04, KF-06, KF-11.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.userProfile`. Key data halaman yang terlihat. `userProfile`, `purchaseHistory`, `addresses`, `totalOrders`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-099

`POST /api/v1/profile/addresses`

- Aksi dan bukti. [UserAddressController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L16)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-15 · KF-06, KF-11.
- Respons. Key JSON terlihat pada cabang respons. `success, errors` · `success, message, address`.
- Status. 200 umum; 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-100

`DELETE /api/v1/profile/addresses/{id}`

- Aksi dan bukti. [UserAddressController::destroy](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L142)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-15 · KF-06, KF-11.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 404 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-101

`POST /api/v1/profile/addresses/{id}/set-primary`

- Aksi dan bukti. [UserAddressController::setPrimary](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L114)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-15 · KF-06, KF-11.
- Respons. Key JSON terlihat pada cabang respons. `success, message`.
- Status. 200 umum; 404 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-102

`POST /api/v1/profile/addresses/{id}/update`

- Aksi dan bukti. [UserAddressController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L62)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-15 · KF-06, KF-11.
- Respons. Key JSON terlihat pada cabang respons. `success, message` · `success, errors` · `success, message, address`.
- Status. 200 umum; 404, 422 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-103

`GET /api/v1/profile/edit`

- Aksi dan bukti. [UserProfileController::edit](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L44)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-06 · KF-11.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.editProfile`. Key data halaman yang terlihat. `userProfile`, `addresses`, `addressFormData`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-104

`POST /api/v1/profile/edit`

- Aksi dan bukti. [UserProfileController::update](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L84)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-06 · KF-11.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `hasFile('profile_photo')`, `file('profile_photo')`.

```php
[
    'username' => 'required|string|max:255',
    'full_name' => 'nullable|string|max:255',
    'phone_number' => 'nullable|string|max:50',
    'birth_date' => 'nullable|date',
    'gender' => 'nullable|string|max:1',
    'profile_photo' => 'nullable|image|max:10240',
    // address fields
    'address_line' => 'nullable|string|max:1000',
    'city' => 'nullable|string|max:255',
    'province' => 'nullable|string|max:255',
    'postal_code' => 'nullable|string|max:20',
]
```

### API-105

`POST /api/v1/register`

- Aksi dan bukti. [UserController::doRegister](../../../../Motifnesia-Server/app/Http/Controllers/Auth/UserController.php#L14)
- Akses. Guest · rate limiter, sesi aktif ditolak. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-02 · KF-10.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

```php
['username' => 'required|min:3|unique:users,name', 'full_name' => 'nullable|string|max:255', 'email' => 'required|email|unique:users,email', 'password' => 'required|min:6|confirmed', 'secret_question' => 'required', 'secret_answer' => 'required']
```

### API-106

`GET /api/v1/returns`

- Aksi dan bukti. [ReturnController::index](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L109)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-40, UC-46 · KF-08.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.myReturns`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-107

`POST /api/v1/returns`

- Aksi dan bukti. [ReturnController::store](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L52)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-39 · KF-08.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Pembacaan input di controller. `hasFile('photo_proof')`, `file('photo_proof')`.

```php
['order_item_id' => 'required|exists:order_items,id', 'reason' => 'required|in:Ukuran tidak sesuai,Barang rusak/cacat,Salah kirim produk,Tidak sesuai deskripsi,Berubah pikiran,Lainnya', 'description' => 'nullable|string|max:1000', 'photo_proof' => 'nullable|image|mimes:jpeg,png,jpg|max:2048', 'action_type' => 'required|in:Refund,Tukar Barang']
```

### API-108

`GET /api/v1/returns/create/{orderItemId}`

- Aksi dan bukti. [ReturnController::create](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L20)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-39 · KF-08.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.returProduct`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `orderItemId`.

### API-109

`PATCH /api/v1/returns/{id}/cancel`

- Aksi dan bukti. [ReturnController::cancel](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L124)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. Aksi pendukung aktual atau alur lama · —.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

### API-110

`POST /api/v1/returns/{id}/courier-proof`

- Aksi dan bukti. [ReturnController::submitCourierProof](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L146)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-42 · KF-03, KF-08.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `id`.

Pembacaan input di controller. `file('courier_photo')`.

```php
['courier_photo' => 'required|image|mimes:jpeg,png,jpg|max:4096', 'courier_note' => 'nullable|string|max:500']
```

### API-111

`GET /api/v1/returns/{return}/proof/{kind}`

- Aksi dan bukti. [ProofController::customerReturn](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L21)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-40 · KF-08.
- Respons. Berkas bukti privat dengan jenis gambar dibatasi dan kontrol akses.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `return`, `kind`.

### API-112

`GET /api/v1/search/live`

- Aksi dan bukti. [CustomerProductController::liveSearch](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L135)
- Akses. Publik · bearer opsional. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-10 · KF-02.
- Respons. Respons mengikuti aksi yang dirujuk. Telusuri delegasi helper atau rule request di sumber aksi.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-113

`GET /api/v1/supplier/procurements`

- Aksi dan bukti. [ProcurementController::index](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L13)
- Akses. Bearer v1 · supplier. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-32 · KF-09.
- Respons. Envelope `page`, `data`, `viewer` untuk `supplier.procurements.index`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.

### API-114

`GET /api/v1/supplier/procurements/{procurement}`

- Aksi dan bukti. [ProcurementController::show](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L29)
- Akses. Bearer v1 · supplier. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-32 · KF-09.
- Respons. Envelope `page`, `data`, `viewer` untuk `supplier.procurements.show`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `procurement`.

### API-115

`POST /api/v1/supplier/procurements/{procurement}/status`

- Aksi dan bukti. [ProcurementController::updateStatus](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L43)
- Akses. Bearer v1 · supplier. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-32 · KF-09.
- Respons. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`.
- Status. 200 umum; 403 eksplisit; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `procurement`.

```php
['status' => 'required|in:approved,in_delivery']
```

### API-116

`GET /api/v1/transaction/success/{orderId}`

- Aksi dan bukti. [PaymentController::success](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L100)
- Akses. Bearer v1 · customer. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-18, UC-23, UC-26 · KF-04, KF-05, KF-06.
- Respons. Envelope `page`, `data`, `viewer` untuk `customer.pages.transactionSuccess`. Redirect controller dinormalisasi menjadi `redirect`, `flash`, `errors`, `message`. Key data halaman yang terlihat. `order`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Parameter path. `orderId`.

### API-117

`GET /api/v1/viewer`

- Aksi dan bukti. [WebAuthController::viewer](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L49)
- Akses. Publik · bearer opsional. Ketentuan objek dan pembatas data mengikuti aksi.
- Use Case / KF. UC-01 · KF-10.
- Respons. Key JSON terlihat pada cabang respons. `viewer`.
- Status. 200 umum; aturan bersama berlaku.

**Request dan aturan validasi yang terbaca**

Input melalui konteks route, sesi, token, atau delegasi pada aksi. Tidak ada field input eksplisit yang terdeteksi pada metode ini.
