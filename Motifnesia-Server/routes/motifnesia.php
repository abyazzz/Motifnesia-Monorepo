<?php

use App\Http\Controllers\Admin\AdminProductController;
use App\Http\Controllers\Admin\ChatController as AdminChatController;
use App\Http\Controllers\Admin\CustomerController;
use App\Http\Controllers\Admin\MembershipController as AdminMembershipController;
use App\Http\Controllers\Admin\NotificationController as AdminNotificationController;
use App\Http\Controllers\Admin\OrderStatusController;
use App\Http\Controllers\Admin\ProductReviewController;
use App\Http\Controllers\Admin\ReportController;
use App\Http\Controllers\Admin\ReturnController as AdminReturnController;
use App\Http\Controllers\Admin\StaticContentController;
use App\Http\Controllers\Admin\StockOpnameController;
use App\Http\Controllers\Admin\StockProcurementController;
use App\Http\Controllers\Admin\SupplierController;
use App\Http\Controllers\Admin\WarehouseController;
use App\Http\Controllers\Api\WebAuthController;
use App\Http\Controllers\Auth\UserController;
use App\Http\Controllers\Customer\ChatController as CustomerChatController;
use App\Http\Controllers\Customer\CheckOutController;
use App\Http\Controllers\Customer\CustomerProductController;
use App\Http\Controllers\Customer\MembershipController as CustomerMembershipController;
use App\Http\Controllers\Customer\NotificationController as CustomerNotificationController;
use App\Http\Controllers\Customer\OrderReviewController;
use App\Http\Controllers\Customer\PaymentController;
use App\Http\Controllers\Customer\ProductFavoriteController;
use App\Http\Controllers\Customer\PurchaseHistoryController;
use App\Http\Controllers\Customer\ReturnController as CustomerReturnController;
use App\Http\Controllers\Customer\ReviewController;
use App\Http\Controllers\Customer\ShoppingCardController;
use App\Http\Controllers\Customer\UserAddressController;
use App\Http\Controllers\Customer\UserProfileController;
use App\Http\Controllers\ProofController;
use App\Http\Controllers\Supplier\ProcurementController;

// Named API routes used by the web client.
return [
    ['admin.orders.payment.proof', 'GET', 'admin/order-status/{order}/payment-proof', [ProofController::class, 'payment']],
    ['admin.returns.proof', 'GET', 'admin/returns/{return}/proof/{kind}', [ProofController::class, 'adminReturn']],
    ['customer.returns.proof', 'GET', 'returns/{return}/proof/{kind}', [ProofController::class, 'customerReturn']],
    ['admin.customers.index', 'GET', 'admin/customers', [CustomerController::class, 'index']],
    ['admin.customers.destroy', 'DELETE', 'admin/customers/{id}', [CustomerController::class, 'destroy']],
    ['admin.daftar-produk', 'GET', 'admin/daftar-produk', [AdminProductController::class, 'index']],
    ['admin.konten.index', 'GET', 'admin/konten', [StaticContentController::class, 'index']],
    ['admin.konten.slides.create', 'POST', 'admin/konten/slides/create', [StaticContentController::class, 'storeSlide']],
    ['admin.konten.slides.delete', 'POST', 'admin/konten/slides/{id}/delete', [StaticContentController::class, 'deleteSlide']],
    ['admin.konten.slides.update', 'POST', 'admin/konten/slides/{id}/update', [StaticContentController::class, 'updateSlide']],
    ['admin.', 'POST', 'admin/konten/slideshow', [StaticContentController::class, 'updateSlideshow']],
    ['admin.chat.index', 'GET', 'admin/live-chat', [AdminChatController::class, 'index']],
    ['admin.chat.list', 'GET', 'admin/live-chat/list', [AdminChatController::class, 'getChatList']],
    ['admin.chat.send', 'POST', 'admin/live-chat/send', [AdminChatController::class, 'sendMessage']],
    ['admin.chat.messages', 'GET', 'admin/live-chat/{chatId}/messages', [AdminChatController::class, 'getNewMessages']],
    ['admin.membership-broadcast.index', 'GET', 'admin/membership-broadcast', [AdminMembershipController::class, 'broadcastForm']],
    ['admin.membership-broadcast.store', 'POST', 'admin/membership-broadcast', [AdminMembershipController::class, 'broadcast']],
    ['admin.membership-rewards.index', 'GET', 'admin/membership-rewards', [AdminMembershipController::class, 'rewards']],
    ['admin.membership-rewards.store', 'POST', 'admin/membership-rewards', [AdminMembershipController::class, 'storeReward']],
    ['admin.membership-rewards.create', 'GET', 'admin/membership-rewards/create', [AdminMembershipController::class, 'createReward']],
    ['admin.membership-rewards.update', 'PUT', 'admin/membership-rewards/{id}', [AdminMembershipController::class, 'updateReward']],
    ['admin.membership-rewards.destroy', 'DELETE', 'admin/membership-rewards/{id}', [AdminMembershipController::class, 'destroyReward']],
    ['admin.membership-rewards.edit', 'GET', 'admin/membership-rewards/{id}/edit', [AdminMembershipController::class, 'editReward']],
    ['admin.memberships.index', 'GET', 'admin/memberships', [AdminMembershipController::class, 'index']],
    ['admin.memberships.points', 'POST', 'admin/memberships/{id}/points', [AdminMembershipController::class, 'adjustPoints']],
    ['admin.memberships.status', 'POST', 'admin/memberships/{id}/status', [AdminMembershipController::class, 'updateMemberStatus']],
    ['admin.notifications.index', 'GET', 'admin/notifications', [AdminNotificationController::class, 'index']],
    ['admin.notifications.clearRead', 'POST', 'admin/notifications/clear-read', [AdminNotificationController::class, 'clearRead']],
    ['admin.notifications.markAllRead', 'POST', 'admin/notifications/mark-all-read', [AdminNotificationController::class, 'markAllRead']],
    ['admin.notifications.destroy', 'DELETE', 'admin/notifications/{id}', [AdminNotificationController::class, 'destroy']],
    ['admin.notifications.toggleRead', 'POST', 'admin/notifications/{id}/toggle-read', [AdminNotificationController::class, 'toggleRead']],
    ['admin.orders.status', 'GET', 'admin/order-status', [OrderStatusController::class, 'index']],
    ['admin.orders.payment.update', 'POST', 'admin/order-status/{id}/payment', [OrderStatusController::class, 'updatePaymentStatus']],
    ['admin.orders.status.update', 'POST', 'admin/order-status/{id}/update', [OrderStatusController::class, 'updateStatus']],
    ['admin.product.management.index', 'GET', 'admin/product-management', [AdminProductController::class, 'manage']],
    ['admin.reviews.index', 'GET', 'admin/product-reviews', [ProductReviewController::class, 'index']],
    ['admin.reviews.show', 'GET', 'admin/product-reviews/{id}', [ProductReviewController::class, 'show']],
    ['admin.reviews.moderate', 'POST', 'admin/product-reviews/{id}/moderate', [ProductReviewController::class, 'moderate']],
    ['admin.products.create', 'GET|POST', 'admin/products/create', [AdminProductController::class, 'createOrStore']],
    ['admin.products.delete', 'POST', 'admin/products/{id}/delete', [AdminProductController::class, 'destroy']],
    ['admin.products.update', 'POST', 'admin/products/{id}/update', [AdminProductController::class, 'update']],
    ['admin.returns.index', 'GET', 'admin/returns', [AdminReturnController::class, 'index']],
    ['admin.returns.destroy', 'DELETE', 'admin/returns/{id}', [AdminReturnController::class, 'destroy']],
    ['admin.returns.updateStatus', 'POST', 'admin/returns/{id}/update-status', [AdminReturnController::class, 'updateStatus']],
    ['admin.reports.sales', 'GET', 'admin/sales-report', [ReportController::class, 'index']],
    ['admin.reports.export', 'GET', 'admin/sales-report/export', [ReportController::class, 'export']],
    ['admin.stock-opname.index', 'GET', 'admin/stock-opname', [StockOpnameController::class, 'index']],
    ['admin.stock-opname.adjust', 'POST', 'admin/stock-opname/adjust', [StockOpnameController::class, 'adjust']],
    ['admin.stock-procurements.index', 'GET', 'admin/stock-procurements', [StockProcurementController::class, 'index']],
    ['admin.stock-procurements.store', 'POST', 'admin/stock-procurements', [StockProcurementController::class, 'store']],
    ['admin.stock-procurements.create', 'GET', 'admin/stock-procurements/create', [StockProcurementController::class, 'create']],
    ['admin.stock-procurements.show', 'GET', 'admin/stock-procurements/{stockProcurement}', [StockProcurementController::class, 'show']],
    ['admin.stock-procurements.apply-stock', 'POST', 'admin/stock-procurements/{stockProcurement}/apply-stock', [StockProcurementController::class, 'applyStock']],
    ['admin.stock-procurements.confirm-arrived', 'POST', 'admin/stock-procurements/{stockProcurement}/confirm-arrived', [StockProcurementController::class, 'confirmArrived']],
    ['admin.suppliers.index', 'GET', 'admin/suppliers', [SupplierController::class, 'index']],
    ['admin.suppliers.store', 'POST', 'admin/suppliers', [SupplierController::class, 'store']],
    ['admin.suppliers.update', 'PUT', 'admin/suppliers/{supplier}', [SupplierController::class, 'update']],
    ['admin.suppliers.destroy', 'DELETE', 'admin/suppliers/{supplier}', [SupplierController::class, 'destroy']],
    ['admin.warehouse.index', 'GET', 'admin/warehouse', [WarehouseController::class, 'index']],
    ['customer.cart.index', 'GET', 'cart', [ShoppingCardController::class, 'index']],
    ['customer.cart.add', 'POST', 'cart/add', [ShoppingCardController::class, 'add']],
    ['customer.cart.checkout', 'POST', 'cart/checkout', [ShoppingCardController::class, 'checkout']],
    ['customer.cart.update', 'POST', 'cart/update', [ShoppingCardController::class, 'update']],
    ['customer.cart.delete', 'DELETE', 'cart/{id}', [ShoppingCardController::class, 'delete']],
    ['customer.chat.index', 'GET', 'chat', [CustomerChatController::class, 'index']],
    ['customer.chat.getOrCreate', 'POST', 'chat/get-or-create', [CustomerChatController::class, 'getOrCreateChat']],
    ['customer.chat.askProduct', 'POST', 'chat/product/{productId}/ask', [CustomerChatController::class, 'askProduct']],
    ['customer.chat.send', 'POST', 'chat/send', [CustomerChatController::class, 'sendMessage']],
    ['customer.chat.close', 'POST', 'chat/{chatId}/close', [CustomerChatController::class, 'closeChat']],
    ['customer.chat.messages', 'GET', 'chat/{chatId}/messages', [CustomerChatController::class, 'getNewMessages']],
    ['customer.checkout.index', 'GET', 'checkout', [CheckOutController::class, 'index']],
    ['customer.checkout.store', 'POST', 'checkout/store', [CheckOutController::class, 'store']],
    ['customer.favorites.index', 'GET', 'favorites', [ProductFavoriteController::class, 'index']],
    ['customer.favorites.store', 'POST', 'favorites/store', [ProductFavoriteController::class, 'store']],
    ['customer.favorites.destroy', 'DELETE', 'favorites/{id}', [ProductFavoriteController::class, 'destroy']],
    ['customer.favorites.addToCart', 'POST', 'favorites/{id}/add-to-cart', [ProductFavoriteController::class, 'addToCart']],
    ['auth.doForgot', 'POST', 'forgot', [UserController::class, 'doForgot']],
    ['customer.home', 'GET', 'homePage', [CustomerProductController::class, 'index']],
    ['auth.doLogin', 'POST', 'login', [WebAuthController::class, 'login']],
    ['auth.logout', 'POST', 'logout', [WebAuthController::class, 'logout']],
    ['customer.membership.index', 'GET', 'membership', [CustomerMembershipController::class, 'index']],
    ['customer.membership.history', 'GET', 'membership/history', [CustomerMembershipController::class, 'history']],
    ['customer.membership.redeem', 'POST', 'membership/redeem/{reward}', [CustomerMembershipController::class, 'redeem']],
    ['customer.membership.register', 'POST', 'membership/register', [CustomerMembershipController::class, 'register']],
    ['customer.membership.vouchers', 'GET', 'membership/vouchers', [CustomerMembershipController::class, 'myVouchers']],
    ['customer.notifications.index', 'GET', 'notifications', [CustomerNotificationController::class, 'index']],
    ['customer.notifications.markAllRead', 'POST', 'notifications/mark-all-read', [CustomerNotificationController::class, 'markAllAsRead']],
    ['customer.notifications.markRead', 'POST', 'notifications/{id}/read', [CustomerNotificationController::class, 'markAsRead']],
    ['customer.order.reviews.store', 'POST', 'order-reviews', [OrderReviewController::class, 'store']],
    ['customer.order.reviews.show', 'GET', 'order-reviews/{orderItemId}', [OrderReviewController::class, 'show']],
    ['customer.orders.confirmArrived', 'POST', 'orders/{order}/confirm-arrived', [PurchaseHistoryController::class, 'confirmArrived']],
    ['customer.payment.index', 'GET', 'payment', [PaymentController::class, 'index']],
    ['customer.payment.store', 'POST', 'payment/store', [PaymentController::class, 'store']],
    ['customer.product.reviews.store', 'POST', 'product-reviews', [ReviewController::class, 'store']],
    ['customer.product.reviews.update', 'PUT', 'product-reviews/{id}', [ReviewController::class, 'update']],
    ['customer.product.reviews.destroy', 'DELETE', 'product-reviews/{id}', [ReviewController::class, 'destroy']],
    ['customer.product.detail', 'GET', 'products/{id}', [CustomerProductController::class, 'show']],
    ['customer.products.reviews.index', 'GET', 'products/{id}/reviews', [ReviewController::class, 'index']],
    ['customer.profile.index', 'GET', 'profile', [UserProfileController::class, 'index']],
    ['customer.profile.addresses.store', 'POST', 'profile/addresses', [UserAddressController::class, 'store']],
    ['customer.profile.addresses.destroy', 'DELETE', 'profile/addresses/{id}', [UserAddressController::class, 'destroy']],
    ['customer.profile.addresses.setPrimary', 'POST', 'profile/addresses/{id}/set-primary', [UserAddressController::class, 'setPrimary']],
    ['customer.profile.addresses.update', 'POST', 'profile/addresses/{id}/update', [UserAddressController::class, 'update']],
    ['customer.profile.edit', 'GET', 'profile/edit', [UserProfileController::class, 'edit']],
    ['customer.profile.update', 'POST', 'profile/edit', [UserProfileController::class, 'update']],
    ['auth.doRegister', 'POST', 'register', [UserController::class, 'doRegister']],
    ['customer.returns.index', 'GET', 'returns', [CustomerReturnController::class, 'index']],
    ['customer.returns.store', 'POST', 'returns', [CustomerReturnController::class, 'store']],
    ['customer.returns.create', 'GET', 'returns/create/{orderItemId}', [CustomerReturnController::class, 'create']],
    ['customer.returns.cancel', 'PATCH', 'returns/{id}/cancel', [CustomerReturnController::class, 'cancel']],
    ['customer.returns.courierProof', 'POST', 'returns/{id}/courier-proof', [CustomerReturnController::class, 'submitCourierProof']],
    ['customer.search.live', 'GET', 'search/live', [CustomerProductController::class, 'liveSearch']],
    ['supplier.procurements.index', 'GET', 'supplier/procurements', [ProcurementController::class, 'index']],
    ['supplier.procurements.show', 'GET', 'supplier/procurements/{procurement}', [ProcurementController::class, 'show']],
    ['supplier.procurements.status', 'POST', 'supplier/procurements/{procurement}/status', [ProcurementController::class, 'updateStatus']],
    ['customer.transaction.success', 'GET', 'transaction/success/{orderId}', [PaymentController::class, 'success']],
];
