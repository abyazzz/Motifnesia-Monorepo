import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class RewardsPage extends ApiPage {
  const RewardsPage(super.arguments, {super.key});

  @override
  ApiPageState<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends ApiPageState<RewardsPage> {
  @override
  Widget buildContent() {
    final rewards = records(data['rewards']);
    return StackGroup([
      PageHeading(
        'Reward membership',
        trailing: IconButton.filledTonal(
          tooltip: 'Tambah reward',
          onPressed: () =>
              openPage(context, '/admin/membership-rewards/create'),
          icon: const Icon(Icons.add),
        ),
      ),
      if (rewards.isEmpty) emptyMessage('Belum ada reward.'),
      for (final reward in rewards)
        Block(
          child: StackGroup([
            PageHeading(
              text(reward['title']),
              subtitle: text(reward['discount_label']),
            ),
            detailLine('Poin', reward['points_required']),
            detailLine(
              'Status',
              truth(reward['is_active']) ? 'Aktif' : 'Nonaktif',
            ),
            detailLine('Jumlah penukaran', reward['redemptions_count']),
            actionGroup([
              actionButton(
                'Ubah',
                Icons.edit_outlined,
                () => openPage(
                  context,
                  '/admin/membership-rewards/${idOf(reward)}/edit',
                ),
              ),
              if (truth(reward['is_active']))
                actionButton(
                  'Nonaktifkan',
                  Icons.block_outlined,
                  () => confirm(
                    'Nonaktifkan reward ini?',
                    '/admin/membership-rewards/${idOf(reward)}',
                    method: 'DELETE',
                  ),
                ),
            ]),
          ]),
        ),
      pagination(data['rewards']),
    ]);
  }
}
