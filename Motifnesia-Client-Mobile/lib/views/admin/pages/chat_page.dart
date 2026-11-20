import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/chat_panel.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';
import 'package:motifnesia_mobile/views/admin/components/chat_directory.dart';

class AdminChatPage extends ApiPage {
  const AdminChatPage(super.arguments, {super.key});

  @override
  ApiPageState<AdminChatPage> createState() => _AdminChatPageState();
}

class _AdminChatPageState extends ApiPageState<AdminChatPage> {
  @override
  Widget buildContent() {
    final chat = asMap(data['currentChat']);
    return StackGroup([
      ChatDirectory(
        api: api,
        initial: records(data['chats']),
        activeId: idOf(chat),
        onSelected: (id) => reload(filters: {'chat_id': id}),
      ),
      if (chat.isNotEmpty)
        ChatPanel(
          key: ValueKey(idOf(chat)),
          api: api,
          id: idOf(chat),
          viewerId: idOf(session.viewer),
          admin: true,
          title: text(data['currentChatName'], 'Pelanggan'),
          initial: records(data['currentChatMessages']),
        ),
    ]);
  }
}
