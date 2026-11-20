import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class PointsHistoryPage extends ApiPage {
  const PointsHistoryPage(super.arguments, {super.key});

  @override
  ApiPageState<PointsHistoryPage> createState() => _PointsHistoryPageState();
}

class _PointsHistoryPageState extends ApiPageState<PointsHistoryPage> {
  @override
  Widget buildContent() => StackGroup([
    metric(context, 'Saldo poin', asMap(data['user'])['reward_points']),
    if (asList(data['pointTransactions']).isEmpty)
      emptyMessage('Belum ada riwayat poin.'),
    for (final item in records(data['pointTransactions']))
      Block(
        child: StackGroup([
          PageHeading(
            text(item['description'], 'Transaksi poin'),
            subtitle: date(item['created_at']),
          ),
          detailLine('Poin', item['points']),
        ]),
      ),
    pagination(data['pointTransactions']),
  ]);
}
