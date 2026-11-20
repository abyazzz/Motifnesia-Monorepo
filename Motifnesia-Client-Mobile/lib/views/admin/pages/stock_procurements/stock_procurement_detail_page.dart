import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/procurement/procurement_details.dart';
import 'package:motifnesia_mobile/views/admin/components/procurement_actions.dart';

class StockProcurementDetailPage extends ApiPage {
  const StockProcurementDetailPage(super.arguments, {super.key});

  @override
  ApiPageState<StockProcurementDetailPage> createState() =>
      _StockProcurementDetailPageState();
}

class _StockProcurementDetailPageState
    extends ApiPageState<StockProcurementDetailPage>
    with ProcurementActions<StockProcurementDetailPage> {
  @override
  Widget buildContent() {
    final procurement = asMap(data['procurement']);
    return ProcurementDetails(
      api: api,
      procurement: procurement,
      actions: procurementActions(procurement),
    );
  }
}
