import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/search_box.dart';
import 'package:motifnesia_mobile/views/customer/components/catalog_banner.dart';
import 'package:motifnesia_mobile/views/customer/components/product_grid.dart';

class CatalogPage extends ApiPage {
  const CatalogPage(super.arguments, {super.key});

  @override
  ApiPageState<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends ApiPageState<CatalogPage> {
  @override
  Widget buildContent() {
    final products = records(data['products']);
    final slides = records(data['slides']);
    final filters = asMap(data['filterOptions']);
    final active = query.entries.any(
      (entry) =>
          entry.value.isNotEmpty &&
          const [
            'search',
            'gender',
            'jenis_lengan',
            'price_range',
          ].contains(entry.key),
    );
    final gender = {
      for (final value in asList(filters['genders'])) text(value): text(value),
    };
    final sleeve = {
      for (final value in asList(filters['sleeves'])) text(value): text(value),
    };
    final prices = {
      for (final option in records(filters['price_ranges']))
        text(option['value']): text(option['label']),
    };
    final productGrid = ProductGrid(api: api, products: products);
    return StackGroup([
      if (!active) CatalogBanner(slides: slides, api: api),
      Row(
        children: [
          Expanded(
            child: SearchBox(
              key: const ValueKey('catalog-search'),
              initial: query['search'] ?? '',
              api: api,
              onSearch: (value) => reload(filters: {...query, 'search': value}),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filledTonal(
            tooltip: 'Filter koleksi',
            onPressed: () async {
              await showModalBottomSheet<void>(
                context: context,
                useSafeArea: true,
                isScrollControlled: true,
                showDragHandle: true,
                builder: (sheet) => FormView(
                  title: 'Filter koleksi',
                  label: 'Terapkan',
                  fields: [
                    FormFieldSpec(
                      'gender',
                      'Kategori',
                      kind: FieldKind.choice,
                      options: {'': 'Semua', ...gender},
                      initial: query['gender'] ?? '',
                      required: false,
                    ),
                    FormFieldSpec(
                      'jenis_lengan',
                      'Jenis lengan',
                      kind: FieldKind.choice,
                      options: {'': 'Semua', ...sleeve},
                      initial: query['jenis_lengan'] ?? '',
                      required: false,
                    ),
                    FormFieldSpec(
                      'price_range',
                      'Rentang harga',
                      kind: FieldKind.choice,
                      options: {'': 'Semua', ...prices},
                      initial: query['price_range'] ?? '',
                      required: false,
                    ),
                  ],
                  onSubmit: (fields, _) async {
                    Navigator.pop(sheet);
                    await reload(
                      filters: {
                        ...query,
                        for (final key in [
                          'gender',
                          'jenis_lengan',
                          'price_range',
                        ])
                          key: text(fields[key]),
                      },
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      if (!active)
        actionGroup([
          for (final category in const [
            ('Pria', 'Pria', 'kategori_pria.png'),
            ('Wanita', 'Wanita', 'kategori_wanita.png'),
            ('Anak-anak', 'Anak', 'kategori_anak.png'),
          ])
            ActionChip(
              avatar: CircleAvatar(
                backgroundImage: AssetImage('assets/images/${category.$3}'),
              ),
              label: Text(category.$2),
              onPressed: () => reload(filters: {'gender': category.$1}),
            ),
        ]),
      PageHeading(
        active ? 'Hasil pilihanmu' : 'Jelajahi koleksi',
        subtitle: '${products.length} produk',
        trailing: active
            ? TextButton(
                onPressed: () => reload(filters: {}),
                child: const Text('Reset'),
              )
            : null,
      ),
      if (products.isEmpty)
        emptyMessage('Produk belum ditemukan.')
      else
        productGrid,
    ], gap: 16);
  }
}
