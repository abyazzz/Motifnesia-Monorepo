import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/return_card.dart';

class AdminReturnsPage extends ApiPage {
  const AdminReturnsPage(super.arguments, {super.key});

  @override
  ApiPageState<AdminReturnsPage> createState() => _AdminReturnsPageState();
}

class _AdminReturnsPageState extends ApiPageState<AdminReturnsPage> {
  @override
  Widget buildContent() {
    final items = records(data['returns']);
    const statuses = ['Pending', 'Disetujui', 'Ditolak', 'Diproses', 'Selesai'];
    return StackGroup([
      filter('Status retur', 'status', {
        'all': 'Semua',
        for (final status in statuses) status: status,
      }),
      if (items.isEmpty) emptyMessage('Belum ada pengajuan retur.'),
      for (final record in items)
        ReturnCard(
          record: record,
          onProof: (kind, title) =>
              openProof('/admin/returns/${idOf(record)}/proof/$kind', title),
          actions: [
            actionButton(
              'Ubah status',
              Icons.edit_outlined,
              () => prompt(
                'Ubah status retur',
                '/admin/returns/${idOf(record)}/update-status',
                [
                  FormFieldSpec(
                    'status',
                    'Status',
                    kind: FieldKind.choice,
                    initial: record['status'],
                    options: {for (final status in statuses) status: status},
                  ),
                  FormFieldSpec(
                    'admin_note',
                    'Catatan',
                    kind: FieldKind.multiline,
                    required: false,
                    initial: record['admin_note'],
                  ),
                ],
              ),
            ),
            actionButton(
              'Hapus',
              Icons.delete_outline,
              () => confirm(
                'Hapus pengajuan ini?',
                '/admin/returns/${idOf(record)}',
                method: 'DELETE',
              ),
            ),
          ],
        ),
      pagination(data['returns']),
    ]);
  }
}
