import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/brand.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.toggleTheme,
    required this.title,
    required this.submitLabel,
    required this.fields,
    required this.onSubmit,
    required this.links,
  });

  final VoidCallback toggleTheme;
  final String title;
  final String submitLabel;
  final List<FormFieldSpec> fields;
  final FormSubmit onSubmit;
  final List<Widget> links;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Brand(),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            onPressed: toggleTheme,
            icon: const Icon(Icons.brightness_6_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: StackGroup([
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    catalogPortrait,
                    height: 165,
                    fit: BoxFit.cover,
                  ),
                ),
                PageHeading(title),
                FormView(
                  embedded: true,
                  label: submitLabel,
                  fields: fields,
                  onSubmit: onSubmit,
                ),
                actionGroup([
                  ...links,
                  TextButton(
                    onPressed: () => replaceStack(context, '/homePage'),
                    child: const Text('Lihat koleksi'),
                  ),
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
