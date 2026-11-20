import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/app/routes/app_router.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';
import 'package:motifnesia_mobile/core/session/session_controller.dart';
import 'package:motifnesia_mobile/core/theme/motifnesia_theme.dart';

class MotifnesiaApp extends StatefulWidget {
  const MotifnesiaApp({super.key, required this.api});
  final MotifnesiaApi api;

  @override
  State<MotifnesiaApp> createState() => _MotifnesiaAppState();
}

class _MotifnesiaAppState extends State<MotifnesiaApp> {
  late final SessionController session = SessionController(widget.api)
    ..restore();
  bool dark = true;
  late final router = AppRouter(
    session: session,
    toggleTheme: () => setState(() => dark = !dark),
  );

  @override
  void dispose() {
    session.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Motifnesia',
        theme: motifnesiaTheme(
          Brightness.light,
          staff: session.role == 'admin' || session.role == 'supplier',
        ),
        darkTheme: motifnesiaTheme(
          Brightness.dark,
          staff: session.role == 'admin' || session.role == 'supplier',
        ),
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        onGenerateInitialRoutes: (initialRoute) => [
          router.onGenerateRoute(RouteSettings(name: initialRoute)),
        ],
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
