import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/search_box.dart';
import 'package:motifnesia_mobile/views/admin/components/stock_balance_card.dart';

class StockOpnamePage extends ApiPage {
  const StockOpnamePage(super.arguments, {super.key});

  @override
  ApiPageState<StockOpnamePage> createState() => _StockOpnamePageState();
}

class _StockOpnamePageState extends ApiPageState<StockOpnamePage> {
  @override
  Widget buildContent() {
    final opnames = records(data['opnames']);
    final term = (query['search'] ?? '').toLowerCase();
    final matrix = records(data['matrix']).where((row) {
      final product = asMap(row['product']);
      return productName(product).toLowerCase().contains(term) ||
          text(product['sku']).toLowerCase().contains(term);
    }).toList();
    return StackGroup([
      const PageHeading('Sesuaikan stok sistem dengan stok gudang'),
      SearchBox(
        initial: query['search'] ?? '',
        onSearch: (value) => setState(() => query['search'] = value),
      ),
      if (matrix.isEmpty) emptyMessage('Produk belum ditemukan.'),
      for (final row in matrix)
        StockBalanceCard(
          row: row,
          onAdjust: (size) => prompt(
            'Stock opname · $size',
            '/admin/stock-opname/adjust',
            const [
              FormFieldSpec(
                'note',
                'Catatan penyesuaian',
                kind: FieldKind.multiline,
                required: false,
              ),
            ],
            extra: {'produk_id': idOf(asMap(row['product'])), 'ukuran': size},
          ),
        ),
      const PageHeading('Riwayat opname'),
      if (opnames.isEmpty) emptyMessage('Belum ada stock opname.'),
      for (final item in opnames)
        Block(
          child: StackGroup([
            PageHeading(
              text(item['opname_number']),
              subtitle: productName(asMap(item['produk'])),
            ),
            detailLine('Ukuran', item['ukuran']),
            detailLine('Sebelum', item['system_stock_before']),
            detailLine('Setelah', item['system_stock_after']),
            detailLine('Selisih', item['difference']),
            detailLine('Tanggal', date(item['created_at'])),
          ], gap: 5),
        ),
      pagination(data['opnames']),
    ]);
  }
}
