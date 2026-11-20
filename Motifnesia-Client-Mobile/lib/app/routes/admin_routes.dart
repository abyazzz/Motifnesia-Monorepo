import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/views/admin/pages/chat_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/content/slides_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/customers_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/members/create_reward_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/members/edit_reward_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/members/member_broadcast_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/members/members_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/members/rewards_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/notifications_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/orders/order_status_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/products/create_product_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/products/product_management_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/returns_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/reviews/product_review_detail_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/reviews/product_reviews_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/sales_report_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/stock_procurements/create_procurement_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/stock_procurements/stock_procurement_detail_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/stock_procurements/stock_procurements_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/suppliers/suppliers_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/warehouse/stock_opname_page.dart';
import 'package:motifnesia_mobile/views/admin/pages/warehouse/warehouse_page.dart';

const adminRoutes = [
  AppRoute(
    '/admin/product-management',
    'Manajemen Produk',
    Icons.inventory_2_outlined,
    ProductManagementPage.new,
    role: 'admin',
    ability: 'is-kasir',
  ),
  AppRoute(
    '/admin/products/create',
    'Tambah Produk',
    Icons.add_box_outlined,
    CreateProductPage.new,
    role: 'admin',
    ability: 'is-owner',
    showInDrawer: false,
  ),
  AppRoute(
    '/admin/order-status',
    'Status Pengiriman',
    Icons.local_shipping_outlined,
    OrderStatusPage.new,
    role: 'admin',
  ),
  AppRoute(
    '/admin/customers',
    'Daftar Pelanggan',
    Icons.groups_outlined,
    CustomersPage.new,
    role: 'admin',
    ability: 'is-owner',
  ),
  AppRoute(
    '/admin/returns',
    'Kelola Retur',
    Icons.assignment_return_outlined,
    AdminReturnsPage.new,
    role: 'admin',
    ability: 'is-kasir',
  ),
  AppRoute(
    '/admin/product-reviews',
    'Ulasan Produk',
    Icons.star_outline,
    ProductReviewsPage.new,
    role: 'admin',
    ability: 'is-kasir',
  ),
  AppRoute(
    '/admin/product-reviews/:id',
    'Detail Ulasan',
    Icons.reviews_outlined,
    ProductReviewDetailPage.new,
    role: 'admin',
    ability: 'is-kasir',
  ),
  AppRoute(
    '/admin/live-chat',
    'Live Chat Support',
    Icons.forum_outlined,
    AdminChatPage.new,
    role: 'admin',
    ability: 'is-kasir',
  ),
  AppRoute(
    '/admin/notifications',
    'Notifikasi Sistem',
    Icons.notifications_outlined,
    AdminNotificationsPage.new,
    role: 'admin',
  ),
  AppRoute(
    '/admin/konten',
    'Kelola Konten',
    Icons.view_carousel_outlined,
    SlidesPage.new,
    role: 'admin',
    ability: 'is-owner',
  ),
  AppRoute(
    '/admin/sales-report',
    'Laporan Penjualan',
    Icons.bar_chart,
    SalesReportPage.new,
    role: 'admin',
    ability: 'is-finance',
  ),
  AppRoute(
    '/admin/memberships',
    'Daftar Member',
    Icons.workspace_premium_outlined,
    MembersPage.new,
    role: 'admin',
    ability: 'is-owner',
  ),
  AppRoute(
    '/admin/membership-rewards',
    'Reward Membership',
    Icons.redeem_outlined,
    RewardsPage.new,
    role: 'admin',
    ability: 'is-owner',
  ),
  AppRoute(
    '/admin/membership-rewards/create',
    'Tambah Reward',
    Icons.add_box_outlined,
    CreateRewardPage.new,
    role: 'admin',
    ability: 'is-owner',
    showInDrawer: false,
  ),
  AppRoute(
    '/admin/membership-rewards/:id/edit',
    'Ubah Reward',
    Icons.edit_outlined,
    EditRewardPage.new,
    role: 'admin',
    ability: 'is-owner',
  ),
  AppRoute(
    '/admin/membership-broadcast',
    'Broadcast Member',
    Icons.campaign_outlined,
    MemberBroadcastPage.new,
    role: 'admin',
    ability: 'is-owner',
  ),
  AppRoute(
    '/admin/suppliers',
    'Supplier',
    Icons.business_outlined,
    SuppliersPage.new,
    role: 'admin',
    ability: 'is-owner',
  ),
  AppRoute(
    '/admin/stock-procurements',
    'Pengadaan Stok',
    Icons.receipt_long_outlined,
    StockProcurementsPage.new,
    role: 'admin',
    ability: 'is-gudang',
  ),
  AppRoute(
    '/admin/stock-procurements/create',
    'Buat Pengadaan',
    Icons.add_box_outlined,
    CreateProcurementPage.new,
    role: 'admin',
    ability: 'is-gudang',
    showInDrawer: false,
  ),
  AppRoute(
    '/admin/stock-procurements/:id',
    'Detail Pengadaan',
    Icons.inventory_2_outlined,
    StockProcurementDetailPage.new,
    role: 'admin',
    ability: 'is-gudang',
  ),
  AppRoute(
    '/admin/warehouse',
    'Gudang',
    Icons.warehouse_outlined,
    WarehousePage.new,
    role: 'admin',
    ability: 'is-gudang',
  ),
  AppRoute(
    '/admin/stock-opname',
    'Stock Opname',
    Icons.fact_check_outlined,
    StockOpnamePage.new,
    role: 'admin',
    ability: 'is-gudang',
  ),
];
