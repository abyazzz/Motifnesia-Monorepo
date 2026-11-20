import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/search_box.dart';

class OrderStatusPage extends ApiPage {
  const OrderStatusPage(super.arguments, {super.key});

  @override
  ApiPageState<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends ApiPageState<OrderStatusPage> {
  @override
  Widget buildContent() {
    final delivery = records(data['deliveryStatuses']);
    final statuses = {
      for (final status in delivery) idOf(status): text(status['nama_status']),
    };
    final payment = {
      for (final entry in asMap(data['paymentStatuses']).entries)
        entry.key: text(entry.value),
    };
    final queryStatus = query['status'] ?? 'all';
    final term = (query['search'] ?? '').toLowerCase();
    final pending = text(
      data['pendingDeliveryStatusId'],
      statuses.keys.firstOrNull ?? '',
    );
    final orders = records(data['orders']).where((order) {
      final person = asMap(order['user']);
      final name = text(
        person['full_name'],
        text(person['name']),
      ).toLowerCase();
      return (queryStatus == 'all' ||
              text(order['delivery_status_id']) == queryStatus) &&
          (name.contains(term) ||
              text(order['alamat']).toLowerCase().contains(term) ||
              text(order['order_number']).toLowerCase().contains(term));
    }).toList();
    return StackGroup([
      SearchBox(
        initial: query['search'] ?? '',
        onSearch: (value) => setState(() => query['search'] = value),
      ),
      filter('Status pengiriman', 'status', {
        'all': 'Semua status',
        ...statuses,
      }),
      if (orders.isEmpty) emptyMessage('Belum ada pesanan pada filter ini.'),
      for (final order in orders)
        Block(
          child: StackGroup([
            PageHeading(
              text(order['order_number'], 'Pesanan #${idOf(order)}'),
              subtitle: date(order['created_at']),
            ),
            detailLine(
              'Pelanggan',
              text(
                asMap(order['user'])['full_name'],
                text(asMap(order['user'])['name']),
              ),
            ),
            detailLine('Alamat', order['alamat']),
            detailLine('Total', money(order['total_bayar'])),
            detailLine('Pembayaran', paymentLabel(order['payment_status'])),
            detailLine(
              'Pengiriman',
              asMap(order['deliveryStatus'])['nama_status'],
            ),
            if (text(order['payment_note']).isNotEmpty)
              detailLine('Catatan pembayaran', order['payment_note']),
            if (number(order['voucher_discount']) > 0)
              detailLine(
                text(order['voucher_code'], 'Voucher'),
                money(order['voucher_discount']),
              ),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: const Text('Item pesanan'),
              children: [
                for (final item in records(order['orderItems']))
                  detailLine(
                    '${productName(item)} · ${text(item['ukuran'])} × ${text(item['qty'])}',
                    money(item['subtotal']),
                  ),
              ],
            ),
            actionGroup([
              if (session.allows('is-finance')) ...[
                if (text(order['payment_proof']).isNotEmpty)
                  actionButton(
                    'Bukti pembayaran',
                    Icons.image_outlined,
                    () => openProof(
                      '/admin/order-status/${idOf(order)}/payment-proof',
                      'Bukti pembayaran',
                    ),
                  ),
                actionButton(
                  'Update pembayaran',
                  Icons.verified_outlined,
                  () => prompt(
                    'Verifikasi pembayaran',
                    '/admin/order-status/${idOf(order)}/payment',
                    [
                      FormFieldSpec(
                        'payment_status',
                        'Status pembayaran',
                        kind: FieldKind.choice,
                        options: payment,
                        initial: payment.containsKey(order['payment_status'])
                            ? order['payment_status']
                            : null,
                      ),
                      FormFieldSpec(
                        'payment_note',
                        'Catatan pembayaran',
                        kind: FieldKind.multiline,
                        initial: order['payment_note'],
                        required: false,
                      ),
                    ],
                    validate: (fields) =>
                        fields['payment_status'] == 'rejected' &&
                            text(fields['payment_note']).isEmpty
                        ? 'Catatan wajib diisi saat pembayaran ditolak.'
                        : null,
                  ),
                ),
              ],
              if (session.allows('is-kasir'))
                actionButton(
                  'Update pengiriman',
                  Icons.local_shipping_outlined,
                  order['payment_status'] != 'verified' &&
                          text(order['delivery_status_id']) == pending
                      ? null
                      : () => prompt(
                          'Status pengiriman',
                          '/admin/order-status/${idOf(order)}/update',
                          [
                            FormFieldSpec(
                              'delivery_status_id',
                              'Status pengiriman',
                              kind: FieldKind.choice,
                              options: order['payment_status'] == 'verified'
                                  ? statuses
                                  : {pending: statuses[pending] ?? 'Pending'},
                              initial: order['payment_status'] == 'verified'
                                  ? text(order['delivery_status_id'])
                                  : pending,
                            ),
                          ],
                        ),
                ),
            ]),
            if (session.allows('is-kasir') &&
                order['payment_status'] != 'verified')
              const Text(
                'Finance perlu memverifikasi pembayaran sebelum pengiriman dapat dilanjutkan.',
              ),
          ], gap: 6),
        ),
    ]);
  }
}
