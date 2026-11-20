import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/core/catalog/product_sizes.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class ProcurementForm extends StatefulWidget {
  const ProcurementForm({
    required this.suppliers,
    required this.products,
    required this.api,
    required this.onSubmit,
  });
  final List<Json> suppliers;
  final List<Json> products;
  final MotifnesiaApi api;
  final Future<void> Function(Json) onSubmit;

  @override
  State<ProcurementForm> createState() => _ProcurementFormState();
}

class _ProcurementFormState extends State<ProcurementForm> {
  final form = GlobalKey<FormState>();
  final note = TextEditingController();
  final search = TextEditingController();
  final items = <String, Map<String, int>>{};
  String? supplier;
  String? error;
  bool sending = false;

  @override
  void dispose() {
    note.dispose();
    search.dispose();
    super.dispose();
  }

  int get total => items.values.fold(
    0,
    (sum, quantities) =>
        sum + quantities.values.fold(0, (left, right) => left + right),
  );

  Future<void> submit() async {
    if (sending || !form.currentState!.validate()) return;
    if (total <= 0) {
      setState(
        () => error = 'Masukkan jumlah untuk minimal satu ukuran produk.',
      );
      return;
    }
    setState(() {
      sending = true;
      error = null;
    });
    try {
      await widget.onSubmit({
        'supplier_id': supplier,
        'note': note.text.trim(),
        'items': items,
      });
    } on ApiFailure catch (failure) {
      if (mounted) setState(() => error = failure.message);
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final term = search.text.toLowerCase().trim();
    final matches = widget.products
        .where(
          (item) => '${productName(item)} ${text(item['sku'])}'
              .toLowerCase()
              .contains(term),
        )
        .toList();
    return Form(
      key: form,
      child: StackGroup([
        DropdownButtonFormField<String>(
          value: supplier,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Supplier'),
          items: [
            for (final item in widget.suppliers)
              DropdownMenuItem(
                value: idOf(item),
                child: Text(text(item['name'])),
              ),
          ],
          validator: (value) => value == null ? 'Pilih supplier.' : null,
          onChanged: sending ? null : (id) => setState(() => supplier = id),
        ),
        TextField(
          controller: note,
          enabled: !sending,
          decoration: const InputDecoration(labelText: 'Catatan pengadaan'),
        ),
        PageHeading('Produk', subtitle: '$total pcs dipilih'),
        TextField(
          controller: search,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            labelText: 'Cari nama atau SKU',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        if (matches.isEmpty)
          emptyMessage('Belum ada produk pada pencarian ini.'),
        for (final product in matches)
          Block(
            child: ExpansionTile(
              key: ValueKey(idOf(product)),
              tilePadding: EdgeInsets.zero,
              maintainState: true,
              leading: Photo(
                widget.api,
                productImage(product),
                width: 43,
                height: 43,
              ),
              title: Text(productName(product)),
              subtitle: Text(
                '${text(product['sku'], 'SKU belum ada')} · Stok ${whole(product['stok'])}',
              ),
              childrenPadding: const EdgeInsets.only(bottom: 4, top: 10),
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 550 ? 4 : 2;
                    final width =
                        (constraints.maxWidth - (columns - 1) * 10) / columns;
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (final size in productSizes)
                          SizedBox(
                            width: width,
                            child: TextFormField(
                              key: ValueKey('${idOf(product)}:$size'),
                              initialValue:
                                  (items[idOf(
                                            product,
                                          )]?['qty_${size.toLowerCase()}'] ??
                                          0)
                                      .toString(),
                              enabled: !sending,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Ukuran $size',
                              ),
                              validator: (value) {
                                final qty = int.tryParse(value ?? '');
                                return value != null &&
                                        value.isNotEmpty &&
                                        (qty == null || qty < 0)
                                    ? 'Jumlah tidak valid.'
                                    : null;
                              },
                              onChanged: (value) => setState(() {
                                final qty = int.tryParse(value) ?? 0;
                                items.putIfAbsent(
                                  idOf(product),
                                  () => {},
                                )['qty_${size.toLowerCase()}'] = qty;
                              }),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        if (error != null)
          Text(
            error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        FilledButton(
          onPressed: sending ? null : submit,
          child: Text(sending ? 'Menyimpan…' : 'Buat pengadaan'),
        ),
      ]),
    );
  }
}
