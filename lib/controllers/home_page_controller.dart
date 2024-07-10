import 'package:flutter/material.dart';
import 'package:seedling_app/screens/bookmark_page.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/screens/review_page.dart';
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
  List<String> pageNames = ['Home', 'Review', 'Bookmark'];

  String selectedLanguage = 'English';  // Add this line

  // Method to handle language change
  void onLanguageChanged(String language) {
    setState(() {
      selectedLanguage = language;
    });
    // Any additional logic to handle the language change can be added here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: TopNavBar(
        title: pageNames[_currentIndex],
        onLanguageChanged: onLanguageChanged, // Pass the callback here
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          HomePage(selectedLanguage: selectedLanguage),  // Pass selected language to HomePage
          ReviewPage(selectedLanguage: selectedLanguage),  // Pass selected language to ReviewPage
          BookmarkPage(selectedLanguage: selectedLanguage),  // Pass selected language to BookmarkPage
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        pageController: _pageController,
      ),
    );
  }
}
