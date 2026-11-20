import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.initial,
    required this.onSearch,
    this.api,
  });
  final String initial;
  final ValueChanged<String> onSearch;
  final MotifnesiaApi? api;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late final field = TextEditingController(text: widget.initial);
  Timer? debounce;
  List<Json> results = [];

  @override
  void didUpdateWidget(covariant SearchBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initial != oldWidget.initial) field.text = widget.initial;
  }

  @override
  void dispose() {
    debounce?.cancel();
    field.dispose();
    super.dispose();
  }

  void search(String value) {
    debounce?.cancel();
    setState(() => results = []);
    widget.onSearch(value.trim());
  }

  void suggest(String value) {
    debounce?.cancel();
    if (widget.api == null || value.trim().length < 2) {
      if (results.isNotEmpty) setState(() => results = []);
      return;
    }
    debounce = Timer(const Duration(milliseconds: 280), () async {
      try {
        final found = records(
          await widget.api!.request(
            'GET',
            '/search/live',
            query: {'q': value.trim()},
          ),
        );
        if (mounted && field.text == value) setState(() => results = found);
      } on ApiFailure {
        if (mounted) setState(() => results = []);
      }
    });
  }

  @override
  Widget build(BuildContext context) => StackGroup([
    TextField(
      controller: field,
      textInputAction: TextInputAction.search,
      onChanged: suggest,
      onSubmitted: search,
      decoration: InputDecoration(
        labelText: widget.api == null ? 'Cari' : 'Cari koleksi batik',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          tooltip: 'Cari',
          onPressed: () => search(field.text),
          icon: const Icon(Icons.send_outlined),
        ),
      ),
    ),
    if (results.isNotEmpty)
      Block(
        child: StackGroup([
          for (final item in results)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(productName(item)),
              subtitle: Text(money(item['harga'])),
              onTap: () {
                setState(() => results = []);
                openPage(context, '/products/${idOf(item)}');
              },
            ),
        ], gap: 0),
      ),
  ], gap: 8);
}
