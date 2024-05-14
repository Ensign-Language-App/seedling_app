import 'package:flutter/material.dart';
import 'package:seedling_app/screens/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: const Color(0xFFE9E9E9),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.green,
            backgroundColor: Colors.white,
            elevation: 20,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage()
    );
  }
}
