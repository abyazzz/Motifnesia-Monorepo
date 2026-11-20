import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/catalog/product_sizes.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

mixin ProductEditor<T extends ApiPage> on ApiPageState<T> {
  void productDetails(Json product) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (sheet) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: StackGroup([
          PageHeading(productName(product)),
          Photo(api, productImage(product), height: 210),
          detailLine('Kategori', product['kategori']),
          detailLine('Material', product['material']),
          detailLine('Proses', product['proses']),
          detailLine('Stok', product['stok']),
          detailLine('Terjual', product['terjual']),
          Text(text(product['deskripsi'], 'Belum ada deskripsi.')),
          if (text(product['filosofi_motif']).isNotEmpty)
            Text(text(product['filosofi_motif'])),
        ]),
      ),
    );
  }

  Future<void> editProduct(Json product) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (sheet) => FormView(
        title: 'Ubah produk',
        fields: productFields(product, adding: false),
        onSubmit: (values, files) async {
          final result = asMap(
            await api.request(
              'POST',
              '/admin/products/${idOf(product)}/update',
              data: productFieldsPayload(values),
              files: files,
            ),
          );
          if (!mounted || !sheet.mounted) return;
          Navigator.pop(sheet);
          feedback(text(result['message']));
          await reload();
        },
      ),
    );
  }

  Json productFieldsPayload(Json values) {
    final result = {...values};
    final stocks = <String, Object?>{};
    for (final size in productSizes) {
      final qty = result.remove('stock_$size');
      if (text(qty).isNotEmpty) stocks[size] = qty;
    }
    if (stocks.isNotEmpty) result['size_stocks'] = stocks;
    return result;
  }

  List<FormFieldSpec> productFields(Json product, {required bool adding}) {
    final stocks = {
      for (final variant in records(product['sizeStocks']))
        text(variant['ukuran']): variant['stok'],
    };
    return [
      FormFieldSpec('name', 'Nama produk', initial: product['nama_produk']),
      FormFieldSpec('sku', 'SKU', initial: product['sku']),
      FormFieldSpec(
        'price',
        'Harga',
        kind: FieldKind.number,
        initial: product['harga'],
      ),
      FormFieldSpec(
        'diskon_persen',
        'Diskon (%)',
        kind: FieldKind.number,
        initial: product['diskon_persen'] ?? '0',
      ),
      FormFieldSpec('category', 'Kategori', initial: product['kategori']),
      FormFieldSpec('material', 'Material', initial: product['material']),
      FormFieldSpec('process', 'Proses', initial: product['proses']),
      FormFieldSpec('tags', 'Tags', initial: product['tags']),
      FormFieldSpec(
        'ukuran',
        'Ukuran',
        initial: product['ukuran'] ?? 'S,M,L,XL',
      ),
      FormFieldSpec(
        'jenis_lengan',
        'Jenis lengan',
        initial: product['jenis_lengan'],
      ),
      FormFieldSpec(
        'stock',
        'Stok total',
        kind: FieldKind.number,
        initial: product['stok'] ?? '0',
      ),
      for (final size in productSizes)
        FormFieldSpec(
          'stock_$size',
          'Stok ukuran $size',
          kind: FieldKind.number,
          initial: stocks[size],
          required: false,
        ),
      FormFieldSpec(
        'description',
        'Deskripsi',
        kind: FieldKind.multiline,
        initial: product['deskripsi'],
        required: adding,
      ),
      FormFieldSpec(
        'filosofi_motif',
        'Filosofi motif',
        kind: FieldKind.multiline,
        initial: product['filosofi_motif'],
        required: false,
      ),
      FormFieldSpec(
        'image',
        'Foto produk',
        kind: FieldKind.image,
        required: adding,
      ),
      const FormFieldSpec(
        'notify_members',
        'Beri tahu member',
        kind: FieldKind.toggle,
        initial: false,
      ),
    ];
  }
}
