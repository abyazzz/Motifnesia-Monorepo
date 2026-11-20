import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/procurement/procurement_tile.dart';

class StockProcurementsPage extends ApiPage {
  const StockProcurementsPage(super.arguments, {super.key});

  @override
  ApiPageState<StockProcurementsPage> createState() =>
      _StockProcurementsPageState();
}

class _StockProcurementsPageState extends ApiPageState<StockProcurementsPage> {
  @override
  Widget buildContent() {
    final items = records(data['procurements']);
    final statuses = asMap(data['statusLabels']);
    final stats = asMap(data['stats']);
    return StackGroup([
      PageHeading(
        'Pengadaan stok',
        trailing: IconButton.filledTonal(
          tooltip: 'Buat pengadaan',
          onPressed: () =>
              openPage(context, '/admin/stock-procurements/create'),
          icon: const Icon(Icons.add),
        ),
      ),
      if (statuses.isNotEmpty)
        metrics(context, {
          for (final entry in statuses.entries)
            text(entry.value): stats[entry.key] ?? 0,
        }),
      filter('Status pengadaan', 'status', {
        'all': 'Semua status',
        for (final entry in statuses.entries) entry.key: text(entry.value),
      }),
      if (items.isEmpty) emptyMessage('Belum ada pengadaan.'),
      for (final item in items)
        ProcurementTile(
          procurement: item,
          showSupplier: true,
          onTap: () =>
              openPage(context, '/admin/stock-procurements/${idOf(item)}'),
        ),
      pagination(data['procurements']),
    ]);
  }
}
