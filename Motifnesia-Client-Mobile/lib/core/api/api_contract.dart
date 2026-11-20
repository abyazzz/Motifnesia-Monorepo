typedef Json = Map<String, dynamic>;

Json asMap(Object? value) =>
    value is Map ? Map<String, dynamic>.from(value) : {};
List<dynamic> asList(Object? value) => switch (value) {
  PageSlice(:final items) => items,
  List<dynamic>() => value,
  _ => const [],
};
List<Json> records(Object? value) => asList(value).map(asMap).toList();
String text(Object? value, [String fallback = '']) =>
    value == null || value.toString().trim().isEmpty
    ? fallback
    : value.toString();
int whole(Object? value) => number(value).toInt();
num number(Object? value) =>
    value is num ? value : num.tryParse(text(value)) ?? 0;
bool truth(Object? value) => value == true || value == 1 || value == '1';
String idOf(Json record) => text(record['id']);
String productName(Json product) =>
    text(product['nama'], text(product['nama_produk'], 'Produk'));
Object? productPrice(Json product) =>
    product['harga_diskon'] ?? product['harga'];
String money(Object? value) {
  final numberText = number(value).round().abs().toString();
  final groups = numberText.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return '${number(value) < 0 ? '-' : ''}Rp $groups';
}

String date(Object? value) {
  final parsed = DateTime.tryParse(text(value))?.toLocal();
  if (parsed == null) return text(value, '—');
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${parsed.day} ${months[parsed.month - 1]} ${parsed.year}';
}

String paymentLabel(Object? status) => switch (status) {
  'verified' => 'Terverifikasi',
  'rejected' => 'Ditolak',
  'expired' => 'Kedaluwarsa',
  _ => 'Menunggu Verifikasi',
};

class PageSlice {
  const PageSlice(
    this.items,
    this.total,
    this.perPage,
    this.page,
    this.pageName,
  );
  final List<dynamic> items;
  final int total;
  final int perPage;
  final int page;
  final String pageName;
  int get lastPage => perPage > 0 && total > 0 ? (total / perPage).ceil() : 1;
}

Object? decodeContract(Object? value) {
  if (value is List) return value.map(decodeContract).toList();
  if (value is! Map) return value;

  return switch (value['_type']) {
    'record' => decodeContract(value['fields']),
    'collection' => decodeContract(value['items']) ?? const [],
    'datetime' => value['iso'],
    'pagination' => PageSlice(
      asList(decodeContract(value['items'])),
      whole(value['total']),
      whole(value['per_page']),
      whole(value['current_page']),
      text(value['page_name'], 'page'),
    ),
    _ => value.map(
      (key, item) => MapEntry(key.toString(), decodeContract(item)),
    ),
  };
}

String? clientPath(Object? input) {
  final value = text(input);
  final uri = Uri.tryParse(value);
  if (uri == null ||
      value.contains('\\') ||
      !uri.path.startsWith('/') ||
      uri.path.startsWith('//') ||
      value.startsWith('//')) {
    return null;
  }

  return Uri(path: uri.path, query: uri.hasQuery ? uri.query : null).toString();
}

Uri endpointUri(Uri base, String path, [Map<String, String>? query]) {
  final originPath = base.path.replaceFirst(RegExp(r'/+$'), '');
  final destination = Uri.parse(path);
  if (!path.startsWith('/') ||
      destination.hasAuthority ||
      destination.hasScheme ||
      destination.pathSegments.any(
        (segment) => segment == '..' || segment == '.',
      )) {
    throw ArgumentError.value(path, 'path', 'Endpoint API tidak valid.');
  }

  return base.replace(
    path: originPath + destination.path,
    queryParameters: {...destination.queryParameters, ...?query},
  );
}

Map<String, String> multipartFields(Json data) {
  final result = <String, String>{};
  void write(String key, Object? item) {
    if (item == null) return;
    if (item is Map) {
      item.forEach((name, value) => write('$key[$name]', value));
    } else if (item is List) {
      for (var i = 0; i < item.length; i++) {
        write('$key[$i]', item[i]);
      }
    } else {
      result[key] = item is bool ? (item ? '1' : '0') : item.toString();
    }
  }

  data.forEach(write);
  return result;
}
