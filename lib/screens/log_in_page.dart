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
              colors: const [
                // Color(0xFF57cc99),
                Color(0xFFff964f),
                // Color.fromARGB(255, 196, 202, 144)
                Color(0xFFFFF3B0)
              ],
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
              _buildTextFieldUN('Username/E-mail', Icons.check, false),
              const SizedBox(height: 20),
              _buildTextFieldPass('Password'),
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
                          // color: Color.fromARGB(255, 182, 216, 131),
                          color: Color(0xFFff964f)),
                    ),
                  )),
              const SizedBox(height: 70),
              //TODO: INTEGRATE 'SIGN IN' WITH FIRESTORE
              _buildSignInButton("SIGN IN", () async {
                try {
                  final userController =
                      Provider.of<UserController>(context, listen: false);
                  await userController.signInWithEmailAndPassword(
                      'email', 'password');
                  if (userController.user != null && mounted) {
                    // TODO: REPLACE THE COMMENT BELOW WITH CORRECT LOGIC
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePageController(),
                    ));
                  }
                } on FirebaseAuthException catch (e) {
                  //TODO: REMOVE PRINT ON PRODUCTION
                  print(e.message);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message ?? 'An error occurred'),
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
              }),
              const SizedBox(height: 10),
              _buildSignInButton("CONTINUE WITH GOOGLE", () async {
                try {
                  final userController =
                      Provider.of<UserController>(context, listen: false);
                  await userController.signInWithGoogle();
                  if (userController.user != null && mounted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePageController(),
                    ));
                  }
                } on FirebaseAuthException catch (e) {
                  //TODO: REMOVE PRINT ON PRODUCTION
                  print(e.message);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.message ?? 'An error occurred'),
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
              }),
              const SizedBox(height: 10),
              _buildSignInButton('CONTINUE WITHOUT LOGIN', () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomePageController(),
                ));
              }),
              const SizedBox(height: 70),
              _buildSignUpLink(context, signUpColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldUN(String labelText, IconData icon, bool obscureText) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: Icon(icon, color: Colors.grey),
        label: Text(
          labelText,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              // color: Color.fromARGB(255, 196, 202, 144),
              color: Color(0xFFff964f)),
        ),
      ),
    );
  }

  Widget _buildTextFieldPass(String labelText) {
    void toggleObscureText() {
      setState(() {
        textStatePass = !textStatePass;
        if (eyeConColor == Colors.grey) {
          eyeConColor = Colors.green;
          eyeCon = Icons.visibility;
        } else {
          eyeConColor = Colors.grey;
          eyeCon = Icons.visibility_off;
        }
      });
    }

    return TextField(
      obscureText: textStatePass,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(eyeCon, color: eyeConColor),
            onPressed: toggleObscureText),
        label: Text(
          labelText,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              // color: Color.fromARGB(255, 196, 202, 144),
              color: Color(0xFFff964f)),
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
            // colors: [Color(0xFF57cc99), Color.fromARGB(255, 196, 202, 144)],
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
}

// TESTING FOR AUTHENTICATION
// import 'package:flutter/material.dart';
// import 'package:seedling_app/screens/registration_page.dart';
// import 'package:seedling_app/screens/home_page.dart';
// import 'package:seedling_app/utilities/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class LogInPage extends StatefulWidget {
//   const LogInPage({super.key});
//
//   @override
//   _LogInPageState createState() => _LogInPageState();
// }
//
// class _LogInPageState extends State<LogInPage> {
//   final Auth _auth = Auth();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final backgroundColor = Theme.of(context).canvasColor;
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final signUpColor = isDarkMode ? Colors.white : Colors.black;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 Color.fromARGB(255, 17, 109, 75),
//                 Color.fromARGB(255, 35, 215, 149),
//               ]),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.only(top: 60.0, left: 22),
//               child: Text(
//                 'Hello there\nSign in',
//                 style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 200.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//                 color: backgroundColor,
//               ),
//               height: double.infinity,
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 8.0, right: 18.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(
//                         suffixIcon: Icon(Icons.check, color: Colors.grey),
//                         label: Text(
//                           'Username/E-mail',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 17, 109, 75),
//                           ),
//                         ),
//                       ),
//                     ),
//                     TextField(
//                       controller: _passwordController,
//                       decoration: const InputDecoration(
//                         suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
//                         label: Text(
//                           'Password',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 17, 109, 75),
//                           ),
//                         ),
//                       ),
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 20,),
//                     const Align(
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         'Forgot Password?',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17,
//                           color: Color.fromARGB(255, 35, 215, 149),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 70,),
//                     GestureDetector(
//                       onTap: () async {
//                         User? result = await _auth.signInWithEmailAndPassword(
//                           _emailController.text, _passwordController.text);
//                         if (result != null) {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => const HomePage()),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Login failed')),
//                           );
//                         }
//                       },
//                       child: Container(
//                         height: 55,
//                         width: 300,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 17, 109, 75),
//                               Color.fromARGB(255, 35, 215, 149),
//                             ],
//                           ),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             'SIGN IN',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 150,),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const RegistrationPage()),
//                         );
//                       },
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             const Text(
//                               "Don't have an account?",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             Text(
//                               "Sign up",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17,
//                                 color: signUpColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(const MaterialApp(
//     home: LogInPage(),
//   ));
// }
