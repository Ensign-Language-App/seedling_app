import 'package:flutter/material.dart';

class LanguagesScreen extends StatelessWidget {

  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Language'),
        centerTitle: true, // Center the title
      ),
      body: Container(
        color: Colors.yellow, // Yellow background
        padding: const EdgeInsets.symmetric(vertical: 40.0), // Padding to center vertically
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
              imagePath: 'assets/icons/flags/Brazil_flag.png',
              language: 'Portuguese',
            ),
            LanguageTile(
              imagePath: 'assets/icons/flags/Germany_flag.png',
              language: 'German',
            ),
            LanguageTile(
              imagePath: 'assets/icons/flags/Japan_flag.png',
              language: 'Japanese',
            ),
            LanguageTile(
              imagePath: 'assets/icons/flags/China_flag.png',
              language: 'Chinese',
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

  const LanguageTile({super.key, required this.imagePath, required this.language});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle language selection
        debugPrint('Selected $language');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // Padding around each tile
        child: Row(
          children: [
            const Spacer(flex: 1), // Spacer to push the icon to the second third
            SizedBox(
              width: 50, // Fixed icon size
              height: 50,
              child: Image.asset(
                imagePath,
                width: 50, // Adjust icon size
                height: 50,
              ),
            ),
            const SizedBox(width: 10), // Space between icon and text
            Expanded(
              flex: 2,
              child: Text(
                language,
                style: const TextStyle(
                  fontSize: 24, // Text size
                  fontWeight: FontWeight.bold, // Bold text
                ),
                textAlign: TextAlign.left, // Align left
              ),
            ),
          ],
        ),
      ),
    );
  }
}
