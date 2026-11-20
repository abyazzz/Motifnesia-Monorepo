import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

Widget metric(BuildContext context, String label, Object? value) => Block(
  child: StackGroup([
    Text(
      label,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
    ),
    Text(text(value, '0'), style: Theme.of(context).textTheme.titleLarge),
  ], gap: 5),
);

Widget metrics(BuildContext context, Map<String, Object?> values) =>
    LayoutBuilder(
      builder: (context, constraints) {
        final count = constraints.maxWidth >= 760 ? 4 : 2;
        final width = (constraints.maxWidth - 10 * (count - 1)) / count;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final entry in values.entries)
              SizedBox(
                width: width,
                child: metric(context, entry.key, entry.value),
              ),
          ],
        );
      },
    );

Widget detailLine(String title, Object? value) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 3),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Text(title)),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          text(value, '—'),
          textAlign: TextAlign.end,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    ],
  ),
);
