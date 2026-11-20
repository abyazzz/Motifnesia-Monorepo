import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/shared/widgets/notification_card.dart';
import 'package:motifnesia_mobile/shared/widgets/search_box.dart';

class AdminNotificationsPage extends ApiPage {
  const AdminNotificationsPage(super.arguments, {super.key});

  @override
  ApiPageState<AdminNotificationsPage> createState() =>
      _AdminNotificationsPageState();
}

class _AdminNotificationsPageState
    extends ApiPageState<AdminNotificationsPage> {
  @override
  Widget buildContent() {
    final items = records(data['notifications']);
    return StackGroup([
      filter('Status notifikasi', 'filter', const {
        'all': 'Semua',
        'unread': 'Belum dibaca',
        'order': 'Pesanan',
        'stock': 'Stok',
        'review': 'Ulasan',
        'return': 'Retur',
        'membership': 'Membership',
        'system': 'Sistem',
      }),
      SearchBox(
        initial: query['search'] ?? '',
        onSearch: (value) =>
            reload(filters: {...query, 'search': value, 'page': '1'}),
      ),
      actionGroup([
        actionButton(
          'Tandai semua dibaca',
          Icons.done_all,
          busy ? null : () => action('/admin/notifications/mark-all-read'),
        ),
        actionButton(
          'Hapus yang dibaca',
          Icons.delete_sweep_outlined,
          () => confirm(
            'Hapus semua notifikasi yang sudah dibaca?',
            '/admin/notifications/clear-read',
          ),
        ),
      ]),
      if (items.isEmpty) emptyMessage('Belum ada notifikasi.'),
      for (final item in items)
        NotificationCard(
          notification: item,
          actions: [
            if (clientPath(item['link']) case final String link)
              actionButton(
                'Lihat detail',
                Icons.open_in_new,
                () => openPage(context, link),
              ),
            actionButton(
              truth(item['is_read']) ? 'Tandai belum dibaca' : 'Tandai dibaca',
              Icons.done,
              () => action('/admin/notifications/${idOf(item)}/toggle-read'),
            ),
            actionButton(
              'Hapus',
              Icons.delete_outline,
              () => confirm(
                'Hapus notifikasi ini?',
                '/admin/notifications/${idOf(item)}',
                method: 'DELETE',
              ),
            ),
          ],
        ),
      pagination(data['notifications']),
    ]);
  }
}
