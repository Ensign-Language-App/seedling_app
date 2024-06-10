import 'package:flutter/material.dart';
import 'package:seedling_app/Widgets/bottom_nav_bar.dart';
import 'package:seedling_app/Widgets/top_nav_bar.dart';
import 'package:seedling_app/Widgets/side_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: const Color(0xFFD1DC6E),
              child: const Center(child: Text('Section 1')),
            ),
            Container(
              height: 200,
              color: const Color(0xFFABB178),
              child: const Center(child: Text('Section 2')),
            ),
            Container(
              height: 200,
              color: const Color(0xFF9FA377),
              child: const Center(child: Text('Section 3')),
            ),
            Container(
              height: 200,
              color: const Color(0xFF8D8F77),
              child: const Center(child: Text('Section 4')),
            ),
            Container(
              height: 200,
              color: const Color(0xFF76776D),
              child: const Center(child: Text('Section 5')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
