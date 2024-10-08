import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'package:seedling_app/providers/language_provider.dart';
import 'package:seedling_app/screens/landing_screen.dart';
import 'package:seedling_app/utilities/theme.dart';
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:seedling_app/providers/color_provider.dart';
import 'package:seedling_app/services/notification_service.dart';
import 'utilities/firebase_options.dart';
import 'providers/progress_provider.dart';
import 'utilities/app_globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => NotificationService()), // Initialize NotificationService here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
    progressProvider.loadProgressFromFirestore();

    return MaterialApp(
      navigatorKey: globalKey,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const LandingScreen(),
    );
  }
}
