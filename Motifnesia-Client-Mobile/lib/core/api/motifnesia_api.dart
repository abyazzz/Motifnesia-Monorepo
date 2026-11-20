import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:motifnesia_mobile/core/api/api_contract.dart';

class Attachment {
  const Attachment(this.name, this.bytes);
  final String name;
  final Uint8List bytes;
}

class ApiFailure implements Exception {
  const ApiFailure(this.status, this.message, this.body);
  final int status;
  final String message;
  final Json body;

  String? get redirect => clientPath(body['redirect']);
  Json get errors => asMap(body['errors']);

  @override
  String toString() => message;
}

class MotifnesiaApi {
  MotifnesiaApi({http.Client? client, Uri? baseUrl})
    : _client = client ?? http.Client(),
      base =
          baseUrl ??
          Uri.parse(
            const String.fromEnvironment(
              'MOTIFNESIA_API_URL',
              defaultValue: 'http://127.0.0.1:8000/api/v1',
            ),
          );

  final http.Client _client;
  final Uri base;
  String? token;
  void Function()? onExpired;

  Uri asset(Object? value) {
    final path = text(value);
    final uri = Uri.tryParse(path);
    const configured = String.fromEnvironment('MOTIFNESIA_MEDIA_URL');
    final origin = configured.isEmpty
        ? base.replace(path: '/')
        : Uri.parse(configured);
    if (uri != null &&
        uri.hasAuthority &&
        (uri.scheme == 'https' || uri.scheme == 'http')) {
      if (configured.isNotEmpty && uri.host == base.host) {
        return origin.replace(path: uri.path, query: uri.query);
      }
      return uri;
    }
    return origin.resolve(path);
  }

  Future<Json> get(String path, {Map<String, String>? query}) async =>
      asMap(await request('GET', path, query: query));

  Future<Object?> request(
    String method,
    String path, {
    Json data = const {},
    Map<String, String>? query,
    Map<String, Attachment> files = const {},
  }) async {
    final tokenAtStart = token;
    final response = await _send(
      method,
      path,
      data,
      query,
      files,
      tokenAtStart,
      'application/json',
    );
    final value = _json(response);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final body = asMap(value);
      if (response.statusCode == 401 &&
          tokenAtStart != null &&
          token == tokenAtStart) {
        onExpired?.call();
      }
      final fieldMessages = asMap(body['errors']).values
          .expand((value) => value is List ? value : [value])
          .map((value) => text(value))
          .where((value) => value.isNotEmpty);
      throw ApiFailure(
        response.statusCode,
        fieldMessages.isNotEmpty
            ? fieldMessages.first
            : text(
                body['message'],
                text(
                  body['error'],
                  'Permintaan gagal (${response.statusCode}).',
                ),
              ),
        body,
      );
    }

    final body = asMap(value);
    if (body['success'] == false) {
      throw ApiFailure(
        response.statusCode,
        text(body['message'], text(body['error'], 'Permintaan gagal.')),
        body,
      );
    }
    return decodeContract(value);
  }

  Future<Uint8List> download(String path) async {
    final tokenAtStart = token;
    final response = await _send(
      'GET',
      path,
      const {},
      null,
      const {},
      tokenAtStart,
      '*/*',
    );
    if (response.statusCode == 401 &&
        tokenAtStart != null &&
        token == tokenAtStart) {
      onExpired?.call();
    }
    if (response.statusCode != 200) {
      throw ApiFailure(
        response.statusCode,
        'Berkas tidak dapat dibuka.',
        const {},
      );
    }
    return response.bodyBytes;
  }

  Object? _json(http.Response response) {
    try {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw ApiFailure(
        response.statusCode,
        'Server tidak mengembalikan respons JSON.',
        const {},
      );
    }
  }

  Future<http.Response> _send(
    String method,
    String path,
    Json data,
    Map<String, String>? query,
    Map<String, Attachment> files,
    String? bearer,
    String accept,
  ) async {
    final uri = endpointUri(base, path, query);
    final headers = {
      'Accept': accept,
      if (bearer != null) 'Authorization': 'Bearer $bearer',
    };
    final http.BaseRequest request;
    if (files.isNotEmpty) {
      final multipart =
          http.MultipartRequest(method == 'POST' ? method : 'POST', uri)
            ..fields.addAll(multipartFields(data))
            ..files.addAll(
              files.entries.map(
                (entry) => http.MultipartFile.fromBytes(
                  entry.key,
                  entry.value.bytes,
                  filename: entry.value.name,
                ),
              ),
            );
      if (method != 'POST') multipart.fields['_method'] = method;
      request = multipart;
    } else {
      final json = http.Request(method, uri);
      if (method != 'GET') {
        json.headers['Content-Type'] = 'application/json';
        json.body = jsonEncode(data);
      }
      request = json;
    }
    request.headers.addAll(headers);
    try {
      return await _client
          .send(request)
          .then(http.Response.fromStream)
          .timeout(const Duration(seconds: 30));
    } on Exception {
      throw const ApiFailure(
        0,
        'Server Motifnesia tidak dapat dihubungi. Coba lagi.',
        {},
      );
    }
  }
}
