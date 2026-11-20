import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/search_box.dart';

class CustomersPage extends ApiPage {
  const CustomersPage(super.arguments, {super.key});

  @override
  ApiPageState<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends ApiPageState<CustomersPage> {
  @override
  Widget buildContent() {
    final term = (query['search'] ?? '').toLowerCase();
    final customers = records(data['customers'])
        .where(
          (customer) => [
            customer['full_name'],
            customer['username'],
            customer['email'],
          ].any((item) => text(item).toLowerCase().contains(term)),
        )
        .toList();
    return StackGroup([
      SearchBox(
        initial: query['search'] ?? '',
        onSearch: (value) => setState(() => query['search'] = value),
      ),
      if (customers.isEmpty)
        emptyMessage('Belum ada pelanggan pada pencarian ini.'),
      for (final customer in customers)
        Block(
          child: StackGroup([
            PageHeading(
              text(customer['full_name']),
              subtitle: text(customer['email']),
              trailing: statusBadge(
                context,
                customer['account_status'] == 'active' ? 'Aktif' : 'Nonaktif',
              ),
            ),
            detailLine('Username', customer['username']),
            detailLine('Produk dibeli', customer['total_products']),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: const Text('Riwayat pesanan'),
              children: [
                for (final order in records(customer['orders'])) ...[
                  detailLine(
                    text(order['order_number']),
                    money(order['total_bayar']),
                  ),
                  for (final item in records(order['orderItems']))
                    detailLine(productName(item), '${text(item['qty'])} pcs'),
                  const Divider(),
                ],
              ],
            ),
            actionButton(
              customer['account_status'] == 'active'
                  ? 'Nonaktifkan'
                  : 'Aktifkan',
              Icons.manage_accounts_outlined,
              () => confirm(
                'Ubah status akun pelanggan ini?',
                '/admin/customers/${idOf(customer)}',
                method: 'DELETE',
              ),
            ),
          ]),
        ),
    ]);
  }
}
