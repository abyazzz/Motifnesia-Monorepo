import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class SalesReportPage extends ApiPage {
  const SalesReportPage(super.arguments, {super.key});

  @override
  ApiPageState<SalesReportPage> createState() => _SalesReportPageState();
}

class _SalesReportPageState extends ApiPageState<SalesReportPage> {
  @override
  Widget buildContent() {
    final chart = records(data['chartData']);
    final max = chart.fold<num>(
      0,
      (peak, point) =>
          number(point['total']) > peak ? number(point['total']) : peak,
    );
    final period = query['period'] ?? text(data['currentPeriod'], '30');
    return StackGroup([
      filter('Periode laporan', 'period', const {
        '30': '30 hari terakhir',
        'today': 'Hari ini',
        '7': '7 hari terakhir',
        'month': 'Bulan ini',
      }),
      FilledButton.icon(
        onPressed: () async {
          try {
            final bytes = await api.download(
              '/admin/sales-report/export?period=${Uri.encodeQueryComponent(period)}',
            );
            if (mounted)
              await FilePicker.platform.saveFile(
                fileName: 'laporan-penjualan-motifnesia.csv',
                type: FileType.custom,
                allowedExtensions: const ['csv'],
                bytes: bytes,
              );
          } on Exception catch (error) {
            feedback(
              error is ApiFailure ? error.message : 'Gagal menyimpan laporan.',
            );
          }
        },
        icon: const Icon(Icons.file_download_outlined),
        label: const Text('Unduh laporan CSV'),
      ),
      metrics(context, {
        'Pendapatan': money(data['totalRevenue']),
        'Pesanan': data['totalOrders'],
        'Produk terjual': data['totalProductsSold'],
        'Rata-rata pesanan': money(data['averageOrderValue']),
        'Diskon voucher': money(data['voucherDiscountTotal']),
        'Pesanan member': data['memberOrders'],
        'Member aktif': data['activeMembers'],
        'Voucher ditukar': data['vouchersRedeemed'],
        'Poin diperoleh': data['pointsEarned'],
        'Poin ditukar': data['pointsRedeemed'],
      }),
      if (chart.isNotEmpty)
        Block(
          child: StackGroup([
            const PageHeading('Penjualan harian'),
            for (final point in chart)
              StackGroup([
                detailLine(text(point['date']), money(point['total'])),
                LinearProgressIndicator(
                  value: max == 0
                      ? 0
                      : (number(point['total']) / max).toDouble(),
                ),
              ], gap: 2),
          ], gap: 8),
        ),
      const PageHeading('Produk terlaris'),
      if (asList(data['topProducts']).isEmpty)
        emptyMessage('Belum ada penjualan pada periode ini.'),
      for (final item in records(data['topProducts']))
        Block(
          child: StackGroup([
            PageHeading(productName(asMap(item['produk']))),
            detailLine('Terjual', item['total_sold']),
            detailLine('Pendapatan', money(item['total_revenue'])),
          ]),
        ),
      const PageHeading('Transaksi terverifikasi'),
      for (final order in records(data['orders']))
        Block(
          child: StackGroup([
            PageHeading(
              text(order['order_number']),
              subtitle: date(order['created_at']),
            ),
            detailLine(
              'Pelanggan',
              text(
                asMap(order['user'])['full_name'],
                text(asMap(order['user'])['name']),
              ),
            ),
            detailLine(
              'Pembayaran',
              asMap(order['metodePembayaran'])['nama_pembayaran'],
            ),
            detailLine('Total', money(order['total_bayar'])),
            if (number(order['voucher_discount']) > 0)
              detailLine(
                text(order['voucher_code'], 'Voucher'),
                money(order['voucher_discount']),
              ),
          ], gap: 5),
        ),
    ]);
  }
}
