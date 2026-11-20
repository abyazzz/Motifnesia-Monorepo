import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/procurement/procurement_tile.dart';

class SupplierProcurementsPage extends ApiPage {
  const SupplierProcurementsPage(super.arguments, {super.key});

  @override
  ApiPageState<SupplierProcurementsPage> createState() =>
      _SupplierProcurementsPageState();
}

class _SupplierProcurementsPageState
    extends ApiPageState<SupplierProcurementsPage> {
  @override
  Widget buildContent() {
    final items = records(data['procurements']);
    return StackGroup([
      PageHeading(text(asMap(data['supplier'])['name'], 'Pengadaan supplier')),
      if (items.isEmpty) emptyMessage('Belum ada pengadaan.'),
      for (final item in items)
        ProcurementTile(
          procurement: item,
          onTap: () =>
              openPage(context, '/supplier/procurements/${idOf(item)}'),
        ),
      pagination(data['procurements']),
    ]);
  }
}
