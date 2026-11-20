import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/app/motifnesia_app.dart';

void main() {
  testWidgets('Katalog bisa dibuka pada viewport mobile', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final api = MotifnesiaApi(
      client: MockClient((request) async {
        expect(request.url.path, '/api/v1/homePage');
        return http.Response(
          jsonEncode({
            'page': 'customer.pages.homePage',
            'data': {
              'products': {
                '_type': 'collection',
                'items': [
                  {
                    'id': 1,
                    'nama': 'Batik Tulis Uji',
                    'harga': 150000,
                    'stok': 5,
                  },
                ],
              },
              'slides': {'_type': 'collection', 'items': []},
              'filterOptions': {},
            },
            'viewer': null,
          }),
          200,
          headers: {'Content-Type': 'application/json'},
        );
      }),
    );

    await tester.pumpWidget(MotifnesiaApp(api: api));
    await tester.pumpAndSettle();
    expect(find.text('Batik Nusantara'), findsOneWidget);
    expect(find.text('Batik Tulis Uji'), findsOneWidget);
    expect(find.text('Keranjang'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
