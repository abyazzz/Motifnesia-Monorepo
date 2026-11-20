import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/layouts/api_page.dart';
import 'package:motifnesia_mobile/shared/widgets/chat_panel.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class CustomerChatPage extends ApiPage {
  const CustomerChatPage(super.arguments, {super.key});

  @override
  ApiPageState<CustomerChatPage> createState() => _CustomerChatPageState();
}

class _CustomerChatPageState extends ApiPageState<CustomerChatPage> {
  @override
  Widget buildContent() {
    final chat = asMap(data['chat']);
    return StackGroup([
      if (chat.isEmpty)
        Notice(
          icon: Icons.chat_bubble_outline,
          title: 'Hubungi admin',
          end: FilledButton(
            onPressed: busy ? null : () => action('/chat/get-or-create'),
            child: const Text('Mulai chat'),
          ),
        ),
      if (chat.isNotEmpty)
        ChatPanel(
          key: ValueKey(idOf(chat)),
          api: api,
          id: idOf(chat),
          viewerId: idOf(session.viewer),
          admin: false,
          title: 'Chat Motifnesia',
          initial: records(data['messages']),
          close: () =>
              confirm('Akhiri percakapan?', '/chat/${idOf(chat)}/close'),
        ),
    ]);
  }
}
