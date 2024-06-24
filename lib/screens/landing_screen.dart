import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import '../controllers/home_page_controller.dart';

void main() => runApp(const MaterialApp(home: LandingScreen()));

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;
  bool _showAuthState = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showAuthState = true;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showAuthState) {
      return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return const HomePageController();
          } else {
            return const LogInPage();
          }
        },
      );
    } else {
      return Scaffold(
        body: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // colors: const [Color(0xFFfff3b0), Color(0xFF57cc99)],
                  colors: const [Color(0xFFfff3b0), Color(0xFFff964f)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  transform: GradientRotation(_animation.value * 3.14 * 2),
                ),
              ),
              child: child,
            );
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Image(
                  image: AssetImage('assets/icons/Seedling_icon4.png'),
                  width: 250,
                  height: 250,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
