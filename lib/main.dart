import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/Widgets/bottom_nav_bar.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/screens/learn_page.dart';
import 'package:seedling_app/utilities/theme.dart';
<<<<<<< HEAD
import 'package:seedling_app/providers/theme_provider.dart';
=======
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:provider/provider.dart';
>>>>>>> 20ca6cb81bbacd458b1efca712b824d03a1d16e7

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
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/learn': (context) => const LanguageLearningApp(),
      },
    );
  }
}
