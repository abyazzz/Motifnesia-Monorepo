import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/views/customer/pages/cart_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/catalog/catalog_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/catalog/product_detail_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/chat_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/checkout/checkout_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/checkout/order_receipt_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/checkout/payment_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/favorites_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/membership/membership_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/membership/points_history_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/membership/vouchers_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/notifications_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/profile/edit_profile_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/profile/profile_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/returns/create_return_page.dart';
import 'package:motifnesia_mobile/views/customer/pages/returns/returns_page.dart';

const customerRoutes = [
  AppRoute(
    '/homePage',
    'Koleksi Batik',
    Icons.storefront_outlined,
    CatalogPage.new,
  ),
  AppRoute(
    '/products/:id',
    'Detail Produk',
    Icons.checkroom_outlined,
    ProductDetailPage.new,
  ),
  AppRoute(
    '/cart',
    'Keranjang',
    Icons.shopping_bag_outlined,
    CartPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/favorites',
    'Favorit',
    Icons.favorite_border,
    FavoritesPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/checkout',
    'Checkout',
    Icons.receipt_long_outlined,
    CheckoutPage.new,
    role: 'customer',
    showInDrawer: false,
  ),
  AppRoute(
    '/payment',
    'Pembayaran',
    Icons.payment_outlined,
    PaymentPage.new,
    role: 'customer',
    showInDrawer: false,
  ),
  AppRoute(
    '/transaction/success/:id',
    'Ringkasan Pesanan',
    Icons.receipt_outlined,
    OrderReceiptPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/profile',
    'Akun Saya',
    Icons.person_outline,
    ProfilePage.new,
    role: 'customer',
  ),
  AppRoute(
    '/profile/edit',
    'Ubah Profil',
    Icons.edit_outlined,
    EditProfilePage.new,
    role: 'customer',
    showInDrawer: false,
  ),
  AppRoute(
    '/notifications',
    'Notifikasi',
    Icons.notifications_outlined,
    NotificationsPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/membership',
    'Membership',
    Icons.workspace_premium_outlined,
    MembershipPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/membership/history',
    'Riwayat Poin',
    Icons.history,
    PointsHistoryPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/membership/vouchers',
    'Voucher Saya',
    Icons.confirmation_num_outlined,
    VouchersPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/returns',
    'Retur Saya',
    Icons.assignment_return_outlined,
    ReturnsPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/returns/create/:id',
    'Ajukan Retur',
    Icons.assignment_return_outlined,
    CreateReturnPage.new,
    role: 'customer',
  ),
  AppRoute(
    '/chat',
    'Bantuan & Chat',
    Icons.chat_bubble_outline,
    CustomerChatPage.new,
    role: 'customer',
  ),
];
