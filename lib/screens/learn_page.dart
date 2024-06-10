import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 150, 79, 1.0),  // Using RGB values
      appBar: AppBar(title: const Text('Learn')),
      body: Center(
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          front: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 200,
              width: 300,
              alignment: Alignment.center,
              child: const Text(
                'Question',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          back: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              height: 200,
              width: 300,
              alignment: Alignment.center,
              child: const Text(
                'Answer',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
