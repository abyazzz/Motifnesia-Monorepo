import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/views/admin/components/review_product_card.dart';

class ProductReviewsPage extends ApiPage {
  const ProductReviewsPage(super.arguments, {super.key});

  @override
  ApiPageState<ProductReviewsPage> createState() => _ProductReviewsPageState();
}

class _ProductReviewsPageState extends ApiPageState<ProductReviewsPage>
    with ReviewModeration<ProductReviewsPage> {
  @override
  Widget buildContent() {
    final products = records(data['products']);
    return StackGroup([
      filter('Urutkan ulasan', 'filter', const {
        'all': 'Terbaru',
        'highest': 'Rating tertinggi',
        'lowest': 'Rating terendah',
      }),
      if (products.isEmpty) emptyMessage('Belum ada produk untuk ditampilkan.'),
      for (final product in products)
        ReviewProductCard(
          api: api,
          product: product,
          onModerate: moderate,
          onOpen: () =>
              openPage(context, '/admin/product-reviews/${idOf(product)}'),
        ),
    ]);
  }
}
