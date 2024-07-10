import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/language_selector.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const TopNavBar({super.key, required this.title});

  @override
  TopNavBarState createState() => TopNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: <Widget>[
        const SizedBox(
            width: 50, child: LanguageSelector(width: 50, height: 50)),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}

void main() =>
    runApp(const MaterialApp(home: Scaffold(body: TopNavBar(title: 'Home'))));
