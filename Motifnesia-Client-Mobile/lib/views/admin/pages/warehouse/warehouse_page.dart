import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/views/admin/components/procurement_actions.dart';
import 'package:motifnesia_mobile/views/admin/components/stock_balance_card.dart';

class WarehousePage extends ApiPage {
  const WarehousePage(super.arguments, {super.key});

  @override
  ApiPageState<WarehousePage> createState() => _WarehousePageState();
}

class _WarehousePageState extends ApiPageState<WarehousePage>
    with ProcurementActions<WarehousePage> {
  @override
  Widget buildContent() {
    final matrix = records(data['matrix']);
    final balances = [
      for (final row in matrix) ...asMap(row['sizes']).values.map(asMap),
    ];
    final ready = records(data['readyProcurements']);
    final movements = records(data['movements']);
    return StackGroup([
      metrics(context, {
        'Produk': matrix.length,
        'Stok sistem': balances.fold<int>(
          0,
          (sum, item) => sum + whole(item['system']),
        ),
        'Stok gudang': balances.fold<int>(
          0,
          (sum, item) => sum + whole(item['warehouse']),
        ),
        'Varian berbeda': balances
            .where((item) => whole(item['difference']) != 0)
            .length,
      }),
      const PageHeading('Stok per ukuran'),
      if (matrix.isEmpty) emptyMessage('Belum ada produk di gudang.'),
      for (final row in matrix) StockBalanceCard(row: row),
      const PageHeading('Pengadaan siap diproses'),
      if (ready.isEmpty) emptyMessage('Belum ada pengadaan untuk diproses.'),
      for (final procurement in ready)
        Block(
          child: StackGroup([
            PageHeading(
              text(procurement['procurement_number']),
              subtitle: text(procurement['status_label']),
            ),
            detailLine('Supplier', asMap(procurement['supplier'])['name']),
            actionButton(
              'Lihat detail',
              Icons.info_outline,
              () => openPage(
                context,
                '/admin/stock-procurements/${idOf(procurement)}',
              ),
            ),
            procurementActions(procurement),
          ]),
        ),
      const PageHeading('Mutasi stok terbaru'),
      if (movements.isEmpty) emptyMessage('Belum ada mutasi stok.'),
      for (final movement in movements)
        Block(
          child: StackGroup([
            PageHeading(
              productName(asMap(movement['produk'])),
              subtitle: date(movement['created_at']),
            ),
            detailLine('Ukuran', movement['ukuran']),
            detailLine('Perubahan stok', movement['qty_change']),
            detailLine(
              'Jenis',
              movement['movement_type'] == 'stock_opname'
                  ? 'Stock opname'
                  : 'Pengadaan',
            ),
            if (text(movement['note']).isNotEmpty)
              detailLine('Catatan', movement['note']),
          ], gap: 5),
        ),
    ]);
  }
}
