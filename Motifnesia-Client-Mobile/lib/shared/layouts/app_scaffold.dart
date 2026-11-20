import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_route.dart';
import 'package:motifnesia_mobile/app/routes/navigation.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/core/session/session_controller.dart';
import 'package:motifnesia_mobile/shared/widgets/brand.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.arguments, required this.body});

  final PageArguments arguments;
  final Widget body;
  SessionController get session => arguments.session;
  String get path => arguments.uri.path;
  VoidCallback get toggleTheme => arguments.toggleTheme;

  @override
  Widget build(BuildContext context) {
    final guestOrCustomer = session.role.isEmpty || session.role == 'customer';
    final alertPath = session.role == 'admin'
        ? '/admin/notifications'
        : '/notifications';
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop() ? const BackButton() : null,
        titleSpacing: 12,
        title: path == '/homePage'
            ? const Brand()
            : Text(arguments.route.title),
        actions: [
          if (session.signedIn && session.role != 'supplier')
            IconButton(
              tooltip: 'Notifikasi',
              onPressed: () => openPage(context, alertPath),
              icon: const Icon(Icons.notifications_outlined),
            ),
          IconButton(
            tooltip: 'Ganti tema',
            onPressed: toggleTheme,
            icon: const Icon(Icons.brightness_6_outlined),
          ),
        ],
      ),
      drawer: _drawer(context),
      bottomNavigationBar: guestOrCustomer ? _bottomBar(context) : null,
      body: body,
    );
  }

  Widget _bottomBar(BuildContext context) {
    const tabs = [
      ('/homePage', 'Beranda', Icons.home_outlined, Icons.home),
      ('/favorites', 'Favorit', Icons.favorite_border, Icons.favorite),
      ('/cart', 'Keranjang', Icons.shopping_bag_outlined, Icons.shopping_bag),
      ('/profile', 'Akun', Icons.person_outline, Icons.person),
    ];
    final active = tabs.indexWhere(
      (tab) =>
          tab.$1 == path ||
          (tab.$1 == '/profile' && path.startsWith('/profile/')),
    );
    return NavigationBar(
      selectedIndex: active < 0 ? 0 : active,
      destinations: [
        for (final tab in tabs)
          NavigationDestination(
            icon: Icon(tab.$3),
            selectedIcon: Icon(tab.$4),
            label: tab.$2,
          ),
      ],
      onDestinationSelected: (index) {
        final target = tabs[index].$1;
        if (path != target) replaceStack(context, target);
      },
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const Padding(padding: EdgeInsets.all(12), child: Brand()),
            if (session.signedIn)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Text(
                  text(
                    session.viewer['full_name'],
                    text(session.viewer['name'], 'Akun'),
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            const Divider(),
            for (final screen in arguments.menu)
              if (screen.showInDrawer &&
                  !screen.route.contains(':id') &&
                  (screen.ability == null || session.allows(screen.ability!)))
                ListTile(
                  leading: Icon(screen.icon),
                  title: Text(screen.title),
                  selected: screen.route == path,
                  onTap: () {
                    Navigator.pop(context);
                    if (screen.route != path)
                      replaceStack(context, screen.route);
                  },
                ),
            ListTile(
              leading: Icon(session.signedIn ? Icons.logout : Icons.login),
              title: Text(session.signedIn ? 'Keluar' : 'Masuk'),
              onTap: () async {
                Navigator.pop(context);
                if (!session.signedIn) {
                  if (context.mounted) openPage(context, '/login');
                  return;
                }
                try {
                  await session.logout();
                } on ApiFailure {
                  // The local session is cleared even when the server is unreachable.
                }
                if (context.mounted) replaceStack(context, '/homePage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
