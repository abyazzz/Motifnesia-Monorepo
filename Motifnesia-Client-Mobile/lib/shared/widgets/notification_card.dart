import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.actions,
  });
  final Json notification;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Block(
    child: StackGroup([
      PageHeading(
        text(notification['title']),
        subtitle: text(
          notification['time_ago'],
          date(notification['created_at']),
        ),
        trailing: !truth(notification['is_read'])
            ? statusBadge(context, 'Baru')
            : null,
      ),
      Text(text(notification['message'])),
      actionGroup(actions),
    ]),
  );
}
