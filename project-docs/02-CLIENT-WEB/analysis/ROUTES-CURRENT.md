# Route Web AS-IMPLEMENTED

Snapshot `route:list --json` termasuk route platform. Endpoint upstream yang cocok berasal dari metode dan path yang sama. Form auth GET memanggil viewer saat sampel sesi perlu diperiksa. Root dan alias menyelesaikan redirect. Middleware browser mengatur sesi dan CSRF, sedangkan API melakukan otorisasi domain. [Manifest Web](../../../Motifnesia-Client-Web/routes/motifnesia.php)

| Method | Path | Nama | Aksi lokal | Upstream v1 dengan path yang sama |
| --- | --- | --- | --- | --- |
| `GET&#124;HEAD` | `/` | home | MotifnesiaController | Lokal atau resolusi redirect |
| `GET&#124;HEAD` | `/admin/customers` | admin.customers.index | MotifnesiaController | [`GET /admin/customers`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-001) |
| `DELETE` | `/admin/customers/{id}` | admin.customers.destroy | MotifnesiaController | [`DELETE /admin/customers/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-002) |
| `GET&#124;HEAD` | `/admin/daftar-produk` | admin.daftar-produk | MotifnesiaController | [`GET /admin/daftar-produk`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-003) |
| `GET&#124;HEAD` | `/admin/konten` | admin.konten.index | MotifnesiaController | [`GET /admin/konten`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-004) |
| `POST` | `/admin/konten/slides/create` | admin.konten.slides.create | MotifnesiaController | [`POST /admin/konten/slides/create`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-005) |
| `POST` | `/admin/konten/slides/{id}/delete` | admin.konten.slides.delete | MotifnesiaController | [`POST /admin/konten/slides/{id}/delete`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-006) |
| `POST` | `/admin/konten/slides/{id}/update` | admin.konten.slides.update | MotifnesiaController | [`POST /admin/konten/slides/{id}/update`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-007) |
| `POST` | `/admin/konten/slideshow` | admin. | MotifnesiaController | [`POST /admin/konten/slideshow`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-008) |
| `GET&#124;HEAD` | `/admin/live-chat` | admin.chat.index | MotifnesiaController | [`GET /admin/live-chat`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-009) |
| `GET&#124;HEAD` | `/admin/live-chat/list` | admin.chat.list | MotifnesiaController | [`GET /admin/live-chat/list`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-010) |
| `POST` | `/admin/live-chat/send` | admin.chat.send | MotifnesiaController | [`POST /admin/live-chat/send`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-011) |
| `GET&#124;HEAD` | `/admin/live-chat/{chatId}/messages` | admin.chat.messages | MotifnesiaController | [`GET /admin/live-chat/{chatId}/messages`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-012) |
| `GET&#124;HEAD` | `/admin/membership-broadcast` | admin.membership-broadcast.index | MotifnesiaController | [`GET /admin/membership-broadcast`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-013) |
| `POST` | `/admin/membership-broadcast` | admin.membership-broadcast.store | MotifnesiaController | [`POST /admin/membership-broadcast`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-014) |
| `GET&#124;HEAD` | `/admin/membership-rewards` | admin.membership-rewards.index | MotifnesiaController | [`GET /admin/membership-rewards`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-015) |
| `POST` | `/admin/membership-rewards` | admin.membership-rewards.store | MotifnesiaController | [`POST /admin/membership-rewards`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-016) |
| `GET&#124;HEAD` | `/admin/membership-rewards/create` | admin.membership-rewards.create | MotifnesiaController | [`GET /admin/membership-rewards/create`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-017) |
| `PUT` | `/admin/membership-rewards/{id}` | admin.membership-rewards.update | MotifnesiaController | [`PUT /admin/membership-rewards/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-018) |
| `DELETE` | `/admin/membership-rewards/{id}` | admin.membership-rewards.destroy | MotifnesiaController | [`DELETE /admin/membership-rewards/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-019) |
| `GET&#124;HEAD` | `/admin/membership-rewards/{id}/edit` | admin.membership-rewards.edit | MotifnesiaController | [`GET /admin/membership-rewards/{id}/edit`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-020) |
| `GET&#124;HEAD` | `/admin/memberships` | admin.memberships.index | MotifnesiaController | [`GET /admin/memberships`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-021) |
| `POST` | `/admin/memberships/{id}/points` | admin.memberships.points | MotifnesiaController | [`POST /admin/memberships/{id}/points`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-022) |
| `POST` | `/admin/memberships/{id}/status` | admin.memberships.status | MotifnesiaController | [`POST /admin/memberships/{id}/status`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-023) |
| `GET&#124;HEAD` | `/admin/notifications` | admin.notifications.index | MotifnesiaController | [`GET /admin/notifications`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-024) |
| `POST` | `/admin/notifications/clear-read` | admin.notifications.clearRead | MotifnesiaController | [`POST /admin/notifications/clear-read`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-025) |
| `POST` | `/admin/notifications/mark-all-read` | admin.notifications.markAllRead | MotifnesiaController | [`POST /admin/notifications/mark-all-read`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-026) |
| `DELETE` | `/admin/notifications/{id}` | admin.notifications.destroy | MotifnesiaController | [`DELETE /admin/notifications/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-027) |
| `POST` | `/admin/notifications/{id}/toggle-read` | admin.notifications.toggleRead | MotifnesiaController | [`POST /admin/notifications/{id}/toggle-read`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-028) |
| `GET&#124;HEAD` | `/admin/order-status` | admin.orders.status | MotifnesiaController | [`GET /admin/order-status`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-029) |
| `POST` | `/admin/order-status/{id}/payment` | admin.orders.payment.update | MotifnesiaController | [`POST /admin/order-status/{id}/payment`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-030) |
| `POST` | `/admin/order-status/{id}/update` | admin.orders.status.update | MotifnesiaController | [`POST /admin/order-status/{id}/update`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-031) |
| `GET&#124;HEAD` | `/admin/order-status/{order}/payment-proof` | admin.orders.payment.proof | MotifnesiaController | [`GET /admin/order-status/{order}/payment-proof`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-032) |
| `GET&#124;HEAD` | `/admin/product-management` | admin.product.management.index | MotifnesiaController | [`GET /admin/product-management`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-033) |
| `GET&#124;HEAD` | `/admin/product-reviews` | admin.reviews.index | MotifnesiaController | [`GET /admin/product-reviews`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-034) |
| `GET&#124;HEAD` | `/admin/product-reviews/{id}` | admin.reviews.show | MotifnesiaController | [`GET /admin/product-reviews/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-035) |
| `POST` | `/admin/product-reviews/{id}/moderate` | admin.reviews.moderate | MotifnesiaController | [`POST /admin/product-reviews/{id}/moderate`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-036) |
| `GET&#124;POST&#124;HEAD` | `/admin/products/create` | admin.products.create | MotifnesiaController | [`GET&#124;POST /admin/products/create`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-037) |
| `POST` | `/admin/products/{id}/delete` | admin.products.delete | MotifnesiaController | [`POST /admin/products/{id}/delete`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-038) |
| `POST` | `/admin/products/{id}/update` | admin.products.update | MotifnesiaController | [`POST /admin/products/{id}/update`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-039) |
| `GET&#124;HEAD` | `/admin/returns` | admin.returns.index | MotifnesiaController | [`GET /admin/returns`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-040) |
| `DELETE` | `/admin/returns/{id}` | admin.returns.destroy | MotifnesiaController | [`DELETE /admin/returns/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-041) |
| `POST` | `/admin/returns/{id}/update-status` | admin.returns.updateStatus | MotifnesiaController | [`POST /admin/returns/{id}/update-status`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-042) |
| `GET&#124;HEAD` | `/admin/returns/{return}/proof/{kind}` | admin.returns.proof | MotifnesiaController | [`GET /admin/returns/{return}/proof/{kind}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-043) |
| `GET&#124;HEAD` | `/admin/sales-report` | admin.reports.sales | MotifnesiaController | [`GET /admin/sales-report`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-044) |
| `GET&#124;HEAD` | `/admin/sales-report/export` | admin.reports.export | MotifnesiaController | [`GET /admin/sales-report/export`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-045) |
| `GET&#124;HEAD` | `/admin/stock-opname` | admin.stock-opname.index | MotifnesiaController | [`GET /admin/stock-opname`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-046) |
| `POST` | `/admin/stock-opname/adjust` | admin.stock-opname.adjust | MotifnesiaController | [`POST /admin/stock-opname/adjust`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-047) |
| `GET&#124;HEAD` | `/admin/stock-procurements` | admin.stock-procurements.index | MotifnesiaController | [`GET /admin/stock-procurements`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-048) |
| `POST` | `/admin/stock-procurements` | admin.stock-procurements.store | MotifnesiaController | [`POST /admin/stock-procurements`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-049) |
| `GET&#124;HEAD` | `/admin/stock-procurements/create` | admin.stock-procurements.create | MotifnesiaController | [`GET /admin/stock-procurements/create`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-050) |
| `GET&#124;HEAD` | `/admin/stock-procurements/{stockProcurement}` | admin.stock-procurements.show | MotifnesiaController | [`GET /admin/stock-procurements/{stockProcurement}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-051) |
| `POST` | `/admin/stock-procurements/{stockProcurement}/apply-stock` | admin.stock-procurements.apply-stock | MotifnesiaController | [`POST /admin/stock-procurements/{stockProcurement}/apply-stock`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-052) |
| `POST` | `/admin/stock-procurements/{stockProcurement}/confirm-arrived` | admin.stock-procurements.confirm-arrived | MotifnesiaController | [`POST /admin/stock-procurements/{stockProcurement}/confirm-arrived`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-053) |
| `GET&#124;HEAD` | `/admin/suppliers` | admin.suppliers.index | MotifnesiaController | [`GET /admin/suppliers`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-054) |
| `POST` | `/admin/suppliers` | admin.suppliers.store | MotifnesiaController | [`POST /admin/suppliers`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-055) |
| `PUT` | `/admin/suppliers/{supplier}` | admin.suppliers.update | MotifnesiaController | [`PUT /admin/suppliers/{supplier}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-056) |
| `DELETE` | `/admin/suppliers/{supplier}` | admin.suppliers.destroy | MotifnesiaController | [`DELETE /admin/suppliers/{supplier}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-057) |
| `GET&#124;HEAD` | `/admin/warehouse` | admin.warehouse.index | MotifnesiaController | [`GET /admin/warehouse`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-058) |
| `GET&#124;HEAD` | `/cart` | customer.cart.index | MotifnesiaController | [`GET /cart`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-059) |
| `POST` | `/cart/add` | customer.cart.add | MotifnesiaController | [`POST /cart/add`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-060) |
| `POST` | `/cart/checkout` | customer.cart.checkout | MotifnesiaController | [`POST /cart/checkout`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-061) |
| `POST` | `/cart/update` | customer.cart.update | MotifnesiaController | [`POST /cart/update`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-062) |
| `DELETE` | `/cart/{id}` | customer.cart.delete | MotifnesiaController | [`DELETE /cart/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-063) |
| `GET&#124;HEAD` | `/chat` | customer.chat.index | MotifnesiaController | [`GET /chat`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-064) |
| `POST` | `/chat/get-or-create` | customer.chat.getOrCreate | MotifnesiaController | [`POST /chat/get-or-create`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-065) |
| `POST` | `/chat/product/{productId}/ask` | customer.chat.askProduct | MotifnesiaController | [`POST /chat/product/{productId}/ask`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-066) |
| `POST` | `/chat/send` | customer.chat.send | MotifnesiaController | [`POST /chat/send`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-067) |
| `POST` | `/chat/{chatId}/close` | customer.chat.close | MotifnesiaController | [`POST /chat/{chatId}/close`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-068) |
| `GET&#124;HEAD` | `/chat/{chatId}/messages` | customer.chat.messages | MotifnesiaController | [`GET /chat/{chatId}/messages`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-069) |
| `GET&#124;HEAD` | `/checkout` | customer.checkout.index | MotifnesiaController | [`GET /checkout`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-070) |
| `POST` | `/checkout/store` | customer.checkout.store | MotifnesiaController | [`POST /checkout/store`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-071) |
| `GET&#124;HEAD` | `/favorites` | customer.favorites.index | MotifnesiaController | [`GET /favorites`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-072) |
| `POST` | `/favorites/store` | customer.favorites.store | MotifnesiaController | [`POST /favorites/store`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-073) |
| `DELETE` | `/favorites/{id}` | customer.favorites.destroy | MotifnesiaController | [`DELETE /favorites/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-074) |
| `POST` | `/favorites/{id}/add-to-cart` | customer.favorites.addToCart | MotifnesiaController | [`POST /favorites/{id}/add-to-cart`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-075) |
| `GET&#124;HEAD` | `/forgot` | auth.forgot | MotifnesiaController | Lokal atau resolusi redirect |
| `POST` | `/forgot` | auth.doForgot | MotifnesiaController | [`POST /forgot`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-076) |
| `GET&#124;HEAD` | `/homePage` | customer.home | MotifnesiaController | [`GET /homePage`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-077) |
| `GET&#124;HEAD` | `/login` | auth.login | MotifnesiaController | Lokal atau resolusi redirect |
| `POST` | `/login` | auth.doLogin | MotifnesiaController | [`POST /login`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-078) |
| `POST` | `/logout` | auth.logout | MotifnesiaController | [`POST /logout`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-079) |
| `GET&#124;HEAD` | `/membership` | customer.membership.index | MotifnesiaController | [`GET /membership`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-080) |
| `GET&#124;HEAD` | `/membership/history` | customer.membership.history | MotifnesiaController | [`GET /membership/history`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-081) |
| `POST` | `/membership/redeem/{reward}` | customer.membership.redeem | MotifnesiaController | [`POST /membership/redeem/{reward}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-082) |
| `POST` | `/membership/register` | customer.membership.register | MotifnesiaController | [`POST /membership/register`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-083) |
| `GET&#124;HEAD` | `/membership/vouchers` | customer.membership.vouchers | MotifnesiaController | [`GET /membership/vouchers`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-084) |
| `GET&#124;HEAD` | `/notifications` | customer.notifications.index | MotifnesiaController | [`GET /notifications`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-085) |
| `POST` | `/notifications/mark-all-read` | customer.notifications.markAllRead | MotifnesiaController | [`POST /notifications/mark-all-read`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-086) |
| `POST` | `/notifications/{id}/read` | customer.notifications.markRead | MotifnesiaController | [`POST /notifications/{id}/read`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-087) |
| `POST` | `/order-reviews` | customer.order.reviews.store | MotifnesiaController | [`POST /order-reviews`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-088) |
| `GET&#124;HEAD` | `/order-reviews/{orderItemId}` | customer.order.reviews.show | MotifnesiaController | [`GET /order-reviews/{orderItemId}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-089) |
| `POST` | `/orders/{order}/confirm-arrived` | customer.orders.confirmArrived | MotifnesiaController | [`POST /orders/{order}/confirm-arrived`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-090) |
| `GET&#124;HEAD` | `/payment` | customer.payment.index | MotifnesiaController | [`GET /payment`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-091) |
| `POST` | `/payment/store` | customer.payment.store | MotifnesiaController | [`POST /payment/store`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-092) |
| `POST` | `/product-reviews` | customer.product.reviews.store | MotifnesiaController | [`POST /product-reviews`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-093) |
| `PUT` | `/product-reviews/{id}` | customer.product.reviews.update | MotifnesiaController | [`PUT /product-reviews/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-094) |
| `DELETE` | `/product-reviews/{id}` | customer.product.reviews.destroy | MotifnesiaController | [`DELETE /product-reviews/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-095) |
| `GET&#124;HEAD` | `/products/{id}` | customer.product.detail | MotifnesiaController | [`GET /products/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-096) |
| `GET&#124;HEAD` | `/products/{id}/reviews` | customer.products.reviews.index | MotifnesiaController | [`GET /products/{id}/reviews`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-097) |
| `GET&#124;HEAD` | `/profile` | customer.profile.index | MotifnesiaController | [`GET /profile`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-098) |
| `POST` | `/profile/addresses` | customer.profile.addresses.store | MotifnesiaController | [`POST /profile/addresses`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-099) |
| `DELETE` | `/profile/addresses/{id}` | customer.profile.addresses.destroy | MotifnesiaController | [`DELETE /profile/addresses/{id}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-100) |
| `POST` | `/profile/addresses/{id}/set-primary` | customer.profile.addresses.setPrimary | MotifnesiaController | [`POST /profile/addresses/{id}/set-primary`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-101) |
| `POST` | `/profile/addresses/{id}/update` | customer.profile.addresses.update | MotifnesiaController | [`POST /profile/addresses/{id}/update`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-102) |
| `GET&#124;HEAD` | `/profile/edit` | customer.profile.edit | MotifnesiaController | [`GET /profile/edit`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-103) |
| `POST` | `/profile/edit` | customer.profile.update | MotifnesiaController | [`POST /profile/edit`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-104) |
| `GET&#124;HEAD` | `/register` | auth.register | MotifnesiaController | Lokal atau resolusi redirect |
| `POST` | `/register` | auth.doRegister | MotifnesiaController | [`POST /register`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-105) |
| `GET&#124;HEAD` | `/returns` | customer.returns.index | MotifnesiaController | [`GET /returns`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-106) |
| `POST` | `/returns` | customer.returns.store | MotifnesiaController | [`POST /returns`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-107) |
| `GET&#124;HEAD` | `/returns/create/{orderItemId}` | customer.returns.create | MotifnesiaController | [`GET /returns/create/{orderItemId}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-108) |
| `PATCH` | `/returns/{id}/cancel` | customer.returns.cancel | MotifnesiaController | [`PATCH /returns/{id}/cancel`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-109) |
| `POST` | `/returns/{id}/courier-proof` | customer.returns.courierProof | MotifnesiaController | [`POST /returns/{id}/courier-proof`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-110) |
| `GET&#124;HEAD` | `/returns/{return}/proof/{kind}` | customer.returns.proof | MotifnesiaController | [`GET /returns/{return}/proof/{kind}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-111) |
| `GET&#124;HEAD` | `/search/live` | customer.search.live | MotifnesiaController | [`GET /search/live`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-112) |
| `GET&#124;HEAD` | `/storage/{path}` | storage.local | Closure | Lokal atau resolusi redirect |
| `PUT` | `/storage/{path}` | storage.local.upload | Closure | Lokal atau resolusi redirect |
| `GET&#124;HEAD` | `/supplier/procurements` | supplier.procurements.index | MotifnesiaController | [`GET /supplier/procurements`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-113) |
| `GET&#124;HEAD` | `/supplier/procurements/{procurement}` | supplier.procurements.show | MotifnesiaController | [`GET /supplier/procurements/{procurement}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-114) |
| `POST` | `/supplier/procurements/{procurement}/status` | supplier.procurements.status | MotifnesiaController | [`POST /supplier/procurements/{procurement}/status`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-115) |
| `GET&#124;HEAD` | `/transaction/success/{orderId}` | customer.transaction.success | MotifnesiaController | [`GET /transaction/success/{orderId}`](../../01-SERVER/design/API-DESIGN/API-CURRENT.md#api-116) |
| `GET&#124;HEAD` | `/up` | — | Closure | Lokal atau resolusi redirect |
