import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class OrderReceiptPage extends ApiPage {
  const OrderReceiptPage(super.arguments, {super.key});

  @override
  ApiPageState<OrderReceiptPage> createState() => _OrderReceiptPageState();
}

class _OrderReceiptPageState extends ApiPageState<OrderReceiptPage> {
  @override
  Widget buildContent() {
    final order = asMap(data['order']);
    final status = text(order['payment_status']);
    return StackGroup([
      Notice(
        icon: switch (status) {
          'verified' => Icons.verified_outlined,
          'rejected' || 'expired' => Icons.info_outline,
          _ => Icons.receipt_long_outlined,
        },
        title: status == 'waiting_verification'
            ? 'Bukti pembayaran terkirim'
            : 'Pembayaran ${paymentLabel(status)}',
        detail: status == 'waiting_verification'
            ? 'Pesanan akan diproses setelah bukti diverifikasi.'
            : null,
      ),
      Block(
        child: StackGroup([
          detailLine('Nomor pesanan', order['order_number']),
          detailLine(
            'Status pengiriman',
            asMap(order['deliveryStatus'])['nama_status'],
          ),
          detailLine('Total pembayaran', money(order['total_bayar'])),
          detailLine('Alamat', order['alamat']),
          for (final item in records(order['orderItems']))
            detailLine(
              '${productName(item)} × ${text(item['qty'])}',
              money(item['subtotal']),
            ),
        ]),
      ),
      FilledButton(
        onPressed: () => replaceStack(context, '/homePage'),
        child: const Text('Kembali ke koleksi'),
      ),
      actionButton(
        'Lihat riwayat belanja',
        Icons.history,
        () => openPage(context, '/profile'),
      ),
    ]);
  }
}
