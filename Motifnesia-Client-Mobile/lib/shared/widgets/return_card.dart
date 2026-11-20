import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class ReturnCard extends StatelessWidget {
  const ReturnCard({
    super.key,
    required this.record,
    required this.actions,
    required this.onProof,
  });

  final Json record;
  final List<Widget> actions;
  final void Function(String kind, String title) onProof;

  @override
  Widget build(BuildContext context) => Block(
    child: StackGroup([
      PageHeading(
        productName(asMap(record['produk'])),
        subtitle: 'Retur #${idOf(record)} · ${date(record['created_at'])}',
      ),
      detailLine('Status', record['status']),
      detailLine('Alasan', record['reason']),
      detailLine('Tindakan', record['action_type']),
      detailLine('Nilai refund', money(record['refund_amount'])),
      if (text(record['description']).isNotEmpty)
        detailLine('Keterangan', record['description']),
      if (text(record['admin_note']).isNotEmpty)
        detailLine('Catatan admin', record['admin_note']),
      actionGroup([
        if (text(record['photo_proof']).isNotEmpty)
          actionButton(
            'Foto produk',
            Icons.image_outlined,
            () => onProof('return', 'Bukti retur'),
          ),
        if (text(record['courier_photo']).isNotEmpty)
          actionButton(
            'Bukti kurir',
            Icons.image_outlined,
            () => onProof('courier', 'Bukti pengiriman'),
          ),
        ...actions,
      ]),
    ]),
  );
}
