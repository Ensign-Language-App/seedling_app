import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.light,
    primary: const Color(0xFFF8B178),
    primaryContainer: Colors.grey[700],
    secondary: const Color(0xFFF8B178),
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.dark,
    primary: const Color(0xFFFFDFAF),
    primaryContainer: Colors.grey[700],
    secondary: const Color(0xFFE3B35B),
  ),
);
