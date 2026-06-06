import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark() {
    const seed = Color(0xFF22C55E);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      cardTheme: const CardThemeData(
        color: Color(0xFF172033),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        filled: true,
        fillColor: Color(0xFF111827),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF111827),
        indicatorColor: seed.withValues(alpha: 0.25),
      ),
    );
  }
}
