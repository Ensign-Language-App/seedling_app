import 'package:flutter/material.dart';
import 'package:seedling_app/screens/registration_page.dart';
import 'package:seedling_app/screens/home_page.dart';


class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).canvasColor;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final signUpColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 24, 143, 57),
                Color.fromARGB(255, 97, 168, 112),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Hello there\nSign in',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.check, color: Colors.grey),
                          label: Text('Username/E-mail', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 17, 109, 75),
                          ),)
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                          label: Text('Password', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 17, 109, 75),
                          ),)
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password?', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromARGB(255, 35, 215, 149),
                      ),),
                    ),
                    const SizedBox(height: 70,),
                    GestureDetector(
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
                              colors: [
                                Color.fromARGB(255, 35, 168, 56),
                                Color.fromARGB(255, 57, 148, 89),
                              ]
                          ),
                        ),
                        child: const Center(child: Text('SIGN IN', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,),
                        ),),
                      ),
                    ),
                    const SizedBox(height: 150,),
                    GestureDetector(
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
                            const Text ("Don't have an account?", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),),
                            Text ("Sign up", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: signUpColor
                            ),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LogInPage(),
  ));
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




