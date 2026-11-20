import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/views/supplier/pages/procurement_detail_page.dart';
import 'package:motifnesia_mobile/views/supplier/pages/procurements_page.dart';

const supplierRoutes = [
  AppRoute(
    '/supplier/procurements',
    'Pengadaan Supplier',
    Icons.local_shipping_outlined,
    SupplierProcurementsPage.new,
    role: 'supplier',
  ),
  AppRoute(
    '/supplier/procurements/:id',
    'Detail Pengadaan',
    Icons.inventory_2_outlined,
    SupplierProcurementDetailPage.new,
    role: 'supplier',
  ),
];
