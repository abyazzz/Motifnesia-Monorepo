import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/core/catalog/product_sizes.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class ProcurementDetails extends StatelessWidget {
  const ProcurementDetails({
    super.key,
    required this.api,
    required this.procurement,
    required this.actions,
  });
  final MotifnesiaApi api;
  final Json procurement;
  final Widget actions;

  @override
  Widget build(BuildContext context) {
    final supplier = asMap(procurement['supplier']);
    return StackGroup([
      Block(
        child: StackGroup([
          PageHeading(
            text(procurement['procurement_number']),
            subtitle: text(procurement['status_label']),
          ),
          detailLine('Supplier', supplier['name']),
          detailLine('Jumlah produk', '${whole(procurement['total_qty'])} pcs'),
          detailLine('Tanggal dibuat', date(procurement['created_at'])),
          if (text(procurement['note']).isNotEmpty)
            detailLine('Catatan', procurement['note']),
          if (procurement['approved_at'] != null)
            detailLine('Disetujui', date(procurement['approved_at'])),
          if (procurement['in_delivery_at'] != null)
            detailLine('Diantar', date(procurement['in_delivery_at'])),
          if (procurement['arrived_at'] != null)
            detailLine('Sampai', date(procurement['arrived_at'])),
          if (procurement['stock_applied_at'] != null)
            detailLine('Diterapkan', date(procurement['stock_applied_at'])),
          actions,
        ], gap: 6),
      ),
      const PageHeading('Item pengadaan'),
      for (final item in records(procurement['items']))
        Block(
          child: StackGroup([
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Photo(
                api,
                productImage(asMap(item['produk'])),
                width: 58,
                height: 58,
              ),
              title: Text(productName(asMap(item['produk']))),
              subtitle: Text('Total ${text(item['total_qty'])} pcs'),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 7,
              children: [
                for (final size in productSizes)
                  statusBadge(
                    context,
                    '$size · ${whole(asMap(item['size_quantities'])[size] ?? item['qty_${size.toLowerCase()}'])}',
                  ),
              ],
            ),
          ], gap: 6),
        ),
    ]);
  }
}
