import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/screens/bookmark_page.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/screens/review_page.dart';
import 'package:seedling_app/widgets/bottom_nav_bar.dart';
import 'package:seedling_app/widgets/side_menu.dart';
import 'package:seedling_app/widgets/top_nav_bar.dart';
import 'package:seedling_app/providers/language_provider.dart';
import 'package:seedling_app/providers/progress_provider.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({super.key});

  @override
  State<HomePageController> createState() => HomeControllerState();
}

class HomeControllerState extends State<HomePageController> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  List<String> pageNames = ['Home', 'Review', 'Bookmark'];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeUserPreferences();
  }

  Future<void> _initializeUserPreferences() async {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);

    // Load user-specific preferences
    await languageProvider.loadPreferences();
    await progressProvider.loadProgressFromFirestore();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
          ReviewPage(),
          BookmarkPage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        pageController: _pageController,
      ),
    );
  }
}
