import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/views/admin/components/procurement_form.dart';

class CreateProcurementPage extends ApiPage {
  const CreateProcurementPage(super.arguments, {super.key});

  @override
  ApiPageState<CreateProcurementPage> createState() =>
      _CreateProcurementPageState();
}

class _CreateProcurementPageState extends ApiPageState<CreateProcurementPage> {
  @override
  Widget buildContent() => ProcurementForm(
    suppliers: records(data['suppliers']),
    products: records(data['products']),
    api: api,
    onSubmit: (values) async {
      final result = asMap(
        await api.request('POST', '/admin/stock-procurements', data: values),
      );
      if (!mounted) return;
      feedback(text(result['message']));
      Navigator.of(context).pushReplacementNamed(
        clientPath(result['redirect']) ?? '/admin/stock-procurements',
      );
    },
  );
}
