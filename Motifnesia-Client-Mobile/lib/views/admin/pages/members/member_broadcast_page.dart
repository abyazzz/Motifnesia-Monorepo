import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class MemberBroadcastPage extends ApiPage {
  const MemberBroadcastPage(super.arguments, {super.key});

  @override
  ApiPageState<MemberBroadcastPage> createState() =>
      _MemberBroadcastPageState();
}

class _MemberBroadcastPageState extends ApiPageState<MemberBroadcastPage> {
  @override
  Widget buildContent() {
    final members = records(data['members']);
    return StackGroup([
      inlineForm(
        [
          const FormFieldSpec('title', 'Judul broadcast'),
          FormFieldSpec(
            'message',
            'Isi pesan',
            kind: FieldKind.multiline,
            initial: data['broadcastMessage'],
          ),
          FormFieldSpec(
            'caption',
            'Keterangan email',
            kind: FieldKind.multiline,
            required: false,
            initial: data['broadcastCaption'] ?? '',
          ),
        ],
        '/admin/membership-broadcast',
        label: 'Kirim ke member aktif',
        follow: false,
      ),
      PageHeading(
        'Penerima aktif',
        subtitle:
            '${data['members'] is PageSlice ? (data['members'] as PageSlice).total : members.length} member',
      ),
      if (members.isEmpty) emptyMessage('Belum ada penerima aktif.'),
      for (final member in members)
        Block(
          child: StackGroup([
            Text(text(member['full_name'], text(member['name']))),
            Text(text(member['email'])),
          ], gap: 4),
        ),
      pagination(data['members']),
    ]);
  }
}
