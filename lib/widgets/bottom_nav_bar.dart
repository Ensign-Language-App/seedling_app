import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final PageController pageController;
  final int currentIndex;

  const BottomNavBar(
      {super.key, required this.pageController, required this.currentIndex});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Review',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          label: 'Bookmark',
        ),
      ],
      onTap: (int index) {
        widget.pageController.jumpToPage(index);
      },
    );
  }
}
