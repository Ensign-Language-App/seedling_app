import 'package:seedling_app/screens/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LogInPage()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.lightGreenAccent, Colors.blue])),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Image(
                      image: AssetImage('assets/images/seedling_icon.png'),
                      width: 105,
                      height: 105,
                    )),
                Text(
                  'Seedling',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                )
              ],
            )));
  }
}

void main() => runApp(const MaterialApp(home: LandingScreen()));
