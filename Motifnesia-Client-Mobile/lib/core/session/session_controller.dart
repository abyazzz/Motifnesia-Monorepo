import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';

class SessionController extends ChangeNotifier {
  SessionController(this.api) {
    api.onExpired = clear;
  }

  final MotifnesiaApi api;
  static const _storage = FlutterSecureStorage();
  static const _storageKey = 'motifnesia.api.token';
  Json viewer = {};
  bool ready = false;
  bool get signedIn => api.token != null;
  String get role => text(viewer['role']);
  String get home => clientPath(viewer['home']) ?? '/homePage';
  bool allows(String ability) => asList(viewer['abilities']).contains(ability);

  Future<void> restore() async {
    if (!kIsWeb) {
      try {
        api.token = await _storage.read(key: _storageKey);
        if (signedIn) {
          viewer = asMap((await api.get('/viewer'))['viewer']);
          if (viewer.isEmpty) clear();
        }
      } on Exception {
        clear();
      }
    }
    ready = true;
    notifyListeners();
  }

  Future<String> login(Json fields) async {
    final result = asMap(await api.request('POST', '/login', data: fields));
    final token = text(result['token']);
    if (token.isEmpty)
      throw const ApiFailure(0, 'Token masuk tidak tersedia.', {});
    api.token = token;
    viewer = asMap(result['viewer']);
    if (!kIsWeb) unawaited(_persist(token));
    notifyListeners();
    return home;
  }

  void updateViewer(Object? data) {
    final next = asMap(data);
    if (signedIn && next.isNotEmpty && !mapEquals(next, viewer)) {
      viewer = next;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      if (signedIn) await api.request('POST', '/logout');
    } finally {
      clear();
    }
  }

  void clear() {
    api.token = null;
    viewer = {};
    if (!kIsWeb) unawaited(_persist(null));
    notifyListeners();
  }

  Future<void> _persist(String? token) async {
    try {
      if (token == null) {
        await _storage.delete(key: _storageKey);
      } else {
        await _storage.write(key: _storageKey, value: token);
      }
    } on Exception {
      // The session is still usable in memory when the platform keystore is unavailable.
    }
  }

  @override
  void dispose() {
    api.onExpired = null;
    super.dispose();
  }
}
