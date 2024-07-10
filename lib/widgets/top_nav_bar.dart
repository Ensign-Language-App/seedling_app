import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/language_selector.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) onLanguageChanged;  // Add this line

  const TopNavBar({super.key, required this.title, required this.onLanguageChanged});  // Update constructor

  @override
  TopNavBarState createState() => TopNavBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TopNavBarState extends State<TopNavBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        LanguageSelector(
          width: 50,
          height: 50,
          onLanguageChanged: widget.onLanguageChanged,  // Pass the callback here
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}
