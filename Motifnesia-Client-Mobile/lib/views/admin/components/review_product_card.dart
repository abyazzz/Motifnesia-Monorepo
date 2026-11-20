import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';
import 'package:motifnesia_mobile/shared/widgets/photo.dart';

class ReviewProductCard extends StatelessWidget {
  const ReviewProductCard({
    super.key,
    required this.api,
    required this.product,
    required this.onModerate,
    this.onOpen,
  });
  final MotifnesiaApi api;
  final Json product;
  final ValueChanged<Json> onModerate;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final detail = onOpen == null;
    return Block(
      child: StackGroup([
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Photo(api, productImage(product), width: 54, height: 54),
          title: Text(productName(product)),
          subtitle: Text(
            '★ ${text(product['average_rating'], '0')} · ${text(product['total_reviews'], '0')} ulasan',
          ),
          trailing: detail ? null : const Icon(Icons.chevron_right),
          onTap: onOpen,
        ),
        if (detail && records(product['reviews']).isEmpty)
          emptyMessage('Belum ada ulasan untuk produk ini.'),
        for (final review in records(product['reviews']))
          StackGroup([
            const Divider(),
            PageHeading(
              text(review['customer_name']),
              subtitle: text(review['customer_email'], text(review['date'])),
            ),
            Text('★ ${text(review['rating'])} · ${text(review['date'])}'),
            if (text(review['comment']).isNotEmpty)
              Text(text(review['comment'])),
            detailLine('Pesanan', review['order_number']),
            detailLine(
              'Status moderasi',
              _reviewStates[review['moderation_status']] ??
                  review['moderation_status'],
            ),
            actionButton('Moderasi', Icons.rule, () => onModerate(review)),
          ], gap: 5),
      ], gap: 6),
    );
  }
}

mixin ReviewModeration<T extends ApiPage> on ApiPageState<T> {
  Future<void> moderate(Json review) => prompt(
    'Moderasi ulasan',
    '/admin/product-reviews/${idOf(review)}/moderate',
    [
      FormFieldSpec(
        'moderation_status',
        'Status',
        kind: FieldKind.choice,
        options: _reviewStates,
        initial: review['moderation_status'],
      ),
      FormFieldSpec(
        'moderation_note',
        'Catatan',
        kind: FieldKind.multiline,
        required: false,
        initial: review['moderation_note'],
      ),
    ],
  );
}

const _reviewStates = {
  'approved': 'Tampil',
  'hidden': 'Disembunyikan',
  'rejected': 'Ditolak',
};
