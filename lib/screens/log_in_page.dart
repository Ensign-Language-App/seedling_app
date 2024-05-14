import 'package:flutter/material.dart';
import 'package:seedling_app/screens/home_page.dart';

class LogInPage extends StatelessWidget{
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            const Text('Log In Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage())
                );
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}