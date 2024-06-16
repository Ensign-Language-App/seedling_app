import 'package:flutter/material.dart';

void main() => runApp(const BookmarkPage());


class BookmarkPage extends StatefulWidget {

  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => BookmarkPageState();
}

class BookmarkPageState extends State<BookmarkPage> {
  List<String> bookmarks = ['Bookmark 1', 'Bookmark 2', 'Bookmark 3'];

  void _deleteBookmark(int index) {
    setState(() {
      bookmarks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: bookmarks.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox(
              height: 20.0,
            );
          }
          return ListTile(
            title: Text(bookmarks[index - 1]),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () => _deleteBookmark(index - 1),
            ),
          );
        },
      ),

      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
