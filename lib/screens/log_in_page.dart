// ignore_for_file: use_build_context_synchronously, avoid_print, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/controllers/user_controller.dart';
import 'package:seedling_app/controllers/home_page_controller.dart';
import 'package:seedling_app/screens/registration_page.dart';
import 'package:flutter/services.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  var textStatePass = true;
  var eyeConColor = Colors.grey;
  var eyeCon = Icons.visibility_off;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).canvasColor;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final signUpColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Stack(
        children: [
          _buildAnimatedGradientBackground(),
          _buildFormContainer(context, backgroundColor, signUpColor),
        ],
      ),
    );
  }

  Widget _buildAnimatedGradientBackground() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFFff964f), Color(0xFFFFF3B0)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              transform: GradientRotation(_animation.value * 3.14 * 2),
            ),
          ),
          child: child,
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(top: 60.0, left: 22),
        child: Text(
          'Hello there!\nSign in',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFormContainer(
      BuildContext context, Color backgroundColor, Color signUpColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: backgroundColor,
        ),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildTextField(
                  emailController, 'Username/E-mail', Icons.check, false),
              const SizedBox(height: 20),
              _buildTextField(passwordController, 'Password', null, true),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    //TODO: ADD NAVIGATION TO FORGOT PASSWORD PAGE
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Color(0xFFff964f)),
                    ),
                  )),
              const SizedBox(height: 40),
              _buildSignInButton("SIGN IN", _signInWithEmail),
              const SizedBox(height: 20),
              const Text("Or continue with"),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 40,
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: _signInWithGoogle,
                        child: const Image(
                          height: 25,
                          width: 25,
                          image: AssetImage("assets/icons/Google_icon.png")
                        )
                      ),
                      GestureDetector(
                        onTap: _signInWithApple,
                        child: const Icon(IconData(0xf04be, fontFamily: 'MaterialIcons'))
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 70),
              _buildSignUpLink(context, signUpColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      IconData? icon, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        label: Text(
          labelText,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFFff964f)),
        ),
      ),
    );
  }

  Widget _buildSignInButton(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFff964f), Color(0xFFFFF3B0)],
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context, Color signUpColor) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const RegistrationPage(),
        ));
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Text(
              "Sign up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: signUpColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmail() async {
    final userController = Provider.of<UserController>(context, listen: false);
    await userController.signInWithEmailAndPassword(
        emailController.text.trim(), passwordController.text.trim());

    if (userController.user != null && mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePageController(),
      ));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email or password is incorrect'),
        ),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final userController =
          Provider.of<UserController>(context, listen: false);
      await userController.signInWithGoogle();
      if (userController.user != null && mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePageController(),
        ));
      }
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login cancelled"),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  Future<void> _signInWithApple() async {
    try {
      final userController =
          Provider.of<UserController>(context, listen: false);
      await userController.signInWithApple();
      if (userController.user != null && mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePageController(),
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login cancelled" ?? e.message ?? 'An error occurred'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  void _continueWithoutLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomePageController(),
    ));
  }
}
