import 'package:flutter/material.dart';
import 'package:seedling_app/Widgets/bottom_nav_bar.dart';
import 'package:seedling_app/Widgets/top_nav_bar.dart';
import 'package:seedling_app/Widgets/side_menu.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: SideMenu(),
      appBar: TopNavBar(),
      body: Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}