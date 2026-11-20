import '../lib/core/api/api_contract.dart';

void expect(bool condition, String description) {
  if (!condition) throw StateError(description);
}

void main() {
  final result = asMap(
    decodeContract({
      'page': 'admin.pages.stockOpname.index',
      'data': {
        'matrix': {
          '_type': 'collection',
          'items': [
            {
              'sizes': {
                '_type': 'collection',
                'items': {
                  'M': {'system': 8, 'warehouse': 10, 'difference': 2},
                },
              },
            },
          ],
        },
        'orders': {
          '_type': 'pagination',
          'items': [
            {
              '_type': 'record',
              'fields': {
                'id': 42,
                'created_at': {
                  '_type': 'datetime',
                  'iso': '2026-11-20T01:00:00Z',
                },
              },
            },
          ],
          'total': 27,
          'per_page': 10,
          'current_page': 2,
          'page_name': 'p',
        },
      },
    }),
  );
  final data = asMap(result['data']);
  final matrix = records(data['matrix']);
  expect(
    whole(asMap(asMap(matrix.single['sizes'])['M'])['difference']) == 2,
    'Preserve keyed size collections',
  );
  final orders = data['orders'] as PageSlice;
  expect(
    orders.lastPage == 3 && orders.page == 2 && orders.pageName == 'p',
    'Preserve pagination state',
  );
  expect(idOf(records(orders).single) == '42', 'Decode record fields');
  expect(
    DateTime.tryParse(text(records(orders).single['created_at'])) != null,
    'Decode ISO dates',
  );
  expect(money('-23450000.5') == '-Rp 23.450.001', 'Format Indonesian prices');
  expect(
    paymentLabel('verified') == 'Terverifikasi',
    'Use verified status label',
  );
  expect(
    clientPath('https://app.test/profile?value=A%20B') ==
        '/profile?value=A%20B',
    'Preserve client links',
  );
  expect(
    clientPath('//outside.test/admin') == null,
    'Ignore protocol-relative links',
  );

  final address = Uri.parse('https://api.test/api/v1/');
  final endpoint = endpointUri(address, '/admin/sales-report/export?period=7', {
    'page': '2',
  });
  expect(
    endpoint.path == '/api/v1/admin/sales-report/export',
    'Keep API prefix',
  );
  expect(
    endpoint.queryParameters['period'] == '7' &&
        endpoint.queryParameters['page'] == '2',
    'Merge query parameters',
  );
  try {
    endpointUri(address, '//outside.test/api/v1/login');
    throw StateError('Absolute destinations must fail.');
  } on ArgumentError {
    // Only first-party API paths may receive a bearer token.
  }
  final fields = multipartFields({
    'items': {
      '42': {'qty_m': 3},
    },
    'notify_members': true,
    'size_stocks': {'M': 6},
    'photos': ['a', 'b'],
    'empty': null,
  });
  expect(fields['items[42][qty_m]'] == '3', 'Encode nested Laravel forms');
  expect(
    fields['size_stocks[M]'] == '6' && fields['photos[1]'] == 'b',
    'Encode sizes and lists',
  );
  expect(
    fields['notify_members'] == '1' && !fields.containsKey('empty'),
    'Encode booleans and omit nulls',
  );
  print('Kontrak Flutter lulus.');
}
