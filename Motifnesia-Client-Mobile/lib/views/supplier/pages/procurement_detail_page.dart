import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/procurement/procurement_details.dart';

class SupplierProcurementDetailPage extends ApiPage {
  const SupplierProcurementDetailPage(super.arguments, {super.key});

  @override
  ApiPageState<SupplierProcurementDetailPage> createState() =>
      _SupplierProcurementDetailPageState();
}

class _SupplierProcurementDetailPageState
    extends ApiPageState<SupplierProcurementDetailPage> {
  @override
  Widget buildContent() {
    final procurement = asMap(data['procurement']);
    return ProcurementDetails(
      api: api,
      procurement: procurement,
      actions: _supplierActions(procurement),
    );
  }

  Widget _supplierActions(Json item) {
    final id = idOf(item);
    final status = item['status'];
    if (status == 'pending') {
      return FilledButton(
        onPressed: busy
            ? null
            : () => action(
                '/supplier/procurements/$id/status',
                fields: {'status': 'approved'},
              ),
        child: const Text('Setujui pengadaan'),
      );
    }
    if (status == 'approved') {
      return FilledButton(
        onPressed: busy
            ? null
            : () => action(
                '/supplier/procurements/$id/status',
                fields: {'status': 'in_delivery'},
              ),
        child: const Text('Barang diantar'),
      );
    }
    return const SizedBox.shrink();
  }
}
