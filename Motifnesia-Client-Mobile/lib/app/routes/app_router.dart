import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/admin_routes.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/app/routes/auth_routes.dart';
import 'package:motifnesia_mobile/app/routes/customer_routes.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/app/routes/supplier_routes.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/session/session_controller.dart';
import 'package:motifnesia_mobile/shared/widgets/layout_blocks.dart';

const _routes = [
  ...customerRoutes,
  ...authRoutes,
  ...adminRoutes,
  ...supplierRoutes,
];

class AppRouter {
  const AppRouter({required this.session, required this.toggleTheme});

  final SessionController session;
  final VoidCallback toggleTheme;

  Route<void> onGenerateRoute(RouteSettings settings) {
    final path = clientPath(settings.name) ?? '/';
    return MaterialPageRoute<void>(
      settings: RouteSettings(name: path, arguments: settings.arguments),
      builder: (_) => ListenableBuilder(
        listenable: session,
        builder: (context, _) => _buildPage(context, path),
      ),
    );
  }

  Widget _buildPage(BuildContext context, String path) {
    if (!session.ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var current = path;
    if (current == '/' ||
        (session.signedIn &&
            authRoutes.any((route) => route.route == current))) {
      current = session.home;
    }
    if (current == '/admin/daftar-produk') {
      current = '/admin/product-management';
    }
    if (current == '/homePage' && session.role == 'admin') {
      current = session.home;
    }

    final uri = Uri.parse(current);
    AppRoute? route;
    for (final candidate in _routes) {
      if (candidate.accepts(uri.path)) {
        route = candidate;
        break;
      }
    }

    if (route == null) {
      return FullMessage(
        'Halaman tidak ditemukan',
        onBack: () => replaceStack(context, session.home),
      );
    }

    if (route.role != null && !session.signedIn) {
      return loginRoute.builder(
        PageArguments(
          route: loginRoute,
          uri: Uri(path: loginRoute.route),
          session: session,
          toggleTheme: toggleTheme,
          nextPath: current,
        ),
      );
    }

    if ((route.role != null && route.role != session.role) ||
        (route.ability != null && !session.allows(route.ability!))) {
      return FullMessage(
        'Halaman ini tidak tersedia untuk peran Anda.',
        onBack: () => replaceStack(context, session.home),
      );
    }

    final menu = switch (session.role) {
      '' || 'customer' => customerRoutes,
      'admin' => adminRoutes,
      _ => supplierRoutes,
    };
    return KeyedSubtree(
      key: ValueKey(current),
      child: route.builder(
        PageArguments(
          route: route,
          uri: uri,
          session: session,
          toggleTheme: toggleTheme,
          menu: menu,
        ),
      ),
    );
  }
}
