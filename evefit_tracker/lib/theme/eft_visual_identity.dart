import 'package:flutter/material.dart';

class EftVisualIdentity {
  const EftVisualIdentity._();

  static const landingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF161321),
      Color(0xFF302344),
      Color(0xFF5B486B),
      Color(0xFF927744),
    ],
    stops: [0, 0.34, 0.7, 1],
  );

  static const profileGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF302149), Color(0xFF66547A), Color(0xFFA48650)],
    stops: [0, 0.56, 1],
  );

  static const foreground = Color(0xFFF8FAFC);
  static const secondaryForeground = Color(0xFFD8D3E1);
  static const surface = Color(0xE6171827);
  static const cardSurface = Color(0xF21B2030);
  static const border = Color(0x52D7C9A7);
  static const gold = Color(0xFFE3C681);
  static const circuit = Color(0xFF5C9BC8);
  static const circuitCore = Color(0xFF9DD9F5);
}
