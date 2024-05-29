import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget{
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void main() => runApp(const MaterialApp(home: Scaffold(body: TopNavBar())));