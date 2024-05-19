import 'package:flutter/material.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/screens/registration_page.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 17, 109, 75),
                Color.fromARGB(255, 35, 215, 149),
              ]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 22),
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.check, color: Colors.grey),
                        label: Text('Username/E-mail', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 109, 75),
                        ),)
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                        label: Text('Password', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 109, 75),
                        ),)
                      ),
                    ),
                    SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password?', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color.fromARGB(255, 35, 215, 149),
                        ),),
                    ),
                    SizedBox(height: 70,),
                    Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                              Color.fromARGB(255, 17, 109, 75),
                Color.fromARGB(255, 35, 215, 149),
                          ]
                        ),
                      ),
                      child: Center(child: Text('SIGN IN', style: TextStyle( 
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,),
                      ),),
                    ),
                    SizedBox(height: 150,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text ("Don't have an account?", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),),
                          Text ("Sign up", style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black
                          ),),
                        ],
                      )
                      )
                  ],
                  ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
