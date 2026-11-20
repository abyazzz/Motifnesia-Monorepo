import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/auth_layout.dart';
import 'package:motifnesia_mobile/views/auth/components/login_return.dart';
import 'package:motifnesia_mobile/views/auth/components/security_fields.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage(this.arguments, {super.key});

  final PageArguments arguments;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      toggleTheme: arguments.toggleTheme,
      title: 'Daftar akun',
      submitLabel: 'Buat akun',
      fields: const [
        FormFieldSpec('username', 'Username'),
        FormFieldSpec('full_name', 'Nama lengkap', required: false),
        FormFieldSpec('email', 'Email', kind: FieldKind.email),
        FormFieldSpec('password', 'Sandi', kind: FieldKind.secret),
        FormFieldSpec(
          'password_confirmation',
          'Ulangi sandi',
          kind: FieldKind.secret,
        ),
        securityQuestionField,
        securityAnswerField,
      ],
      onSubmit: (fields, _) => submitAndReturnToLogin(
        context,
        arguments.session.api,
        '/register',
        fields,
      ),
      links: const [LoginReturn()],
    );
  }
}
