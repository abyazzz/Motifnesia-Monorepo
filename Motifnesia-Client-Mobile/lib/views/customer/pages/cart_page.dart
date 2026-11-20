import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class CartPage extends ApiPage {
  const CartPage(super.arguments, {super.key});

  @override
  ApiPageState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ApiPageState<CartPage> {
  final selection = <String>{};

  @override
  Widget buildContent() {
    final items = records(
      data['items'],
    ).where((item) => asMap(item['produk']).isNotEmpty).toList();
    if (items.isEmpty)
      return Notice(
        icon: Icons.shopping_bag_outlined,
        title: 'Keranjang masih kosong',
        end: FilledButton(
          onPressed: () => replaceStack(context, '/homePage'),
          child: const Text('Mulai belanja'),
        ),
      );
    final total = items
        .where((item) => selection.contains(idOf(item)))
        .fold<num>(
          0,
          (sum, item) =>
              sum +
              number(productPrice(asMap(item['produk']))) * whole(item['qty']),
        );
    return StackGroup([
      CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Pilih semua'),
        value: items.every((item) => selection.contains(idOf(item))),
        onChanged: (checked) => setState(() {
          selection.clear();
          if (checked == true) selection.addAll(items.map(idOf));
        }),
      ),
      for (final item in items)
        Block(
          child: StackGroup([
            Row(
              children: [
                Checkbox(
                  value: selection.contains(idOf(item)),
                  onChanged: (value) => setState(
                    () => value == true
                        ? selection.add(idOf(item))
                        : selection.remove(idOf(item)),
                  ),
                ),
                Photo(
                  api,
                  productImage(asMap(item['produk'])),
                  width: 62,
                  height: 62,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: StackGroup([
                    Text(productName(asMap(item['produk']))),
                    Text(
                      '${text(item['ukuran'])} · ${money(productPrice(asMap(item['produk'])))}',
                    ),
                  ], gap: 3),
                ),
              ],
            ),
            Wrap(
              spacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Kurangi jumlah',
                  onPressed: busy || whole(item['qty']) <= 1
                      ? null
                      : () => _cartQty(item, whole(item['qty']) - 1),
                  icon: const Icon(Icons.remove),
                ),
                Text(text(item['qty'], '1')),
                IconButton(
                  tooltip: 'Tambah jumlah',
                  onPressed: busy
                      ? null
                      : () => _cartQty(item, whole(item['qty']) + 1),
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  tooltip: 'Hapus dari keranjang',
                  onPressed: () => confirm(
                    'Hapus produk ini?',
                    '/cart/${idOf(item)}',
                    method: 'DELETE',
                  ),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ], gap: 6),
        ),
      Block(
        child: StackGroup([
          detailLine('Total produk terpilih', money(total)),
          FilledButton(
            onPressed:
                busy ||
                    total == 0 &&
                        !items.any((item) => selection.contains(idOf(item)))
                ? null
                : () => action(
                    '/cart/checkout',
                    fields: {
                      'selected_items': items
                          .map(idOf)
                          .where(selection.contains)
                          .toList(),
                    },
                    follow: true,
                  ),
            child: const Text('Checkout'),
          ),
        ]),
      ),
    ]);
  }

  void _cartQty(Json item, int count) =>
      action('/cart/update', fields: {'cart_id': idOf(item), 'qty': count});
}
