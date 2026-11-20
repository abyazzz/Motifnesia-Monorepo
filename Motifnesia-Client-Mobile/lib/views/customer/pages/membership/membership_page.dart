import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/metrics.dart';

class MembershipPage extends ApiPage {
  const MembershipPage(super.arguments, {super.key});

  @override
  ApiPageState<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends ApiPageState<MembershipPage> {
  @override
  Widget buildContent() {
    final user = asMap(data['user']);
    final benefits = asMap(user['membership_tier_info']);
    final active = truth(user['membership_active']);
    final rewards = records(data['rewards']);
    return StackGroup([
      Notice(
        icon: Icons.workspace_premium_outlined,
        title: active
            ? '${text(benefits['name'], 'Member')} · ${whole(user['reward_points'])} poin'
            : 'Membership Motifnesia',
        detail: active
            ? 'Diskon ${(100 * number(benefits['discount'])).round()}% · Pengali poin ${text(benefits['multiplier'], '1')}×'
            : 'Dapatkan poin dan tukarkan dengan voucher belanja.',
      ),
      if (!active)
        inlineForm(
          [
            FormFieldSpec(
              'name',
              'Nama lengkap',
              initial: user['full_name'] ?? user['name'],
            ),
            FormFieldSpec(
              'email',
              'Email',
              initial: user['email'],
              kind: FieldKind.email,
            ),
            FormFieldSpec(
              'phone',
              'Nomor telepon',
              initial: user['phone_number'],
            ),
          ],
          '/membership/register',
          label: 'Daftar membership',
          follow: false,
        )
      else ...[
        Block(
          child: StackGroup([
            detailLine('Total belanja', money(user['total_spending'])),
            if (text(benefits['next_tier']).isNotEmpty)
              detailLine('Tier berikutnya', benefits['next_tier']),
            LinearProgressIndicator(
              value: (number(benefits['progress_percentage']) / 100)
                  .clamp(0.0, 1.0)
                  .toDouble(),
            ),
            actionGroup([
              actionButton(
                'Riwayat poin',
                Icons.history,
                () => openPage(context, '/membership/history'),
              ),
              actionButton(
                'Voucher saya',
                Icons.confirmation_num_outlined,
                () => openPage(context, '/membership/vouchers'),
              ),
            ]),
          ]),
        ),
        const PageHeading('Tukar poin'),
        if (rewards.isEmpty) emptyMessage('Belum ada reward aktif.'),
        for (final reward in rewards)
          Block(
            child: StackGroup([
              PageHeading(
                text(reward['title']),
                subtitle: text(reward['description']),
              ),
              detailLine('Manfaat', reward['discount_label']),
              detailLine('Poin diperlukan', reward['points_required']),
              FilledButton(
                onPressed:
                    whole(user['reward_points']) <
                            whole(reward['points_required']) ||
                        busy
                    ? null
                    : () => action(
                        '/membership/redeem/${idOf(reward)}',
                        follow: true,
                      ),
                child: const Text('Tukar poin'),
              ),
            ]),
          ),
      ],
    ]);
  }
}
