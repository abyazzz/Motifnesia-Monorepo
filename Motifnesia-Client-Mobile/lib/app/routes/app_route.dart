import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/session/session_controller.dart';

class AppRoute {
  const AppRoute(
    this.route,
    this.title,
    this.icon,
    this.builder, {
    this.role,
    this.ability,
    this.showInDrawer = true,
  });

  final String route;
  final String title;
  final IconData icon;
  final Widget Function(PageArguments) builder;
  final String? role;
  final String? ability;
  final bool showInDrawer;

  bool accepts(String path) {
    final declared = Uri.parse(route).pathSegments;
    final requested = Uri.parse(path).pathSegments;
    if (declared.length != requested.length) return false;
    for (var i = 0; i < declared.length; i++) {
      if (declared[i] == ':id') {
        if (int.tryParse(requested[i]) == null) return false;
      } else if (declared[i] != requested[i]) {
        return false;
      }
    }
    return true;
  }
}

class PageArguments {
  const PageArguments({
    required this.route,
    required this.uri,
    required this.session,
    required this.toggleTheme,
    this.menu = const [],
    this.nextPath,
  });

  final AppRoute route;
  final Uri uri;
  final SessionController session;
  final VoidCallback toggleTheme;
  final List<AppRoute> menu;
  final String? nextPath;
}
