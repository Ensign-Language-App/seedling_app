import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LanguagesSelectionPage()));

class LanguagesSelectionPage extends StatelessWidget {
  const LanguagesSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Language'),
        centerTitle: true, // Center the title
      ),
      body: Container(
        color: Colors.yellow, // Yellow background
        padding: const EdgeInsets.symmetric(
            vertical: 40.0), // Padding to center vertically
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: <Widget>[
            LanguageTile(
              imagePath: 'assets/icons/flags/France_flag.png',
              language: 'French',
            ),
            LanguageTile(
              imagePath: 'assets/icons/flags/Spain_flag.png',
              language: 'Spanish',
            ),
            LanguageTile(
              imagePath: 'assets/icons/flags/Portugal_flag.png',
              language: 'Portuguese',
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String imagePath;
  final String language;

  const LanguageTile(
      {super.key, required this.imagePath, required this.language});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO: Handle language selection
        // TODO: REMOVE PRINT STATEMENT AT PRODUCTION
        debugPrint('Selected $language');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0, horizontal: 16.0), // Padding around each tile
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 2 / 5,
              child: Image.asset(
                imagePath,
                width: 50, // Adjust icon size
                height: 50,
              ),
            ),
            Expanded(
              child: Text(
                language,
                style: const TextStyle(
                  fontSize: 24, //  text size
                  fontWeight: FontWeight.bold, // Bold text
                ),
                textAlign: TextAlign.left, // Align  left
              ),
            ),
          ],
        ),
      ),
    );
  }
}
