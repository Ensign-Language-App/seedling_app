import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 115, 250, 138), // Set background color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              child: Image.asset(
                'assets/seedling.png', // Path to the image file
                width: 100, // Adjust the width as needed
                height: 100, // Adjust the height as needed
              ),
            ),
            const SizedBox(
                height: 20), // Adding some space between the image and text
            const Text(
              'Seedling',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const Text(
              'The Language Learning App',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
