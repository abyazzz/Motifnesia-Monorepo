import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class MembersPage extends ApiPage {
  const MembersPage(super.arguments, {super.key});

  @override
  ApiPageState<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends ApiPageState<MembersPage> {
  @override
  Widget buildContent() {
    final members = records(data['members']);
    return StackGroup([
      PageHeading(
        'Membership',
        subtitle:
            '${data['members'] is PageSlice ? (data['members'] as PageSlice).total : members.length} member',
      ),
      if (members.isEmpty) emptyMessage('Belum ada member.'),
      for (final member in members)
        Block(
          child: StackGroup([
            PageHeading(
              text(member['full_name'], text(member['name'])),
              subtitle: text(member['email']),
            ),
            detailLine(
              'Status',
              member['membership_status'] == 'active' ? 'Aktif' : 'Nonaktif',
            ),
            detailLine('Poin', member['reward_points']),
            detailLine('Voucher ditukar', member['reward_redemptions_count']),
            actionGroup([
              actionButton(
                'Ubah status',
                Icons.manage_accounts_outlined,
                () => prompt(
                  'Status member',
                  '/admin/memberships/${idOf(member)}/status',
                  [
                    FormFieldSpec(
                      'membership_status',
                      'Status',
                      kind: FieldKind.choice,
                      initial: member['membership_status'],
                      options: const {
                        'active': 'Aktif',
                        'inactive': 'Nonaktif',
                      },
                    ),
                  ],
                ),
              ),
              actionButton(
                'Sesuaikan poin',
                Icons.toll_outlined,
                () => prompt(
                  'Sesuaikan poin member',
                  '/admin/memberships/${idOf(member)}/points',
                  const [
                    FormFieldSpec(
                      'points',
                      'Perubahan poin (+/-)',
                      kind: FieldKind.number,
                    ),
                    FormFieldSpec(
                      'description',
                      'Keterangan',
                      required: false,
                      initial: '',
                    ),
                  ],
                ),
              ),
            ]),
          ], gap: 6),
        ),
      pagination(data['members']),
    ]);
  }
}
