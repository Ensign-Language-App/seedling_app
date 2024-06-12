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
    return const Scaffold(
      // backgroundColor: const Color.fromRGBO(255, 150, 79, 1.0),  // Using RGB values
      drawer: SideMenu(),
      appBar: TopNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/images/lessons/animals.png',
                  title: 'Animals',
                  lessonColor: Color(0xFF9c6644),
                  stackColor1: Color(0xFF7f5539),
                  stackColor2: Color(0xFFe6ccb2),
                  progress: 1,
                ),
                LessonButton(
                  image: 'assets/images/lessons/greets.png',
                  title: 'Greetings',
                  lessonColor: Color(0xFF8d99ae),
                  stackColor1: Color(0xFF2b2d42),
                  stackColor2: Color(0xFFedf2f4),
                  progress: 0.5,
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/images/lessons/family.png',
                  title: 'Family',
                  lessonColor: Color(0xFF83c5be),
                  stackColor1: Color(0xFF006d77),
                  stackColor2: Color(0xFFb08968),
                  progress: 0.2,
                ),
                LessonButton(
                  image: 'assets/images/lessons/the_body.png',
                  title: 'The body',
                  lessonColor: Color(0xFFff8fab),
                  stackColor1: Color(0xFFffb3c6),
                  stackColor2: Color(0xFFffe5ec),
                  progress: 0,
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/images/lessons/numbers.png',
                  title: 'Numbers',
                  lessonColor: Color(0xFF48cae4),
                  stackColor1: Color(0xFFade8f4),
                  stackColor2: Color(0xFFcaf0f8),
                  progress: 0,
                ),
                LessonButton(
                  image: 'assets/images/lessons/food.png',
                  title: 'Food & Drink',
                  lessonColor: Color(0xFFd5bdaf),
                  stackColor1: Color(0xFFe3d5ca),
                  stackColor2: Color(0xFFf5ebe0),
                  progress: 0,
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/images/lessons/clothing.png',
                  title: 'Clothing',
                  lessonColor: Color(0xFFf6bd60),
                  stackColor1: Color(0xFFf5cac3),
                  stackColor2: Color(0xFFf7ede2),
                  progress: 0,
                ),
                LessonButton(
                  image: 'assets/images/lessons/places.png',
                  title: 'Places',
                  lessonColor: Color(0xFFe9edc9),
                  stackColor1: Color(0xFFfaedcd),
                  stackColor2: Color(0xFFfefae0),
                  progress: 0,
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LessonButton(
                  image: 'assets/images/lessons/the_body.png',
                  title: 'The body',
                  lessonColor: Color(0xFFff8fab),
                  stackColor1: Color(0xFFffb3c6),
                  stackColor2: Color(0xFFffe5ec),
                  progress: 0,
                ),
                LessonButton(
                  image: 'assets/images/lessons/traffics.png',
                  title: 'Traffics',
                  lessonColor: Color(0xFFff9f1c),
                  stackColor1: Color(0xFFffbf69),
                  stackColor2: Color(0xFFffffff),
                  progress: 0,
                ),
              ],
            ),
            SizedBox(height: 40),
            // Container(
            //   height: 200,
            // ),
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
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
