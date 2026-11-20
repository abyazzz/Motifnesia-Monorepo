import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/views/admin/components/review_product_card.dart';

class ProductReviewDetailPage extends ApiPage {
  const ProductReviewDetailPage(super.arguments, {super.key});

  @override
  ApiPageState<ProductReviewDetailPage> createState() =>
      _ProductReviewDetailPageState();
}

class _ProductReviewDetailPageState
    extends ApiPageState<ProductReviewDetailPage>
    with ReviewModeration<ProductReviewDetailPage> {
  @override
  Widget buildContent() => StackGroup([
    ReviewProductCard(
      api: api,
      product: asMap(data['product']),
      onModerate: moderate,
    ),
  ]);
}
