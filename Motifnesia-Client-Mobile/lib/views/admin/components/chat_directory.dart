import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class ChatDirectory extends StatefulWidget {
  const ChatDirectory({
    required this.api,
    required this.initial,
    required this.activeId,
    required this.onSelected,
  });

  final MotifnesiaApi api;
  final List<Json> initial;
  final String activeId;
  final ValueChanged<String> onSelected;

  @override
  State<ChatDirectory> createState() => _ChatDirectoryState();
}

class _ChatDirectoryState extends State<ChatDirectory> {
  List<Json>? updates;
  Timer? timer;
  bool fetching = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 8), (_) => poll());
  }

  Future<void> poll() async {
    if (fetching) return;
    fetching = true;
    try {
      final result = await widget.api.get('/admin/live-chat/list');
      if (mounted) setState(() => updates = records(result['chats']));
    } on ApiFailure {
      // Retain the last directory when polling is interrupted.
    } finally {
      fetching = false;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chats = updates ?? widget.initial;
    return StackGroup([
      const PageHeading('Percakapan aktif'),
      if (chats.isEmpty) emptyMessage('Belum ada percakapan.'),
      for (final item in chats)
        Block(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            selected: widget.activeId == idOf(item),
            leading: const CircleAvatar(child: Icon(Icons.person_outline)),
            title: Text(
              text(
                item['user_name'] ?? asMap(item['user'])['name'],
                'Pelanggan',
              ),
            ),
            subtitle: Text(
              text(
                item['last_message'] ?? asMap(item['lastMessage'])['message'],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: whole(item['unread_count']) > 0
                ? statusBadge(context, text(item['unread_count']))
                : const Icon(Icons.chevron_right),
            onTap: () => widget.onSelected(idOf(item)),
          ),
        ),
    ]);
  }
}
