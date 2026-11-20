import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class StockBalanceCard extends StatelessWidget {
  const StockBalanceCard({super.key, required this.row, this.onAdjust});
  final Json row;
  final ValueChanged<String>? onAdjust;
  @override
  Widget build(BuildContext context) {
    final product = asMap(row['product']);
    final balances = asMap(row['sizes']);
    return Block(
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(productName(product)),
        subtitle: Text('SKU ${text(product['sku'], '—')}'),
        children: [
          for (final size in balances.entries)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Ukuran ${size.key}'),
              subtitle: Text(
                'Sistem ${whole(asMap(size.value)['system'])} · Gudang ${whole(asMap(size.value)['warehouse'])} · Selisih ${whole(asMap(size.value)['difference'])}',
              ),
              trailing: onAdjust != null
                  ? IconButton(
                      tooltip: 'Sesuaikan stok ukuran ${size.key}',
                      icon: const Icon(Icons.tune),
                      onPressed: () => onAdjust!(size.key),
                    )
                  : null,
            ),
        ],
      ),
    );
  }
}
