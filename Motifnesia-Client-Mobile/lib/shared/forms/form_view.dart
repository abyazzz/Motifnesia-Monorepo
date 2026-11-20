import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/widgets/action_controls.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

enum FieldKind { text, secret, email, number, multiline, choice, image, toggle }

class FormFieldSpec {
  const FormFieldSpec(
    this.key,
    this.label, {
    this.kind = FieldKind.text,
    this.initial,
    this.options = const {},
    this.required = true,
  });
  final String key;
  final String label;
  final FieldKind kind;
  final Object? initial;
  final Map<String, String> options;
  final bool required;
}

typedef FormSubmit =
    Future<void> Function(Json values, Map<String, Attachment> files);

class FormView extends StatefulWidget {
  const FormView({
    super.key,
    this.title,
    this.label = 'Simpan',
    required this.fields,
    required this.onSubmit,
    this.embedded = false,
    this.summary,
  });
  final String? title;
  final String label;
  final List<FormFieldSpec> fields;
  final FormSubmit onSubmit;
  final bool embedded;
  final Widget Function(Json)? summary;

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final key = GlobalKey<FormState>();
  late final Json values = {
    for (final field in widget.fields)
      if (field.initial != null) field.key: field.initial,
  };
  final files = <String, Attachment>{};
  bool sending = false;
  bool reveal = false;
  String? error;

  Future<void> submit() async {
    if (sending || !key.currentState!.validate()) return;
    final missing = widget.fields.where(
      (f) =>
          f.kind == FieldKind.image && f.required && !files.containsKey(f.key),
    );
    if (missing.isNotEmpty) {
      setState(
        () => error =
            'Pilih ${missing.first.label.toLowerCase()} terlebih dahulu.',
      );
      return;
    }
    setState(() {
      sending = true;
      error = null;
    });
    try {
      await widget.onSubmit(values, files);
    } on ApiFailure catch (problem) {
      if (mounted) setState(() => error = problem.message);
    } on Exception {
      if (mounted)
        setState(() => error = 'Form belum berhasil dikirim. Coba lagi.');
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  Future<void> pick(FormFieldSpec field) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      final file = result?.files.single;
      final bytes = file?.bytes;
      if (!mounted || file == null || bytes == null) return;
      setState(() => files[field.key] = Attachment(file.name, bytes));
    } on Exception {
      if (mounted) setState(() => error = 'Gambar tidak dapat dibuka.');
    }
  }

  Widget input(FormFieldSpec field) {
    String? validate(String? value) =>
        field.required && (value == null || value.trim().isEmpty)
        ? '${field.label} wajib diisi.'
        : null;
    if (field.kind == FieldKind.choice) {
      final current = text(values[field.key]);
      return DropdownButtonFormField<String>(
        value: field.options.containsKey(current) ? current : null,
        isExpanded: true,
        decoration: InputDecoration(labelText: field.label),
        items: field.options.entries
            .map(
              (option) => DropdownMenuItem(
                value: option.key,
                child: Text(option.value, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(),
        onChanged: sending
            ? null
            : (value) {
                values[field.key] = value;
                if (widget.summary != null) setState(() {});
              },
        validator: validate,
      );
    }
    if (field.kind == FieldKind.image) {
      return actionButton(
        files[field.key]?.name ?? 'Pilih ${field.label.toLowerCase()}',
        Icons.upload_file_outlined,
        sending ? null : () => pick(field),
      );
    }
    if (field.kind == FieldKind.toggle) {
      return SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(field.label),
        value: truth(values[field.key]),
        onChanged: sending
            ? null
            : (value) => setState(() => values[field.key] = value),
      );
    }
    return TextFormField(
      initialValue: text(values[field.key]),
      enabled: !sending,
      obscureText: field.kind == FieldKind.secret && !reveal,
      minLines: field.kind == FieldKind.multiline ? 2 : 1,
      maxLines: field.kind == FieldKind.multiline ? 5 : 1,
      keyboardType: switch (field.kind) {
        FieldKind.number => const TextInputType.numberWithOptions(
          decimal: true,
          signed: true,
        ),
        FieldKind.email => TextInputType.emailAddress,
        FieldKind.multiline => TextInputType.multiline,
        _ => TextInputType.text,
      },
      decoration: InputDecoration(
        labelText: field.label,
        suffixIcon: field.kind == FieldKind.secret
            ? IconButton(
                tooltip: reveal ? 'Sembunyikan sandi' : 'Tampilkan sandi',
                onPressed: () => setState(() => reveal = !reveal),
                icon: Icon(
                  reveal
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
      ),
      validator: validate,
      onChanged: (value) => values[field.key] = field.kind == FieldKind.secret
          ? value
          : value.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final form = Form(
      key: key,
      child: StackGroup([
        if (widget.title != null) PageHeading(widget.title!),
        for (final field in widget.fields) input(field),
        if (widget.summary != null) widget.summary!(values),
        if (error != null)
          Text(
            error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        FilledButton(
          onPressed: sending ? null : submit,
          child: sending
              ? const SizedBox.square(
                  dimension: 19,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.label),
        ),
      ]),
    );
    if (widget.embedded) return Block(child: form);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: form,
    );
  }
}
