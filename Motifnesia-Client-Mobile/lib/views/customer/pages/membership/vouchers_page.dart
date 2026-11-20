import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class VouchersPage extends ApiPage {
  const VouchersPage(super.arguments, {super.key});

  @override
  ApiPageState<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends ApiPageState<VouchersPage> {
  @override
  Widget buildContent() => StackGroup([
    if (asList(data['vouchers']).isEmpty) emptyMessage('Belum ada voucher.'),
    for (final voucher in records(data['vouchers']))
      Block(
        child: StackGroup([
          PageHeading(
            text(asMap(voucher['reward'])['title'], 'Voucher'),
            subtitle: text(asMap(voucher['reward'])['discount_label']),
          ),
          SelectableText(
            text(voucher['voucher_code']),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          detailLine('Status', switch (voucher['status']) {
            'active' => 'Aktif',
            'used' => 'Terpakai',
            _ => voucher['status'],
          }),
          detailLine('Ditukar pada', date(voucher['redeemed_at'])),
        ]),
      ),
    pagination(data['vouchers']),
  ]);
}
