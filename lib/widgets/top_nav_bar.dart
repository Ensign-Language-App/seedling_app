import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/language_selector.dart';

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
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

void main() => runApp(const MaterialApp(home: Scaffold(body: TopNavBar())));
