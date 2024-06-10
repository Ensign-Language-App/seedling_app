import 'package:flutter/material.dart';
import 'package:seedling_app/screens/registration_page.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MaterialApp(home: LogInPage()));

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
              colors: const [Color(0xFF57cc99), Color.fromARGB(255, 196, 202, 144)],
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
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 60),
              _buildTextField('Username/E-mail', Icons.check, false),
              const SizedBox(height: 20),
              _buildTextField('Password', Icons.visibility_off, true),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color.fromARGB(255, 182, 216, 131),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              _buildSignInButton(context),
              const SizedBox(height: 150),
              _buildSignUpLink(context, signUpColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData icon, bool obscureText) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: Icon(icon, color: Colors.grey),
        label: Text(
          labelText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 196, 202, 144),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      child: Container(
        height: 55,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFF57cc99), Color.fromARGB(255, 196, 202, 144)],
          ),
        ),
        child: const Center(
          child: Text(
            'SIGN IN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrationPage()),
        );
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
// import 'auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LogInPage extends StatefulWidget {
//   const LogInPage({super.key});

//   @override
//   _LogInPageState createState() => _LogInPageState();
// }

// class _LogInPageState extends State<LogInPage> {
//   final Auth _auth = Auth();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final backgroundColor = Theme.of(context).canvasColor;
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final signUpColor = isDarkMode ? Colors.white : Colors.black;

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

// void main() {
//   runApp(const MaterialApp(
//     home: LogInPage(),
//   ));
// }
