import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/Widgets/bottom_nav_bar.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/screens/learn_page.dart';
import 'package:seedling_app/utilities/theme.dart';
import 'package:seedling_app/providers/theme_provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: const MyApp(),
  ),
);

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      theme: themeNotifier.isDarkMode ? darkMode : lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/learn': (context) => const LanguageLearningApp(),
      },
    );
  }
}
