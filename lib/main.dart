import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/screens/landing_screen.dart';
import 'package:seedling_app/utilities/theme.dart';
import 'package:seedling_app/providers/theme_notifier.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      theme: themeNotifier.isDarkMode ? darkMode : lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: const LandingScreen()
    );
  }
}
