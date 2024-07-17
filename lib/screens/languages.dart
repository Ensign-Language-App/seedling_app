import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';

class LanguagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Language'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorProvider.gradientStartColor,
              colorProvider.gradientEndColor,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

  const LanguageTile({required this.imagePath, required this.language});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle language selection
        print('Selected $language');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(
            color: Colors.black26,
            width: 2.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 100),
            Expanded(
              child: Text(
                language,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
