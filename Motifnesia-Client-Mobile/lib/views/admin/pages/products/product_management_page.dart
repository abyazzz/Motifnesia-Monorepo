import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';
import 'package:motifnesia_mobile/shared/widgets/search_box.dart';
import 'package:motifnesia_mobile/views/admin/components/product_editor.dart';

class ProductManagementPage extends ApiPage {
  const ProductManagementPage(super.arguments, {super.key});

  @override
  ApiPageState<ProductManagementPage> createState() =>
      _ProductManagementPageState();
}

class _ProductManagementPageState extends ApiPageState<ProductManagementPage>
    with ProductEditor<ProductManagementPage> {
  @override
  Widget buildContent() {
    final all = records(data['products']);
    final term = (query['search'] ?? '').toLowerCase();
    final selectedFilter = query['filter'] ?? 'all';
    final products = all.where((product) {
      final matches = [
        productName(product),
        text(product['sku']),
        text(product['kategori']),
        text(product['tags']),
      ].any((value) => value.toLowerCase().contains(term));
      return matches &&
          switch (selectedFilter) {
            'discount' => whole(product['diskon_persen']) > 0,
            'low' => whole(product['stok']) < 10,
            _ => true,
          };
    }).toList();
    return StackGroup([
      PageHeading(
        'Manajemen produk',
        subtitle: '${all.length} produk aktif',
        trailing: session.allows('is-owner')
            ? IconButton.filledTonal(
                tooltip: 'Tambah produk',
                onPressed: () => openPage(context, '/admin/products/create'),
                icon: const Icon(Icons.add),
              )
            : null,
      ),
      metrics(context, {
        'Produk diskon': all
            .where((row) => whole(row['diskon_persen']) > 0)
            .length,
        'Stok rendah': all.where((row) => whole(row['stok']) < 10).length,
      }),
      SearchBox(
        initial: query['search'] ?? '',
        onSearch: (value) => setState(() => query['search'] = value),
      ),
      filter('Filter produk', 'filter', const {
        'all': 'Semua',
        'discount': 'Diskon',
        'low': 'Stok rendah',
      }),
      if (products.isEmpty) emptyMessage('Produk belum ditemukan.'),
      for (final product in products)
        Block(
          child: StackGroup([
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Photo(api, productImage(product), width: 56, height: 56),
              title: Text(productName(product)),
              subtitle: Text(
                '${text(product['sku'], 'SKU belum diisi')} · ${money(productPrice(product))}',
              ),
            ),
            detailLine('Stok total', product['stok']),
            if (records(product['sizeStocks']).isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final size in records(product['sizeStocks']))
                    statusBadge(
                      context,
                      '${text(size['ukuran'])} · ${text(size['stok'])}',
                    ),
                ],
              ),
            actionGroup([
              actionButton(
                'Lihat detail',
                Icons.info_outline,
                () => productDetails(product),
              ),
              if (session.allows('is-owner')) ...[
                actionButton(
                  'Ubah',
                  Icons.edit_outlined,
                  () => editProduct(product),
                ),
                actionButton(
                  'Arsipkan',
                  Icons.archive_outlined,
                  () => confirm(
                    'Arsipkan produk ini?',
                    '/admin/products/${idOf(product)}/delete',
                  ),
                ),
              ],
            ]),
          ], gap: 7),
        ),
    ]);
  }
}
