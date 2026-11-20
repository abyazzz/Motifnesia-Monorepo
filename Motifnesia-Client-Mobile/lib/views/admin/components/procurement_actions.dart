import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';

mixin ProcurementActions<T extends ApiPage> on ApiPageState<T> {
  Widget procurementActions(Json item) {
    final id = idOf(item);
    final status = item['status'];
    if (status == 'approved' || status == 'in_delivery') {
      return FilledButton(
        onPressed: busy
            ? null
            : () => confirm(
                'Konfirmasi barang sudah sampai?',
                '/admin/stock-procurements/$id/confirm-arrived',
              ),
        child: const Text('Konfirmasi sampai'),
      );
    } else if (status == 'arrived') {
      return FilledButton(
        onPressed: busy
            ? null
            : () => confirm(
                'Terapkan stok ke gudang dan sistem?',
                '/admin/stock-procurements/$id/apply-stock',
              ),
        child: const Text('Terapkan stok'),
      );
    }
    return const SizedBox.shrink();
  }
}
