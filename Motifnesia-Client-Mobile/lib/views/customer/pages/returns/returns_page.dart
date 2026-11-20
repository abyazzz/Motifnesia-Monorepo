import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/return_card.dart';

class ReturnsPage extends ApiPage {
  const ReturnsPage(super.arguments, {super.key});

  @override
  ApiPageState<ReturnsPage> createState() => _ReturnsPageState();
}

class _ReturnsPageState extends ApiPageState<ReturnsPage> {
  @override
  Widget buildContent() {
    final items = records(data['returns']);
    return StackGroup([
      if (items.isEmpty) emptyMessage('Belum ada pengajuan retur.'),
      for (final record in items)
        ReturnCard(
          record: record,
          onProof: (kind, title) =>
              openProof('/returns/${idOf(record)}/proof/$kind', title),
          actions: [
            if (record['status'] == 'Pending')
              actionButton(
                'Batalkan retur',
                Icons.close,
                () => confirm(
                  'Batalkan retur ini?',
                  '/returns/${idOf(record)}/cancel',
                  method: 'PATCH',
                ),
              ),
            if (record['status'] == 'Disetujui' &&
                text(record['courier_photo']).isEmpty)
              actionButton(
                'Unggah bukti kurir',
                Icons.upload_file_outlined,
                () => prompt(
                  'Bukti serah terima kurir',
                  '/returns/${idOf(record)}/courier-proof',
                  const [
                    FormFieldSpec(
                      'courier_photo',
                      'Foto bukti kurir',
                      kind: FieldKind.image,
                    ),
                    FormFieldSpec(
                      'courier_note',
                      'Catatan kurir',
                      required: false,
                    ),
                  ],
                ),
              ),
          ],
        ),
      pagination(data['returns']),
    ]);
  }
}
