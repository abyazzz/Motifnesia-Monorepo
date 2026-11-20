# Inventaris Controller AS-IMPLEMENTED

Semua 41 class controller dicatat, termasuk controller dasar dan class yang belum terhubung ke route. Signature dan sumber diambil dari AST PHP. Kolom dependensi mencantumkan referensi kelas aplikasi yang terlihat pada body, bukan graph runtime container.

## Controller Admin Commerce

### App / Http / Controllers / Admin / AdminProductController

Class `AdminProductController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L16)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L21) | Menangani `GET /admin/daftar-produk`. | `App\Support\WebApi\FrontendUrl` | [`GET /admin/daftar-produk`](../API-DESIGN/API-CURRENT.md#api-003) |
| [public function createOrStore(\Illuminate\Http\Request $request, \App\Services\ProductService $productService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L30) | Menyusun data untuk `admin.pages.addProduct`. | `App\Models\Produk`, `App\Support\WebApi\FrontendUrl`, `App\Support\AssetUrl` | [`GET&#124;POST /admin/products/create`](../API-DESIGN/API-CURRENT.md#api-037) |
| [public function manage() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L113) | Menyusun data untuk `admin.pages.productManagement`. | `App\Models\Produk` | [`GET /admin/product-management`](../API-DESIGN/API-CURRENT.md#api-033) |
| [public function update(\App\Http\Requests\UpdateProductRequest $request, $id, \App\Services\ProductService $productService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L129) | Menangani `POST /admin/products/{id}/update`. | `App\Models\Produk` | [`POST /admin/products/{id}/update`](../API-DESIGN/API-CURRENT.md#api-039) |
| [public function destroy($id, \App\Services\ProductService $productService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L193) | Menangani `POST /admin/products/{id}/delete`. | `App\Models\Produk` | [`POST /admin/products/{id}/delete`](../API-DESIGN/API-CURRENT.md#api-038) |
| [private function notifyMembersAboutProduct(\App\Models\Produk $produk, string $context = 'new'): int ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/AdminProductController.php#L209) | Aksi internal `notifyMembersAboutProduct`. Perilaku rinci ada pada sumber metode. | `App\Models\User`, `App\Models\Notification`, `App\Support\WebApi\FrontendUrl` | — |

### App / Http / Controllers / Admin / ChatController

Class `ChatController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L15)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public static function middleware(): array ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L17) | Mendefinisikan middleware controller. | — | — |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L27) | Menampilkan halaman Live Chat Support. | `App\Models\Chat` | [`GET /admin/live-chat`](../API-DESIGN/API-CURRENT.md#api-009) |
| [public function sendMessage(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L53) | Send message from admin | `App\Models\Chat`, `App\Models\ChatMessage` | [`POST /admin/live-chat/send`](../API-DESIGN/API-CURRENT.md#api-011) |
| [public function getNewMessages(\Illuminate\Http\Request $request, $chatId) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L92) | Get new messages (Polling) | `App\Models\ChatMessage` | [`GET /admin/live-chat/{chatId}/messages`](../API-DESIGN/API-CURRENT.md#api-012) |
| [public function getChatList() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ChatController.php#L126) | Get chat list updates | `App\Models\Chat` | [`GET /admin/live-chat/list`](../API-DESIGN/API-CURRENT.md#api-010) |

### App / Http / Controllers / Admin / CustomerController

Class `CustomerController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php#L15)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php#L20) | Menampilkan daftar pelanggan yang pernah membeli produk. | `App\Models\User` | [`GET /admin/customers`](../API-DESIGN/API-CURRENT.md#api-001) |
| [public function destroy($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/CustomerController.php#L54) | Nonaktifkan/aktifkan customer tanpa menghapus histori transaksi. | `App\Models\User`, `App\Services\AuditLogService`, `App\Support\WebApi\FrontendUrl` | [`DELETE /admin/customers/{id}`](../API-DESIGN/API-CURRENT.md#api-002) |

### App / Http / Controllers / Admin / MembershipController

Class `MembershipController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L22)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public static function middleware(): array ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L24) | Mendefinisikan middleware controller. | — | — |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L31) | Menyusun data untuk `admin.pages.memberships.index`. | `App\Models\User` | [`GET /admin/memberships`](../API-DESIGN/API-CURRENT.md#api-021) |
| [public function updateMemberStatus(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L44) | Menangani `POST /admin/memberships/{id}/status`. | `App\Models\User`, `App\Models\Notification`, `App\Support\WebApi\FrontendUrl`, `App\Services\AuditLogService` | [`POST /admin/memberships/{id}/status`](../API-DESIGN/API-CURRENT.md#api-023) |
| [public function adjustPoints(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L78) | Menangani `POST /admin/memberships/{id}/points`. | `App\Models\User`, `App\Models\PointTransaction`, `App\Models\Notification`, `App\Support\WebApi\FrontendUrl`, `App\Services\AuditLogService` | [`POST /admin/memberships/{id}/points`](../API-DESIGN/API-CURRENT.md#api-022) |
| [public function rewards() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L126) | Menyusun data untuk `admin.pages.memberships.rewards`. | `App\Models\MembershipReward` | [`GET /admin/membership-rewards`](../API-DESIGN/API-CURRENT.md#api-015) |
| [public function createReward() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L138) | Menyusun data untuk `admin.pages.memberships.rewardForm`. | `App\Models\MembershipReward` | [`GET /admin/membership-rewards/create`](../API-DESIGN/API-CURRENT.md#api-017) |
| [public function storeReward(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L147) | Menangani `POST /admin/membership-rewards`. | `App\Models\MembershipReward`, `App\Services\AuditLogService`, `App\Support\WebApi\FrontendUrl` | [`POST /admin/membership-rewards`](../API-DESIGN/API-CURRENT.md#api-016) |
| [public function editReward($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L159) | Menyusun data untuk `admin.pages.memberships.rewardForm`. | `App\Models\MembershipReward` | [`GET /admin/membership-rewards/{id}/edit`](../API-DESIGN/API-CURRENT.md#api-020) |
| [public function updateReward(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L170) | Menangani `PUT /admin/membership-rewards/{id}`. | `App\Models\MembershipReward`, `App\Services\AuditLogService`, `App\Support\WebApi\FrontendUrl` | [`PUT /admin/membership-rewards/{id}`](../API-DESIGN/API-CURRENT.md#api-018) |
| [public function destroyReward($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L181) | Menangani `DELETE /admin/membership-rewards/{id}`. | `App\Models\MembershipReward`, `App\Services\AuditLogService`, `App\Support\WebApi\FrontendUrl` | [`DELETE /admin/membership-rewards/{id}`](../API-DESIGN/API-CURRENT.md#api-019) |
| [public function broadcastForm() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L192) | Menyusun data untuk `admin.pages.memberships.broadcast`. | `App\Models\User` | [`GET /admin/membership-broadcast`](../API-DESIGN/API-CURRENT.md#api-013) |
| [public function broadcast(\Illuminate\Http\Request $request, \App\Services\MemberNotificationService $notifier) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L211) | Menangani `POST /admin/membership-broadcast`. | `App\Models\User`, `App\Support\WebApi\FrontendUrl` | [`POST /admin/membership-broadcast`](../API-DESIGN/API-CURRENT.md#api-014) |
| [private function validatedRewardData(\Illuminate\Http\Request $request): array ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/MembershipController.php#L251) | Memvalidasi d reward data. Perilaku rinci ada pada sumber metode. | — | — |

### App / Http / Controllers / Admin / NotificationController

Class `NotificationController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L11)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L16) | Menampilkan halaman notifikasi | `App\Models\Notification` | [`GET /admin/notifications`](../API-DESIGN/API-CURRENT.md#api-024) |
| [public function toggleRead($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L69) | Mark single notification as read/unread | `App\Models\Notification` | [`POST /admin/notifications/{id}/toggle-read`](../API-DESIGN/API-CURRENT.md#api-028) |
| [public function markAllRead() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L84) | Mark all as read | `App\Models\Notification`, `App\Support\WebApi\FrontendUrl` | [`POST /admin/notifications/mark-all-read`](../API-DESIGN/API-CURRENT.md#api-026) |
| [public function destroy($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L95) | Delete single notification | `App\Models\Notification` | [`DELETE /admin/notifications/{id}`](../API-DESIGN/API-CURRENT.md#api-027) |
| [public function clearRead() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L109) | Clear all read notifications | `App\Models\Notification`, `App\Support\WebApi\FrontendUrl` | [`POST /admin/notifications/clear-read`](../API-DESIGN/API-CURRENT.md#api-025) |
| [public static function create($type, $title, $message, $link = null, $priority = 'normal') ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/NotificationController.php#L120) | Create notification (helper method) | `App\Models\Notification` | — |

### App / Http / Controllers / Admin / OrderStatusController

Class `OrderStatusController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L16)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L21) | Menampilkan halaman status pengiriman. | `App\Models\Order`, `App\Models\DeliveryStatus` | [`GET /admin/order-status`](../API-DESIGN/API-CURRENT.md#api-029) |
| [public function updateStatus(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L47) | Update status pengiriman | `App\Models\Order`, `App\Models\OrderStatusHistory`, `App\Services\AuditLogService` | [`POST /admin/order-status/{id}/update`](../API-DESIGN/API-CURRENT.md#api-031) |
| [public function updatePaymentStatus(\Illuminate\Http\Request $request, $id, \App\Services\OrderService $orderService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/OrderStatusController.php#L85) | Menangani `POST /admin/order-status/{id}/payment`. | `App\Models\Order`, `App\Models\Notification`, `App\Support\WebApi\FrontendUrl`, `App\Services\AuditLogService` | [`POST /admin/order-status/{id}/payment`](../API-DESIGN/API-CURRENT.md#api-030) |

### App / Http / Controllers / Admin / ProductReviewController

Class `ProductReviewController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L19) | Menampilkan halaman ulasan produk. | `App\Models\Produk` | [`GET /admin/product-reviews`](../API-DESIGN/API-CURRENT.md#api-034) |
| [public function show($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L75) | Menampilkan detail ulasan untuk produk tertentu. | `App\Models\Produk` | [`GET /admin/product-reviews/{id}`](../API-DESIGN/API-CURRENT.md#api-035) |
| [public function moderate(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L111) | Menangani `POST /admin/product-reviews/{id}/moderate`. | `App\Models\OrderReview` | [`POST /admin/product-reviews/{id}/moderate`](../API-DESIGN/API-CURRENT.md#api-036) |
| [private function updateProductRating(int $productId): void ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ProductReviewController.php#L131) | Memperbarui product rating. Perilaku rinci ada pada sumber metode. | `App\Models\OrderReview`, `App\Models\Produk` | — |

### App / Http / Controllers / Admin / ReportController

Class `ReportController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L17)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L22) | Menampilkan halaman Laporan Penjualan. | `App\Models\Order`, `App\Models\OrderItem`, `App\Models\PointTransaction`, `App\Models\User`, `App\Models\UserRewardRedemption` | [`GET /admin/sales-report`](../API-DESIGN/API-CURRENT.md#api-044) |
| [private function getStartDate($period, $endDate) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L120) | Get start date based on period | — | — |
| [private function fillMissingDates($sales, $startDate, $endDate) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L139) | Fill missing dates with 0 sales | — | — |
| [public function export(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReportController.php#L160) | Export to Excel | `App\Models\Order` | [`GET /admin/sales-report/export`](../API-DESIGN/API-CURRENT.md#api-045) |

### App / Http / Controllers / Admin / ReturnController

Class `ReturnController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public static function middleware(): array ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L15) | Mendefinisikan middleware controller. | — | — |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L25) | Menampilkan halaman kelola retur. | `App\Models\ProductReturn` | [`GET /admin/returns`](../API-DESIGN/API-CURRENT.md#api-040) |
| [public function updateStatus(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L58) | Update status retur | `App\Models\ProductReturn` | [`POST /admin/returns/{id}/update-status`](../API-DESIGN/API-CURRENT.md#api-042) |
| [public function destroy($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReturnController.php#L111) | Delete retur | `App\Models\ProductReturn` | [`DELETE /admin/returns/{id}`](../API-DESIGN/API-CURRENT.md#api-041) |

### App / Http / Controllers / Admin / ReviewController

Class `ReviewController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/ReviewController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReviewController.php#L11)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/ReviewController.php#L17) | Menampilkan halaman ulasan produk. | `App\Models\Produk` | — |

### App / Http / Controllers / Admin / StaticContentController

Class `StaticContentController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L15)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public static function middleware(): array ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L17) | Mendefinisikan middleware controller. | — | — |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L24) | Menyusun data untuk `admin.pages.kontenStatis`. | `App\Models\KontenSlideShow` | [`GET /admin/konten`](../API-DESIGN/API-CURRENT.md#api-004) |
| [public function updateAbout(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L35) | Memperbarui about. Perilaku rinci ada pada sumber metode. | `App\Models\KontenAboutUs` | — |
| [public function updateIcon(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L74) | Memperbarui icon. Perilaku rinci ada pada sumber metode. | `App\Models\KontenIcon` | — |
| [public function updateSlideshow(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L151) | Menangani `POST /admin/konten/slideshow`. | `App\Models\KontenSlideShow` | [`POST /admin/konten/slideshow`](../API-DESIGN/API-CURRENT.md#api-008) |
| [public function storeSlide(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L185) | Menangani `POST /admin/konten/slides/create`. | `App\Models\KontenSlideShow` | [`POST /admin/konten/slides/create`](../API-DESIGN/API-CURRENT.md#api-005) |
| [public function updateSlide(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L207) | Menangani `POST /admin/konten/slides/{id}/update`. | `App\Models\KontenSlideShow` | [`POST /admin/konten/slides/{id}/update`](../API-DESIGN/API-CURRENT.md#api-007) |
| [public function deleteSlide(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StaticContentController.php#L230) | Menangani `POST /admin/konten/slides/{id}/delete`. | `App\Models\KontenSlideShow` | [`POST /admin/konten/slides/{id}/delete`](../API-DESIGN/API-CURRENT.md#api-006) |

## Controller Admin Warehouse

### App / Http / Controllers / Admin / StockOpnameController

Class `StockOpnameController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\App\Services\StockInventoryService $stockInventoryService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php#L15) | Menyusun data untuk `admin.pages.stockOpname.index`. | `App\Models\StockOpname`, `App\Services\StockInventoryService` | [`GET /admin/stock-opname`](../API-DESIGN/API-CURRENT.md#api-046) |
| [public function adjust(\Illuminate\Http\Request $request, \App\Services\StockInventoryService $stockInventoryService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockOpnameController.php#L27) | Menangani `POST /admin/stock-opname/adjust`. | `App\Models\Produk`, `App\Support\WebApi\FrontendUrl` | [`POST /admin/stock-opname/adjust`](../API-DESIGN/API-CURRENT.md#api-047) |

### App / Http / Controllers / Admin / StockProcurementController

Class `StockProcurementController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L15)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L17) | Menyusun data untuk `admin.pages.stockProcurements.index`. | `App\Models\StockProcurement` | [`GET /admin/stock-procurements`](../API-DESIGN/API-CURRENT.md#api-048) |
| [public function create() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L45) | Menyusun data untuk `admin.pages.stockProcurements.create`. | `App\Models\Supplier`, `App\Models\Produk`, `App\Services\StockInventoryService` | [`GET /admin/stock-procurements/create`](../API-DESIGN/API-CURRENT.md#api-050) |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L63) | Menangani `POST /admin/stock-procurements`. | `App\Models\StockProcurement`, `App\Support\WebApi\FrontendUrl` | [`POST /admin/stock-procurements`](../API-DESIGN/API-CURRENT.md#api-049) |
| [public function show(\App\Models\StockProcurement $stockProcurement) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L104) | Menyusun data untuk `admin.pages.stockProcurements.show`. | `App\Models\StockProcurement`, `App\Services\StockInventoryService` | [`GET /admin/stock-procurements/{stockProcurement}`](../API-DESIGN/API-CURRENT.md#api-051) |
| [public function confirmArrived(\App\Models\StockProcurement $stockProcurement) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L118) | Menangani `POST /admin/stock-procurements/{stockProcurement}/confirm-arrived`. | `App\Models\StockProcurement` | [`POST /admin/stock-procurements/{stockProcurement}/confirm-arrived`](../API-DESIGN/API-CURRENT.md#api-053) |
| [public function applyStock(\App\Models\StockProcurement $stockProcurement, \App\Services\StockInventoryService $stockInventoryService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L135) | Menangani `POST /admin/stock-procurements/{stockProcurement}/apply-stock`. | `App\Support\WebApi\FrontendUrl` | [`POST /admin/stock-procurements/{stockProcurement}/apply-stock`](../API-DESIGN/API-CURRENT.md#api-052) |
| [private function normalizeItems(array $rawItems): array ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L149) | Menormalkan items. Perilaku rinci ada pada sumber metode. | `App\Models\Produk` | — |
| [private function generateProcurementNumber(): string ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/StockProcurementController.php#L194) | Aksi internal `generateProcurementNumber`. Perilaku rinci ada pada sumber metode. | `App\Models\StockProcurement` | — |

### App / Http / Controllers / Admin / SupplierController

Class `SupplierController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L16)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L18) | Menyusun data untuk `admin.pages.suppliers.index`. | `App\Models\Supplier` | [`GET /admin/suppliers`](../API-DESIGN/API-CURRENT.md#api-054) |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L34) | Menangani `POST /admin/suppliers`. | `App\Models\Supplier`, `App\Support\WebApi\FrontendUrl` | [`POST /admin/suppliers`](../API-DESIGN/API-CURRENT.md#api-055) |
| [public function update(\Illuminate\Http\Request $request, \App\Models\Supplier $supplier) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L52) | Menangani `PUT /admin/suppliers/{supplier}`. | `App\Support\WebApi\FrontendUrl` | [`PUT /admin/suppliers/{supplier}`](../API-DESIGN/API-CURRENT.md#api-056) |
| [public function destroy(\App\Models\Supplier $supplier) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L69) | Menangani `DELETE /admin/suppliers/{supplier}`. | `App\Support\WebApi\FrontendUrl` | [`DELETE /admin/suppliers/{supplier}`](../API-DESIGN/API-CURRENT.md#api-057) |
| [private function validatedSupplier(\Illuminate\Http\Request $request, ?\App\Models\Supplier $supplier = null): array ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L88) | Memvalidasi d supplier. Perilaku rinci ada pada sumber metode. | — | — |
| [private function syncSupplierUser(?\App\Models\Supplier $supplier, array $data, ?string $password): ?int ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L102) | Menyelaraskan supplier user. Perilaku rinci ada pada sumber metode. | `App\Models\User` | — |
| [private function uniqueUsername(string $name): string ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/SupplierController.php#L163) | Aksi internal `uniqueUsername`. Perilaku rinci ada pada sumber metode. | `App\Models\User` | — |

### App / Http / Controllers / Admin / WarehouseController

Class `WarehouseController` mempunyai namespace `App\Http\Controllers\Admin`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Admin/WarehouseController.php](../../../../Motifnesia-Server/app/Http/Controllers/Admin/WarehouseController.php#L11)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\App\Services\StockInventoryService $stockInventoryService) ](../../../../Motifnesia-Server/app/Http/Controllers/Admin/WarehouseController.php#L13) | Menyusun data untuk `admin.pages.warehouse.index`. | `App\Models\StockProcurement`, `App\Models\StockMovement`, `App\Services\StockInventoryService` | [`GET /admin/warehouse`](../API-DESIGN/API-CURRENT.md#api-058) |

## Controller Api

### App / Http / Controllers / Api / ApiProductController

Class `ApiProductController` mempunyai namespace `App\Http\Controllers\Api`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L10)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L22) | ======================================== | `App\Models\Produk` | — |
| [public function show($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L75) | ======================================== | `App\Models\Produk` | — |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L125) | ======================================== | `App\Models\Produk` | — |
| [public function update(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L210) | ======================================== | `App\Models\Produk` | — |
| [public function destroy($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L329) | ======================================== | `App\Models\Produk` | — |
| [public function categories() ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L369) | ======================================== | `App\Models\Produk` | — |
| [public function search(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductController.php#L401) | ======================================== | `App\Models\Produk` | — |

### App / Http / Controllers / Api / ApiProductFavoriteController

Class `ApiProductFavoriteController` mempunyai namespace `App\Http\Controllers\Api`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php#L12)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php#L24) | ======================================== | `App\Models\ProductFavorite` | — |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php#L82) | ======================================== | `App\Models\Produk`, `App\Models\ProductFavorite` | — |
| [public function destroy(\Illuminate\Http\Request $request, $favoriteId) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php#L153) | ======================================== | `App\Models\ProductFavorite` | — |
| [public function check(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php#L192) | ======================================== | `App\Models\ProductFavorite` | — |
| [public function addToCart(\Illuminate\Http\Request $request, $favoriteId) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php#L236) | ======================================== | `App\Models\ProductFavorite`, `App\Models\ShoppingCard` | — |
| [public function count(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiProductFavoriteController.php#L355) | ======================================== | `App\Models\ProductFavorite` | — |

### App / Http / Controllers / Api / ApiShoppingCardController

Class `ApiShoppingCardController` mempunyai namespace `App\Http\Controllers\Api`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php#L12)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php#L26) | ======================================== | `App\Models\ShoppingCard` | — |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php#L100) | ======================================== | `App\Models\Produk`, `App\Models\ShoppingCard` | — |
| [public function update(\Illuminate\Http\Request $request, $cartId) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php#L213) | ======================================== | `App\Models\ShoppingCard` | — |
| [public function destroy(\Illuminate\Http\Request $request, $cartId) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php#L299) | ======================================== | `App\Models\ShoppingCard` | — |
| [public function clear(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php#L340) | ======================================== | `App\Models\ShoppingCard` | — |
| [public function count(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiShoppingCardController.php#L371) | ======================================== | `App\Models\ShoppingCard` | — |

### App / Http / Controllers / Api / ApiUserAddressController

Class `ApiUserAddressController` mempunyai namespace `App\Http\Controllers\Api`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L10)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L18) | ======================================== | `App\Models\UserAddress` | — |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L63) | ======================================== | `App\Models\UserAddress` | — |
| [public function show(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L122) | ======================================== | `App\Models\UserAddress` | — |
| [public function update(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L160) | ======================================== | `App\Models\UserAddress` | — |
| [public function setPrimary(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L230) | ======================================== | `App\Models\UserAddress` | — |
| [public function destroy(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L272) | ======================================== | `App\Models\UserAddress` | — |
| [public function getPrimary(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserAddressController.php#L320) | ======================================== | `App\Models\UserAddress` | — |

### App / Http / Controllers / Api / ApiUserController

Class `ApiUserController` mempunyai namespace `App\Http\Controllers\Api`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L12)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function register(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L28) | ======================================== | `App\Models\User` | — |
| [public function login(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L100) | ======================================== | — | — |
| [public function profile(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L184) | ======================================== | — | — |
| [public function updateProfile(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L252) | ======================================== | — | — |
| [public function logout(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L475) | ======================================== | — | — |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L506) | ======================================== | `App\Models\User` | — |
| [public function show(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L566) | ======================================== | `App\Models\User` | — |
| [public function destroy(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Api/ApiUserController.php#L627) | ======================================== | `App\Models\User` | — |

### App / Http / Controllers / Api / WebAuthController

Class `WebAuthController` mempunyai namespace `App\Http\Controllers\Api`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function login(\Illuminate\Http\Request $request, \App\Services\WebCredentials $credentials): \Illuminate\Http\JsonResponse ](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L15) | Menangani `POST /login`. | `App\Support\WebApi\Viewer` | [`POST /login`](../API-DESIGN/API-CURRENT.md#api-078) |
| [public function viewer(): \Illuminate\Http\JsonResponse ](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L49) | Menangani `GET /viewer`. | `App\Support\WebApi\Viewer` | [`GET /viewer`](../API-DESIGN/API-CURRENT.md#api-117) |
| [public function logout(\Illuminate\Http\Request $request): \Illuminate\Http\JsonResponse ](../../../../Motifnesia-Server/app/Http/Controllers/Api/WebAuthController.php#L55) | Menangani `POST /logout`. | — | [`POST /logout`](../API-DESIGN/API-CURRENT.md#api-079) |

## Controller Auth

### App / Http / Controllers / Auth / UserController

Class `UserController` mempunyai namespace `App\Http\Controllers\Auth`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Auth/UserController.php](../../../../Motifnesia-Server/app/Http/Controllers/Auth/UserController.php#L11)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function doRegister(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Auth/UserController.php#L14) | Menangani `POST /register`. | `App\Models\User`, `App\Support\WebApi\FrontendUrl` | [`POST /register`](../API-DESIGN/API-CURRENT.md#api-105) |
| [public function doForgot(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Auth/UserController.php#L45) | Menangani `POST /forgot`. | `App\Models\User`, `App\Support\WebApi\FrontendUrl` | [`POST /forgot`](../API-DESIGN/API-CURRENT.md#api-076) |

## Controller Controllers

### App / Http / Controllers / Controller

Class `Controller` mempunyai namespace `App\Http\Controllers`. [Motifnesia-Server/app/Http/Controllers/Controller.php](../../../../Motifnesia-Server/app/Http/Controllers/Controller.php#L8)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [protected function page(string $view, array $data = []): \Illuminate\Http\JsonResponse ](../../../../Motifnesia-Server/app/Http/Controllers/Controller.php#L10) | Aksi internal `page`. Perilaku rinci ada pada sumber metode. | `App\Support\WebApi\Page` | — |

### App / Http / Controllers / ProofController

Class `ProofController` mempunyai namespace `App\Http\Controllers`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/ProofController.php](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L12)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function payment(\App\Models\Order $order, \App\Services\ProofMedia $media): \Symfony\Component\HttpFoundation\StreamedResponse ](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L14) | Menangani `GET /admin/order-status/{order}/payment-proof`. | — | [`GET /admin/order-status/{order}/payment-proof`](../API-DESIGN/API-CURRENT.md#api-032) |
| [public function customerReturn(\App\Models\ProductReturn $return, string $kind, \App\Services\ProofMedia $media): \Symfony\Component\HttpFoundation\StreamedResponse ](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L21) | Menangani `GET /returns/{return}/proof/{kind}`. | — | [`GET /returns/{return}/proof/{kind}`](../API-DESIGN/API-CURRENT.md#api-111) |
| [public function adminReturn(\App\Models\ProductReturn $return, string $kind, \App\Services\ProofMedia $media): \Symfony\Component\HttpFoundation\StreamedResponse ](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L28) | Menangani `GET /admin/returns/{return}/proof/{kind}`. | — | [`GET /admin/returns/{return}/proof/{kind}`](../API-DESIGN/API-CURRENT.md#api-043) |
| [private function returnProof(\App\Models\ProductReturn $return, string $kind, \App\Services\ProofMedia $media): \Symfony\Component\HttpFoundation\StreamedResponse ](../../../../Motifnesia-Server/app/Http/Controllers/ProofController.php#L35) | Aksi internal `returnProof`. Perilaku rinci ada pada sumber metode. | — | — |

## Controller Customer Experience

### App / Http / Controllers / Customer / ChatController

Class `ChatController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L18) | Halaman Live Chat Customer | `App\Models\Chat` | [`GET /chat`](../API-DESIGN/API-CURRENT.md#api-064) |
| [public function getOrCreateChat(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L37) | Get atau Create Chat Room | `App\Models\Chat` | [`POST /chat/get-or-create`](../API-DESIGN/API-CURRENT.md#api-065) |
| [public function sendMessage(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L65) | Kirim Pesan | `App\Models\Chat`, `App\Models\ChatMessage` | [`POST /chat/send`](../API-DESIGN/API-CURRENT.md#api-067) |
| [public function askProduct(\Illuminate\Http\Request $request, $productId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L103) | Menangani `POST /chat/product/{productId}/ask`. | `App\Models\Produk`, `App\Models\Chat`, `App\Support\WebApi\FrontendUrl`, `App\Models\ChatMessage` | [`POST /chat/product/{productId}/ask`](../API-DESIGN/API-CURRENT.md#api-066) |
| [public function getNewMessages(\Illuminate\Http\Request $request, $chatId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L160) | Get New Messages (Polling) | `App\Models\Chat`, `App\Models\ChatMessage` | [`GET /chat/{chatId}/messages`](../API-DESIGN/API-CURRENT.md#api-069) |
| [public function closeChat($chatId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ChatController.php#L201) | Close Chat | `App\Models\Chat` | [`POST /chat/{chatId}/close`](../API-DESIGN/API-CURRENT.md#api-068) |

### App / Http / Controllers / Customer / CustomerProductController

Class `CustomerProductController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L18) | Halaman home dengan slideshow + produk (dengan filter) | `App\Models\KontenSlideShow`, `App\Models\Produk`, `App\Services\ProductService` | [`GET /homePage`](../API-DESIGN/API-CURRENT.md#api-077) |
| [public function show($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L80) | Detail produk dengan reviews dan related products | `App\Models\Produk`, `App\Services\ProductService` | [`GET /products/{id}`](../API-DESIGN/API-CURRENT.md#api-096) |
| [public function liveSearch() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L135) | Live search untuk autocomplete navbar | `App\Models\Produk`, `App\Support\AssetUrl`, `App\Support\WebApi\FrontendUrl` | [`GET /search/live`](../API-DESIGN/API-CURRENT.md#api-112) |
| [private function cleanFilterValue(mixed $value): ?string ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L160) | Aksi internal `cleanFilterValue`. Perilaku rinci ada pada sumber metode. | — | — |
| [private function whereNormalizedEquals($query, array $columns, string $value): void ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L177) | Aksi internal `whereNormalizedEquals`. Perilaku rinci ada pada sumber metode. | — | — |
| [private function parsePriceRange(mixed $value): ?array ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L188) | Aksi internal `parsePriceRange`. Perilaku rinci ada pada sumber metode. | — | — |
| [private function filterOptions(): array ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L207) | Aksi internal `filterOptions`. Perilaku rinci ada pada sumber metode. | — | — |
| [private function collectFilterOptions(array $columns, array $preferred = []): array ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CustomerProductController.php#L222) | Aksi internal `collectFilterOptions`. Perilaku rinci ada pada sumber metode. | `App\Models\Produk` | — |

### App / Http / Controllers / Customer / FavoriteController

Class `FavoriteController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/FavoriteController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/FavoriteController.php#L9)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/FavoriteController.php#L14) | Tampilkan halaman Daftar Produk Favorit (Wishlist). | — | — |

### App / Http / Controllers / Customer / MembershipController

Class `MembershipController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L14)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L16) | Menyusun data untuk `customer.pages.membership`. | `App\Models\MembershipReward` | [`GET /membership`](../API-DESIGN/API-CURRENT.md#api-080) |
| [public function register(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L44) | Menangani `POST /membership/register`. | `App\Models\Notification`, `App\Support\WebApi\FrontendUrl` | [`POST /membership/register`](../API-DESIGN/API-CURRENT.md#api-083) |
| [public function redeem($rewardId, \App\Services\MemberNotificationService $notifier) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L85) | Menangani `POST /membership/redeem/{reward}`. | `App\Support\WebApi\FrontendUrl`, `App\Models\MembershipReward` | [`POST /membership/redeem/{reward}`](../API-DESIGN/API-CURRENT.md#api-082) |
| [public function history() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L122) | Menyusun data untuk `customer.pages.membershipHistory`. | `App\Support\WebApi\FrontendUrl` | [`GET /membership/history`](../API-DESIGN/API-CURRENT.md#api-081) |
| [public function myVouchers() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/MembershipController.php#L139) | Menyusun data untuk `customer.pages.membershipVouchers`. | `App\Support\WebApi\FrontendUrl` | [`GET /membership/vouchers`](../API-DESIGN/API-CURRENT.md#api-084) |

### App / Http / Controllers / Customer / NotificationController

Class `NotificationController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L11)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L16) | Tampilkan halaman notifikasi (order + retur) | `App\Support\WebApi\FrontendUrl`, `App\Models\Notification` | [`GET /notifications`](../API-DESIGN/API-CURRENT.md#api-085) |
| [public function markAsRead($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L33) | Mark notifikasi sebagai read | `App\Models\Notification`, `App\Support\WebApi\FrontendUrl` | [`POST /notifications/{id}/read`](../API-DESIGN/API-CURRENT.md#api-087) |
| [public function markAllAsRead() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/NotificationController.php#L49) | Mark all notifikasi sebagai read | `App\Models\Notification` | [`POST /notifications/mark-all-read`](../API-DESIGN/API-CURRENT.md#api-086) |

### App / Http / Controllers / Customer / ProductFavoriteController

Class `ProductFavoriteController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L18) | Tampilkan halaman favorite | `App\Support\WebApi\FrontendUrl`, `App\Models\ProductFavorite` | [`GET /favorites`](../API-DESIGN/API-CURRENT.md#api-072) |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L36) | Tambah produk ke favorite | `App\Models\ProductFavorite` | [`POST /favorites/store`](../API-DESIGN/API-CURRENT.md#api-073) |
| [public function destroy($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L76) | Hapus produk dari favorite | `App\Support\WebApi\FrontendUrl`, `App\Models\ProductFavorite` | [`DELETE /favorites/{id}`](../API-DESIGN/API-CURRENT.md#api-074) |
| [public function addToCart($favoriteId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ProductFavoriteController.php#L98) | Tambah produk dari favorite ke shopping cart | `App\Support\WebApi\FrontendUrl`, `App\Models\ProductFavorite`, `App\Models\ShoppingCard` | [`POST /favorites/{id}/add-to-cart`](../API-DESIGN/API-CURRENT.md#api-075) |

### App / Http / Controllers / Customer / ReviewController

Class `ReviewController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L9)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index($productId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L13) | Menangani `GET /products/{id}/reviews`. | `App\Models\Review` | [`GET /products/{id}/reviews`](../API-DESIGN/API-CURRENT.md#api-097) |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L20) | Menangani `POST /product-reviews`. | `App\Models\Review` | [`POST /product-reviews`](../API-DESIGN/API-CURRENT.md#api-093) |
| [public function update(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L41) | Menangani `PUT /product-reviews/{id}`. | `App\Models\Review` | [`PUT /product-reviews/{id}`](../API-DESIGN/API-CURRENT.md#api-094) |
| [public function destroy($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReviewController.php#L63) | Menangani `DELETE /product-reviews/{id}`. | `App\Models\Review` | [`DELETE /product-reviews/{id}`](../API-DESIGN/API-CURRENT.md#api-095) |

### App / Http / Controllers / Customer / UserAddressController

Class `UserAddressController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L11)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L16) | Store alamat baru | `App\Models\UserAddress` | [`POST /profile/addresses`](../API-DESIGN/API-CURRENT.md#api-099) |
| [public function update(\Illuminate\Http\Request $request, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L62) | Update alamat | `App\Models\UserAddress` | [`POST /profile/addresses/{id}/update`](../API-DESIGN/API-CURRENT.md#api-102) |
| [public function setPrimary($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L114) | Set alamat sebagai primary | `App\Models\UserAddress` | [`POST /profile/addresses/{id}/set-primary`](../API-DESIGN/API-CURRENT.md#api-101) |
| [public function destroy($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserAddressController.php#L142) | Delete alamat | `App\Models\UserAddress` | [`DELETE /profile/addresses/{id}`](../API-DESIGN/API-CURRENT.md#api-100) |

### App / Http / Controllers / Customer / UserProfileController

Class `UserProfileController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L12)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L17) | Tampilkan halaman Profil Pengguna. | `App\Http\Controllers\Customer\PurchaseHistoryController` | [`GET /profile`](../API-DESIGN/API-CURRENT.md#api-098) |
| [public function edit() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L44) | Menyusun data untuk `customer.pages.editProfile`. | — | [`GET /profile/edit`](../API-DESIGN/API-CURRENT.md#api-103) |
| [public function update(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/UserProfileController.php#L84) | Update profile data (including optional profile photo upload) | `App\Support\WebApi\FrontendUrl` | [`POST /profile/edit`](../API-DESIGN/API-CURRENT.md#api-104) |

## Controller Customer Orders

### App / Http / Controllers / Customer / CheckOutController

Class `CheckOutController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L17)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L23) | Tampilkan halaman checkout | `App\Support\WebApi\FrontendUrl`, `App\Models\ShoppingCard`, `App\Models\User`, `App\Models\MetodePengiriman`, `App\Models\MetodePembayaran`, `App\Support\AssetUrl` | [`GET /checkout`](../API-DESIGN/API-CURRENT.md#api-070) |
| [public function store(\App\Http\Requests\CheckoutRequest $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L106) | Proses checkout: Simpan data checkout ke session dan redirect ke payment | `App\Models\ShoppingCard`, `App\Models\MetodePengiriman`, `App\Models\MetodePembayaran`, `App\Support\AssetUrl`, `App\Support\WebApi\FrontendUrl` | [`POST /checkout/store`](../API-DESIGN/API-CURRENT.md#api-071) |
| [private function formatAddress($user): ?string ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L235) | Format alamat user | — | — |
| [private function formatUserAddress($address): string ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L260) | Memformat user address. Perilaku rinci ada pada sumber metode. | — | — |
| [private function validateCartItemsStock($cartItems): ?string ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L271) | Memvalidasi cart items stock. Perilaku rinci ada pada sumber metode. | — | — |
| [private function availableMemberVouchers(int $userId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L296) | Aksi internal `availableMemberVouchers`. Perilaku rinci ada pada sumber metode. | `App\Models\UserRewardRedemption` | — |
| [private function resolveMemberVoucher(int $userId, ?string $voucherCode): ?\App\Models\UserRewardRedemption ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L308) | Menentukan member voucher. Perilaku rinci ada pada sumber metode. | `App\Models\UserRewardRedemption` | — |
| [private function calculateVoucherDiscount(\App\Models\UserRewardRedemption $voucher, float $subtotalProduk, float $totalOngkir): float ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/CheckOutController.php#L324) | Menghitung voucher discount. Perilaku rinci ada pada sumber metode. | — | — |

### App / Http / Controllers / Customer / OrderReviewController

Class `OrderReviewController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L13)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function store(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L18) | Store a new review | `App\Models\OrderItem`, `App\Models\OrderReview` | [`POST /order-reviews`](../API-DESIGN/API-CURRENT.md#api-088) |
| [public function show($orderItemId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L73) | Get review by order_item_id | `App\Models\OrderReview` | [`GET /order-reviews/{orderItemId}`](../API-DESIGN/API-CURRENT.md#api-089) |
| [private function updateProductRating($productId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/OrderReviewController.php#L110) | Update product rating average | `App\Models\OrderReview`, `App\Models\Produk` | — |

### App / Http / Controllers / Customer / PaymentController

Class `PaymentController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L15)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L21) | Tampilkan halaman payment/transaksi | `App\Support\WebApi\FrontendUrl` | [`GET /payment`](../API-DESIGN/API-CURRENT.md#api-091) |
| [public function store(\Illuminate\Http\Request $request, \App\Services\OrderService $orderService, \App\Services\ProofMedia $media) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L45) | Proses pembayaran dan simpan transaksi ke database | `App\Support\WebApi\FrontendUrl` | [`POST /payment/store`](../API-DESIGN/API-CURRENT.md#api-092) |
| [public function success($orderId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PaymentController.php#L100) | Halaman sukses setelah transaksi | `App\Support\WebApi\FrontendUrl`, `App\Models\Order` | [`GET /transaction/success/{orderId}`](../API-DESIGN/API-CURRENT.md#api-116) |

### App / Http / Controllers / Customer / PurchaseHistoryController

Class `PurchaseHistoryController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/PurchaseHistoryController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PurchaseHistoryController.php#L16)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public static function getHistoryData() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PurchaseHistoryController.php#L22) | Get purchase history data for authenticated user | `App\Models\OrderItem`, `App\Support\AssetUrl`, `App\Models\ProductReturn` | — |
| [public function confirmArrived(\App\Models\Order $order) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/PurchaseHistoryController.php#L98) | Menangani `POST /orders/{order}/confirm-arrived`. | `App\Models\OrderStatusHistory`, `App\Models\Notification`, `App\Support\WebApi\FrontendUrl` | [`POST /orders/{order}/confirm-arrived`](../API-DESIGN/API-CURRENT.md#api-090) |

### App / Http / Controllers / Customer / ReturnController

Class `ReturnController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L15)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function create($orderItemId) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L20) | Show return form for specific order item | `App\Models\OrderItem`, `App\Support\WebApi\FrontendUrl`, `App\Models\ProductReturn` | [`GET /returns/create/{orderItemId}`](../API-DESIGN/API-CURRENT.md#api-108) |
| [public function store(\Illuminate\Http\Request $request, \App\Services\ProofMedia $media) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L52) | Store return request | `App\Models\OrderItem`, `App\Models\ProductReturn`, `App\Support\WebApi\FrontendUrl` | [`POST /returns`](../API-DESIGN/API-CURRENT.md#api-107) |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L109) | Show customer's return requests | `App\Models\ProductReturn` | [`GET /returns`](../API-DESIGN/API-CURRENT.md#api-106) |
| [public function cancel($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L124) | Cancel return request (only if still pending) | `App\Models\ProductReturn` | [`PATCH /returns/{id}/cancel`](../API-DESIGN/API-CURRENT.md#api-109) |
| [public function submitCourierProof(\Illuminate\Http\Request $request, \App\Services\ProofMedia $media, $id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ReturnController.php#L146) | Menangani `POST /returns/{id}/courier-proof`. | `App\Models\ProductReturn` | [`POST /returns/{id}/courier-proof`](../API-DESIGN/API-CURRENT.md#api-110) |

### App / Http / Controllers / Customer / ShoppingCardController

Class `ShoppingCardController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L15)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L20) | Tampilkan halaman keranjang belanja | `App\Support\WebApi\FrontendUrl`, `App\Models\ShoppingCard` | [`GET /cart`](../API-DESIGN/API-CURRENT.md#api-059) |
| [public function add(\App\Http\Requests\AddToCartRequest $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L45) | Tambah produk ke keranjang (AJAX) | `App\Models\Produk`, `App\Models\ShoppingCard` | [`POST /cart/add`](../API-DESIGN/API-CURRENT.md#api-060) |
| [public function update(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L99) | Update qty item di keranjang (AJAX) | `App\Models\ShoppingCard` | [`POST /cart/update`](../API-DESIGN/API-CURRENT.md#api-062) |
| [public function delete($id) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L169) | Hapus item dari keranjang (AJAX) | `App\Models\ShoppingCard` | [`DELETE /cart/{id}`](../API-DESIGN/API-CURRENT.md#api-063) |
| [public function checkout(\Illuminate\Http\Request $request) ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/ShoppingCardController.php#L201) | Proses checkout: Simpan item yang dipilih ke session | `App\Support\WebApi\FrontendUrl`, `App\Models\ShoppingCard` | [`POST /cart/checkout`](../API-DESIGN/API-CURRENT.md#api-061) |

### App / Http / Controllers / Customer / TransactionController

Class `TransactionController` mempunyai namespace `App\Http\Controllers\Customer`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Customer/TransactionController.php](../../../../Motifnesia-Server/app/Http/Controllers/Customer/TransactionController.php#L6)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/TransactionController.php#L11) | Tampilkan halaman konfirmasi checkout (sebelum pembayaran final). | — | — |
| [public function showPaymentConfirmation() ](../../../../Motifnesia-Server/app/Http/Controllers/Customer/TransactionController.php#L34) | Tampilkan halaman konfirmasi pembayaran (setelah memilih metode bayar, seperti GoPay). | — | — |

## Controller Supplier

### App / Http / Controllers / Supplier / ProcurementController

Class `ProcurementController` mempunyai namespace `App\Http\Controllers\Supplier`. Turunan `App\Http\Controllers\Controller`. [Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L11)

| Method dan parameter | Tanggung jawab | Dependensi aplikasi | Endpoint v1 |
| --- | --- | --- | --- |
| [public function index() ](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L13) | Menyusun data untuk `supplier.procurements.index`. | `App\Models\StockProcurement` | [`GET /supplier/procurements`](../API-DESIGN/API-CURRENT.md#api-113) |
| [public function show(\App\Models\StockProcurement $procurement) ](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L29) | Menyusun data untuk `supplier.procurements.show`. | `App\Models\StockProcurement` | [`GET /supplier/procurements/{procurement}`](../API-DESIGN/API-CURRENT.md#api-114) |
| [public function updateStatus(\Illuminate\Http\Request $request, \App\Models\StockProcurement $procurement) ](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L43) | Menangani `POST /supplier/procurements/{procurement}/status`. | `App\Models\StockProcurement` | [`POST /supplier/procurements/{procurement}/status`](../API-DESIGN/API-CURRENT.md#api-115) |
| [private function currentSupplier(): \App\Models\Supplier ](../../../../Motifnesia-Server/app/Http/Controllers/Supplier/ProcurementController.php#L74) | Aksi internal `currentSupplier`. Perilaku rinci ada pada sumber metode. | `App\Models\Supplier` | — |
