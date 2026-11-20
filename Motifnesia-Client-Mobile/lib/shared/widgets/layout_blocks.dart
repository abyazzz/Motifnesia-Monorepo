import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/shared/widgets/brand.dart';

class Block extends StatelessWidget {
  const Block({required this.child, this.padding = const EdgeInsets.all(16)});
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: padding, child: child),
  );
}

class StackGroup extends StatelessWidget {
  const StackGroup(this.children, {this.gap = 12});
  final List<Widget> children;
  final double gap;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < children.length; i++) ...[
        if (i != 0) SizedBox(height: gap),
        children[i],
      ],
    ],
  );
}

class PageHeading extends StatelessWidget {
  const PageHeading(this.title, {this.subtitle, this.trailing});
  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final text = StackGroup([
      Text(title, style: Theme.of(context).textTheme.headlineSmall),
      if (subtitle != null && subtitle!.isNotEmpty)
        Text(
          subtitle!,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
    ], gap: 5);
    return trailing == null
        ? text
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: text),
              const SizedBox(width: 8),
              trailing!,
            ],
          );
  }
}

class Notice extends StatelessWidget {
  const Notice({
    required this.icon,
    required this.title,
    this.detail,
    this.end,
  });
  final IconData icon;
  final String title;
  final String? detail;
  final Widget? end;

  @override
  Widget build(BuildContext context) => Block(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 34),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (detail != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(detail!, textAlign: TextAlign.center),
            ),
          if (end != null)
            Padding(padding: const EdgeInsets.only(top: 14), child: end!),
        ],
      ),
    ),
  );
}

class FullMessage extends StatelessWidget {
  const FullMessage(this.message, {required this.onBack});
  final String message;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Brand()),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Notice(
          icon: Icons.info_outline,
          title: message,
          end: FilledButton(onPressed: onBack, child: const Text('Kembali')),
        ),
      ),
    ),
  );
}

Widget emptyMessage(String message) =>
    Notice(icon: Icons.inbox_outlined, title: message);
