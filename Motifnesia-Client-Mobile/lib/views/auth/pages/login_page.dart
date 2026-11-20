import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/auth_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(this.arguments, {super.key});

  final PageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      toggleTheme: arguments.toggleTheme,
      title: 'Masuk ke Motifnesia',
      submitLabel: 'Masuk',
      fields: const [
        FormFieldSpec('username', 'Username atau email'),
        FormFieldSpec('password', 'Sandi', kind: FieldKind.secret),
      ],
      onSubmit: (fields, _) async {
        final session = arguments.session;
        final home = await session.login(fields);
        if (context.mounted) {
          replaceStack(
            context,
            session.role == 'customer' ? arguments.nextPath ?? home : home,
          );
        }
      },
      links: [
        TextButton(
          onPressed: () => openPage(context, '/forgot'),
          child: const Text('Lupa sandi?'),
        ),
        TextButton(
          onPressed: () => openPage(context, '/register'),
          child: const Text('Daftar akun'),
        ),
      ],
    );
  }
}
