import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/views/admin/components/reward_fields.dart';

class EditRewardPage extends ApiPage {
  const EditRewardPage(super.arguments, {super.key});

  @override
  ApiPageState<EditRewardPage> createState() => _EditRewardPageState();
}

class _EditRewardPageState extends ApiPageState<EditRewardPage> {
  @override
  Widget buildContent() {
    final reward = asMap(data['reward']);
    final exists = idOf(reward).isNotEmpty;
    final endpoint = exists
        ? '/admin/membership-rewards/${idOf(reward)}'
        : '/admin/membership-rewards';
    return inlineForm(
      rewardFields(reward),
      endpoint,
      method: exists ? 'PUT' : 'POST',
    );
  }
}
