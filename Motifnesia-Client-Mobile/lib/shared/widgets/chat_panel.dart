import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class ChatPanel extends StatefulWidget {
  const ChatPanel({
    super.key,
    required this.api,
    required this.id,
    required this.viewerId,
    required this.admin,
    required this.title,
    required this.initial,
    this.close,
  });
  final MotifnesiaApi api;
  final String id;
  final String viewerId;
  final bool admin;
  final String title;
  final List<Json> initial;
  final VoidCallback? close;

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  final controller = TextEditingController();
  final scroll = ScrollController();
  late final List<Json> messages = List.of(widget.initial);
  late final Timer timer;
  bool sending = false;
  bool polling = false;
  String? error;
  String get base => widget.admin ? '/admin/live-chat' : '/chat';

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (_) => poll());
    WidgetsBinding.instance.addPostFrameCallback((_) => toEnd());
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    scroll.dispose();
    super.dispose();
  }

  void toEnd() {
    if (mounted && scroll.hasClients)
      scroll.jumpTo(scroll.position.maxScrollExtent);
  }

  Future<void> poll() async {
    if (polling) return;
    polling = true;
    try {
      final last = messages.fold<int>(
        0,
        (max, item) => whole(item['id']) > max ? whole(item['id']) : max,
      );
      final result = await widget.api.get(
        '$base/${widget.id}/messages',
        query: {'last_message_id': '$last'},
      );
      if (!mounted) return;
      final seen = messages.map(idOf).toSet();
      final incoming = records(
        result['messages'],
      ).where((row) => seen.add(idOf(row))).toList();
      if (incoming.isNotEmpty) {
        setState(() => messages.addAll(incoming));
        WidgetsBinding.instance.addPostFrameCallback((_) => toEnd());
      }
    } on ApiFailure {
      // Leave the current messages visible when polling is interrupted.
    } finally {
      polling = false;
    }
  }

  Future<void> send() async {
    final message = controller.text.trim();
    if (message.isEmpty || sending) return;
    setState(() {
      sending = true;
      error = null;
    });
    try {
      await widget.api.request(
        'POST',
        '$base/send',
        data: {'chat_id': widget.id, 'message': message},
      );
      if (mounted) {
        controller.clear();
        await poll();
      }
    } on ApiFailure catch (problem) {
      if (mounted) setState(() => error = problem.message);
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Block(
      child: StackGroup([
        PageHeading(
          widget.title,
          trailing: widget.close == null
              ? null
              : IconButton(
                  tooltip: 'Akhiri chat',
                  onPressed: widget.close,
                  icon: const Icon(Icons.close),
                ),
        ),
        SizedBox(
          height: 300,
          child: ListView(
            controller: scroll,
            children: [
              if (messages.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Mulai percakapan dengan pesan pertama.'),
                ),
              for (final item in messages)
                Builder(
                  builder: (context) {
                    final fromMe = item['sender_id'] == null
                        ? (truth(item['is_admin']) == widget.admin)
                        : text(item['sender_id']) == widget.viewerId;
                    return Align(
                      alignment: fromMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        constraints: const BoxConstraints(maxWidth: 360),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: fromMe
                              ? colors.primaryContainer
                              : colors.surfaceContainerHigh,
                        ),
                        child: Text(text(item['message'])),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
        if (error != null) Text(error!, style: TextStyle(color: colors.error)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => send(),
                decoration: const InputDecoration(labelText: 'Tulis pesan'),
                textInputAction: TextInputAction.send,
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              tooltip: 'Kirim pesan',
              onPressed: sending ? null : send,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ]),
    );
  }
}
