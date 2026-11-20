import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/notification_card.dart';

class NotificationsPage extends ApiPage {
  const NotificationsPage(super.arguments, {super.key});

  @override
  ApiPageState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ApiPageState<NotificationsPage> {
  @override
  Widget buildContent() {
    final items = records(data['notifications']);
    return StackGroup([
      actionGroup([
        actionButton(
          'Tandai semua dibaca',
          Icons.done_all,
          busy ? null : () => action('/notifications/mark-all-read'),
        ),
      ]),
      if (items.isEmpty) emptyMessage('Belum ada notifikasi.'),
      for (final item in items)
        NotificationCard(
          notification: item,
          actions: [
            if (clientPath(item['link']) case final String link)
              actionButton('Lihat detail', Icons.open_in_new, () async {
                if (!truth(item['is_read'])) {
                  await action(
                    '/notifications/${idOf(item)}/read',
                    refresh: false,
                  );
                }
                if (mounted) openPage(context, link);
              }),
          ],
        ),
      pagination(data['notifications']),
    ]);
  }
}
