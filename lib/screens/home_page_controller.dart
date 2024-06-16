import 'package:flutter/material.dart';
import 'package:seedling_app/screens/bookmark_page.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/screens/learn_page.dart';
import 'package:seedling_app/widgets/bottom_nav_bar.dart';
import 'package:seedling_app/widgets/side_menu.dart';
import 'package:seedling_app/widgets/top_nav_bar.dart';

class HomePageController extends StatefulWidget {

  const HomePageController({super.key});

  @override
  State<HomePageController> createState() => HomeControllerState();
}

class HomeControllerState extends State<HomePageController> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  List<String> pageNames = ['Home', 'Learn', 'Bookmark'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: TopNavBar(title: pageNames[_currentIndex]),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePage(),
          LearningPage(),
          BookmarkPage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex, pageController: _pageController),
    );
  }
}