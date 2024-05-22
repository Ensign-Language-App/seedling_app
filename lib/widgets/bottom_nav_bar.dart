import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget{
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Learn'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark),
            label: 'Bookmark'
          ),
        ],
    );
  }
}

void main() => runApp(const MaterialApp(home:Scaffold(body:BottomNavBar())));
