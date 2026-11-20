import 'package:flutter/material.dart';

const _logo = 'assets/images/motifnesia_logo.png';
const catalogPortrait = 'assets/images/hero_slide_2.png';

class Brand extends StatelessWidget {
  const Brand();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(_logo, width: 36, height: 36, fit: BoxFit.cover),
        ),
        const SizedBox(width: 9),
        Text.rich(
          TextSpan(
            text: 'Motifnesia',
            children: [
              TextSpan(
                text: '.',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          style: const TextStyle(
            fontFamily: 'serif',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
