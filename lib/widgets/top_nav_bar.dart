import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/language_selector.dart';
import '../screens/learn_page.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      actions: <Widget>[
        const SizedBox(width: 50, child: LanguageSelector()),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LearningPage()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void main() => runApp(const MaterialApp(home: Scaffold(body: TopNavBar())));
