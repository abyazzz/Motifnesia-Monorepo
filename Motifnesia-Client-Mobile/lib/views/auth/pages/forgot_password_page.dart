import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/auth_layout.dart';
import 'package:motifnesia_mobile/views/auth/components/login_return.dart';
import 'package:motifnesia_mobile/views/auth/components/security_fields.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage(this.arguments, {super.key});

  final PageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      toggleTheme: arguments.toggleTheme,
      title: 'Atur ulang sandi',
      submitLabel: 'Simpan sandi',
      fields: const [
        FormFieldSpec('username', 'Username atau email'),
        securityQuestionField,
        securityAnswerField,
        FormFieldSpec('new_password', 'Sandi baru', kind: FieldKind.secret),
        FormFieldSpec(
          'new_password_confirmation',
          'Ulangi sandi baru',
          kind: FieldKind.secret,
        ),
      ],
      onSubmit: (fields, _) => submitAndReturnToLogin(
        context,
        arguments.session.api,
        '/forgot',
        fields,
      ),
      links: const [LoginReturn()],
    );
  }
}
