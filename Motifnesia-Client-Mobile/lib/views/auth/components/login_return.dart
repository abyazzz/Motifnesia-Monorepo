import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';

class LoginReturn extends StatelessWidget {
  const LoginReturn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
      child: const Text('Kembali ke login'),
    );
  }
}

Future<void> submitAndReturnToLogin(
  BuildContext context,
  MotifnesiaApi api,
  String path,
  Json fields,
) async {
  final result = asMap(await api.request('POST', path, data: fields));
  if (!context.mounted) return;
  final message = text(result['message']);
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
  Navigator.of(context).pushReplacementNamed('/login');
}
