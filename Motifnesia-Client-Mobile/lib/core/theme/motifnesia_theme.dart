import 'package:flutter/material.dart';

const _gold = Color(0xffc9a84c);
const _ink = Color(0xff111111);
ThemeData motifnesiaTheme(Brightness brightness, {required bool staff}) {
  final dark = brightness == Brightness.dark;
  final colors = ColorScheme.fromSeed(
    seedColor: _gold,
    brightness: brightness,
    primary: dark ? _gold : const Color(0xff75590b),
    surface: dark
        ? (staff ? const Color(0xff1e293b) : const Color(0xff181818))
        : (staff ? Colors.white : const Color(0xfffffdf8)),
    onSurface: dark ? const Color(0xfff5f1e8) : const Color(0xff241f18),
  );
  final base = ThemeData(useMaterial3: true, colorScheme: colors);
  return base.copyWith(
    scaffoldBackgroundColor: dark
        ? (staff ? const Color(0xff0f172a) : _ink)
        : (staff ? const Color(0xfff1f5f9) : const Color(0xfff8f5ee)),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      color: colors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.outlineVariant.withValues(alpha: .46)),
      ),
    ),
    textTheme: base.textTheme.copyWith(
      headlineMedium: base.textTheme.headlineMedium?.copyWith(
        fontFamily: 'serif',
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: base.textTheme.headlineSmall?.copyWith(
        fontFamily: 'serif',
        fontWeight: FontWeight.w700,
      ),
      titleMedium: base.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.45),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(minimumSize: const Size(48, 48)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surfaceContainerLow,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 68,
      backgroundColor: colors.surface,
      indicatorColor: colors.primaryContainer,
    ),
  );
}
