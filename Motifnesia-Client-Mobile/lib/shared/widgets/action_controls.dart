import 'package:flutter/material.dart';

Widget statusBadge(BuildContext context, String label) {
  final colors = Theme.of(context).colorScheme;
  return DecoratedBox(
    decoration: BoxDecoration(
      color: colors.primaryContainer,
      borderRadius: BorderRadius.circular(99),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: colors.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget actionButton(String label, IconData icon, VoidCallback? tap) =>
    OutlinedButton.icon(
      onPressed: tap,
      icon: Icon(icon, size: 18),
      label: Text(label),
    );

Widget actionGroup(List<Widget> buttons) =>
    Wrap(spacing: 8, runSpacing: 8, children: buttons);
