import 'package:flutter/material.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/screens/learn_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();

}

class BottomNavBarState extends State<BottomNavBar> {
  int activeIndex = 0;

  List<Widget> pages = const [
    HomePage(),
    LearningPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: activeIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Learn',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          label: 'Bookmark',
        ),
      ],
      onTap: (int index) {
        if (index != activeIndex) {
          setState(() {
            activeIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pages[activeIndex],
            ),
          ).then((_) {
            setState(() {
              activeIndex = 0;
            });
          });
        }
      },
    );
  }
}
