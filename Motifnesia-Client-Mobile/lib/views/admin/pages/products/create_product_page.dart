import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/views/admin/components/product_editor.dart';

class CreateProductPage extends ApiPage {
  const CreateProductPage(super.arguments, {super.key});

  @override
  ApiPageState<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends ApiPageState<CreateProductPage>
    with ProductEditor<CreateProductPage> {
  @override
  Widget buildContent() => FormView(
    title: 'Produk baru',
    label: 'Simpan produk',
    embedded: true,
    fields: productFields({}, adding: true),
    onSubmit: (values, files) async {
      final result = asMap(
        await api.request(
          'POST',
          '/admin/products/create',
          data: productFieldsPayload(values),
          files: files,
        ),
      );
      if (!mounted) return;
      feedback(text(result['message'], 'Produk tersimpan.'));
      Navigator.of(context).pushReplacementNamed('/admin/product-management');
    },
  );
}
