import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/core/session/session_controller.dart';
import 'package:motifnesia_mobile/shared/forms/form_view.dart';
import 'package:motifnesia_mobile/shared/layouts/app_scaffold.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

abstract class ApiPage extends StatefulWidget {
  const ApiPage(this.arguments, {super.key});

  final PageArguments arguments;
}

abstract class ApiPageState<T extends ApiPage> extends State<T> {
  Widget buildContent();

  late Map<String, String> query = {...uri.queryParameters};
  late Future<Json> response = _fetch();
  Json data = {};
  bool busy = false;

  SessionController get session => widget.arguments.session;
  MotifnesiaApi get api => session.api;
  Uri get uri => widget.arguments.uri;
  String get path => uri.path;

  Future<Json> _fetch() async {
    final payload = await api.get(path, query: query);
    if (mounted) session.updateViewer(payload['viewer']);
    final redirect = clientPath(payload['redirect']);
    if (redirect != null && redirect != '/' && redirect != path) {
      if (mounted) Navigator.of(context).pushReplacementNamed(redirect);
      return {};
    }
    return asMap(payload['data']);
  }

  Future<void> reload({Map<String, String>? filters}) async {
    setState(() {
      if (filters != null) query = filters;
      response = _fetch();
    });
    try {
      await response;
    } on ApiFailure {
      // FutureBuilder displays API errors and retry state.
    }
  }

  void feedback(String message) {
    if (mounted && message.isNotEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> action(
    String requestPath, {
    String method = 'POST',
    Json fields = const {},
    Map<String, Attachment> files = const {},
    bool follow = false,
    bool refresh = true,
  }) async {
    if (busy) return;
    setState(() => busy = true);
    try {
      final result = asMap(
        await api.request(method, requestPath, data: fields, files: files),
      );
      if (!mounted) return;
      feedback(
        text(result['message'], text(asMap(result['flash'])['success'])),
      );
      final next = clientPath(result['redirect_url'] ?? result['redirect']);
      if (follow && next != null && next != path && next != '/') {
        await Navigator.of(context).pushNamed(next);
      }
      if (mounted && refresh) await reload();
    } on ApiFailure catch (error) {
      if (!mounted) return;
      feedback(error.message);
      if (error.status == 401) openPage(context, '/login');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Future<void> prompt(
    String title,
    String requestPath,
    List<FormFieldSpec> fields, {
    String method = 'POST',
    Json extra = const {},
    bool follow = false,
    String? Function(Json)? validate,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (sheet) => FormView(
        title: title,
        fields: fields,
        onSubmit: (values, files) async {
          final message = validate?.call(values);
          if (message != null) throw ApiFailure(422, message, const {});

          final result = asMap(
            await api.request(
              method,
              requestPath,
              data: {...extra, ...values},
              files: files,
            ),
          );
          if (!sheet.mounted || !mounted) return;
          Navigator.pop(sheet);
          feedback(
            text(result['message'], text(asMap(result['flash'])['success'])),
          );
          final next = clientPath(result['redirect_url'] ?? result['redirect']);
          if (follow && next != null && next != path && next != '/')
            await Navigator.of(context).pushNamed(next);
          if (mounted) await reload();
        },
      ),
    );
  }

  Future<void> confirm(
    String question,
    String endpoint, {
    String method = 'POST',
    Json fields = const {},
  }) async {
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialog) => AlertDialog(
        title: Text(question),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialog, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialog, true),
            child: const Text('Lanjut'),
          ),
        ],
      ),
    );
    if (accepted == true && mounted)
      await action(endpoint, method: method, fields: fields);
  }

  Widget inlineForm(
    List<FormFieldSpec> fields,
    String endpoint, {
    String label = 'Simpan',
    String method = 'POST',
    Json extra = const {},
    bool follow = true,
    Widget Function(Json)? summary,
  }) {
    return FormView(
      fields: fields,
      label: label,
      embedded: true,
      summary: summary,
      onSubmit: (values, files) async {
        final result = asMap(
          await api.request(
            method,
            endpoint,
            data: {...extra, ...values},
            files: files,
          ),
        );
        if (!mounted) return;
        feedback(
          text(result['message'], text(asMap(result['flash'])['success'])),
        );
        final next = clientPath(result['redirect_url'] ?? result['redirect']);
        if (follow && next != null && next != path && next != '/') {
          Navigator.of(context).pushReplacementNamed(next);
        } else {
          await reload();
        }
      },
    );
  }

  Widget pagination(Object? value) {
    if (value is! PageSlice || value.lastPage == 1)
      return const SizedBox.shrink();
    void go(int page) => reload(filters: {...query, value.pageName: '$page'});
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: 'Halaman sebelumnya',
          onPressed: value.page > 1 ? () => go(value.page - 1) : null,
          icon: const Icon(Icons.chevron_left),
        ),
        Text('${value.page} dari ${value.lastPage}'),
        IconButton(
          tooltip: 'Halaman berikutnya',
          onPressed: value.page < value.lastPage
              ? () => go(value.page + 1)
              : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      arguments: widget.arguments,
      body: SafeArea(
        child: FutureBuilder<Json>(
          future: response,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              final error = snapshot.error;
              final next = error is ApiFailure ? error.redirect : null;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Notice(
                    icon: Icons.info_outline,
                    title: text(error, 'Halaman tidak dapat dimuat.'),
                    end: FilledButton(
                      onPressed: next != null && next != '/'
                          ? () => openPage(context, next)
                          : () => reload(),
                      child: Text(
                        next != null && next != '/' ? 'Lanjut' : 'Coba lagi',
                      ),
                    ),
                  ),
                ),
              );
            }
            data = snapshot.data ?? {};
            return RefreshIndicator(
              onRefresh: reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
                children: [
                  if (busy) const LinearProgressIndicator(),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: buildContent(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> openProof(String endpoint, String title) async {
    try {
      final bytes = await api.download(endpoint);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialog) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(title),
                  trailing: IconButton(
                    tooltip: 'Tutup',
                    onPressed: () => Navigator.pop(dialog),
                    icon: const Icon(Icons.close),
                  ),
                ),
                Flexible(child: InteractiveViewer(child: Image.memory(bytes))),
              ],
            ),
          ),
        ),
      );
    } on ApiFailure catch (error) {
      feedback(error.message);
    }
  }

  Widget filter(String label, String key, Map<String, String> choices) =>
      DropdownButtonFormField<String>(
        key: ValueKey('$key:${query[key]}'),
        value: choices.containsKey(query[key])
            ? query[key]
            : choices.keys.firstOrNull,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: [
          for (final choice in choices.entries)
            DropdownMenuItem(value: choice.key, child: Text(choice.value)),
        ],
        onChanged: (value) =>
            reload(filters: {...query, key: value ?? '', 'page': '1'}),
      );
}
