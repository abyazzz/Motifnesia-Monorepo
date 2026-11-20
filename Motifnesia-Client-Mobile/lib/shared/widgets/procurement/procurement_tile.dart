import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class ProcurementTile extends StatelessWidget {
  const ProcurementTile({
    super.key,
    required this.procurement,
    required this.onTap,
    this.showSupplier = false,
  });
  final Json procurement;
  final VoidCallback onTap;
  final bool showSupplier;

  @override
  Widget build(BuildContext context) => Block(
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(text(procurement['procurement_number'])),
      subtitle: Text(
        [
          if (showSupplier)
            text(asMap(procurement['supplier'])['name'], 'Supplier'),
          '${whole(procurement['total_qty'])} pcs',
          text(procurement['status_label']),
          date(procurement['created_at']),
        ].join(' · '),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}
