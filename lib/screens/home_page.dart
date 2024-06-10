import 'package:flutter/material.dart';
import 'package:seedling_app/Widgets/bottom_nav_bar.dart';
import 'package:seedling_app/Widgets/top_nav_bar.dart';
import 'package:seedling_app/Widgets/side_menu.dart';
import 'package:seedling_app/widgets/lesson_button.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            const LessonButton(
              image: 'assets/images/lessons/seeds.png',
              number: '2',
              title: '2',
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/images/lessons/sprouts.png',
                  number: '3',
                  title: '3',
                  color: Colors.blue,
                ),
                LessonButton(
                  image: 'assets/images/lessons/flower.png',
                  number: '4',
                  title: '4',
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const LessonButton(
              image: 'assets/icons/flags/US_flag.png',
              number: '2',
              title: '2',
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/icons/flags/UK_flag.png',
                  number: '3',
                  title: '3',
                  color: Colors.blue,
                ),
                LessonButton(
                  image: 'assets/icons/flags/Germany_flag.png',
                  number: '4',
                  title: '4',
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const LessonButton(
              image: 'assets/icons/flags/US_flag.png',
              number: '2',
              title: '2',
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/icons/flags/UK_flag.png',
                  number: '3',
                  title: '3',
                  color: Colors.blue,
                ),
                LessonButton(
                  image: 'assets/icons/flags/Germany_flag.png',
                  number: '4',
                  title: '4',
                  color: Colors.green,
                ),
              ],
            ),
            Container(
              height: 200,
            ),
            // Container(
            //   height: 200,
            //   color: const Color(0xFF9FA377),
            //   child: const Center(child: Text('Section 3')),
            // ),
            // Container(
            //   height: 200,
            //   color: const Color(0xFF8D8F77),
            //   child: const Center(child: Text('Section 4')),
            // ),
            // Container(
            //   height: 200,
            //   color: const Color(0xFF76776D),
            //   child: const Center(child: Text('Section 5')),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}