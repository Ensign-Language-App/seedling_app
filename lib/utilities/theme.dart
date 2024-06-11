import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.light,
    primary: const Color(0xFFC8D36A),
    primaryContainer: Colors.grey[700],
    secondary: const Color(0xFFD5E647),
  ),
);


ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.dark,
    primary: const Color(0xFFE0FA02),
    primaryContainer: Colors.grey[700],
    secondary: const Color(0xFFE0FA02),
  ),
);