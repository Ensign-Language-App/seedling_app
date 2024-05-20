import 'package:flutter/material.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/utilities/theme.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightMode,
        darkTheme: darkMode,
        debugShowCheckedModeBanner: false,
        home: const HomePage()
    );
  }
}