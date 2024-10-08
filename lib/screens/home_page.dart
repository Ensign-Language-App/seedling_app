import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/widgets/lesson_button.dart';
import 'package:seedling_app/providers/language_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        // Add other providers as needed
      ],
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Text(
              'The Basics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 106, 105, 105)),
            ),
           SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/numbers.png',
                    title: 'Numbers',
                    lessonColor: Color(0xFF48cae4),
                    stackColor1: Color(0xFFade8f4),
                    stackColor2: Color(0xFFcaf0f8),
                    topic: 'Numbers',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/colors.png',
                    title: 'Colors',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    topic: 'Colors',
                  ),
                ),
              ],
            ),
          SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/days.png',
                    title: 'Days',
                    lessonColor: Color(0xFF80deaa),
                    stackColor1: Color(0xFFb0e8cc),
                    stackColor2: Color(0xFFe0f7ec),
                    topic: 'Days',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/months.png',
                    title: 'Months',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    topic: 'Months',
                  ),
                ),
              ],
            ),
          SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/time.png',
                    title: 'Time',
                    lessonColor: Color(0xFFf4a261),
                    stackColor1: Color(0xFFf7c79e),
                    stackColor2: Color(0xFFfae3d3),
                    topic: 'Time',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/questions.png',
                    title: 'Questions',
                    lessonColor: Color(0xFFc7bfe6),
                    stackColor1: Color(0xFFd9d2ef),
                    stackColor2: Color(0xFFedeaf7),
                    topic: 'Questions',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/animals.png',
                    title: 'Animals',
                    lessonColor: Color(0xFF7fdcc4),
                    stackColor1: Color(0xFFc8f0e8),
                    stackColor2: Color(0xFFe8faf4),
                    topic: 'Animals',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/greets.png',
                    title: 'Greetings',
                    lessonColor: Color(0xFFf4a892),
                    stackColor1: Color(0xFFfcd9c5),
                    stackColor2: Color(0xFFfdebe4),
                    topic: 'Greetings',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Daily Life',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 106, 105, 105)),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/people.png',
                    title: 'People',
                    lessonColor: Color(0xFF48cae4),
                    stackColor1: Color(0xFFade8f4),
                    stackColor2: Color(0xFFcaf0f8),
                    topic: 'People',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/family.png',
                    title: 'Family',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    topic: 'Family',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/the_body.png',
                    title: 'The Body',
                    lessonColor: Color(0xFF80deaa),
                    stackColor1: Color(0xFFb0e8cc),
                    stackColor2: Color(0xFFe0f7ec),
                    topic: 'Body',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/clothing.png',
                    title: 'Clothing',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    topic: 'Clothing',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/greets.png',
                    title: 'Home',
                    lessonColor: Color(0xFFf4a261),
                    stackColor1: Color(0xFFf7c79e),
                    stackColor2: Color(0xFFfae3d3),
                    topic: 'Home',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/places.png',
                    title: 'Places',
                    lessonColor: Color(0xFFc7bfe6),
                    stackColor1: Color(0xFFd9d2ef),
                    stackColor2: Color(0xFFedeaf7),
                    topic: 'Places',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/food.png',
                    title: 'Food & Drink',
                    lessonColor: Color(0xFF7fdcc4),
                    stackColor1: Color(0xFFc8f0e8),
                    stackColor2: Color(0xFFe8faf4),
                    topic: 'Food & Drink',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/dining.png',
                    title: 'Dining',
                    lessonColor: Color(0xFFf4a892),
                    stackColor1: Color(0xFFfcd9c5),
                    stackColor2: Color(0xFFfdebe4),
                    topic: 'Dining',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Travel & Directions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 106, 105, 105)),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/travel.png',
                    title: 'Travel',
                    lessonColor: Color(0xFF48cae4),
                    stackColor1: Color(0xFFade8f4),
                    stackColor2: Color(0xFFcaf0f8),
                    topic: 'Travel',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/directions.png',
                    title: 'Directions',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    topic: 'Directions',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/emergency.png',
                    title: 'Emergency',
                    lessonColor: Color(0xFF80deaa),
                    stackColor1: Color(0xFFb0e8cc),
                    stackColor2: Color(0xFFe0f7ec),
                    topic: 'Emergency',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/money.png',
                    title: 'Money',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    topic: 'Money',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/health.png',
                    title: 'Health',
                    lessonColor: Color(0xFFf4a261),
                    stackColor1: Color(0xFFf7c79e),
                    stackColor2: Color(0xFFfae3d3),
                    topic: 'Health',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/shopping.png',
                    title: 'Shopping',
                    lessonColor: Color(0xFFc7bfe6),
                    stackColor1: Color(0xFFd9d2ef),
                    stackColor2: Color(0xFFedeaf7),
                    topic: 'Shopping',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Grammar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 106, 105, 105)),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/reg_verbs.png',
                    title: 'Regular Verbs',
                    lessonColor: Color(0xFF7fdcc4),
                    stackColor1: Color(0xFFc8f0e8),
                    stackColor2: Color(0xFFe8faf4),
                    topic: 'Regular Verbs',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/irreg_verbs.png',
                    title: 'Irregular Verbs',
                    lessonColor: Color(0xFFf4a892),
                    stackColor1: Color(0xFFfcd9c5),
                    stackColor2: Color(0xFFfdebe4),
                    topic: 'Irregular Verbs',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/adjectives.png',
                    title: 'Adjectives',
                    lessonColor: Color(0xFF48cae4),
                    stackColor1: Color(0xFFade8f4),
                    stackColor2: Color(0xFFcaf0f8),
                    topic: 'Adjectives',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/conversation.png',
                    title: 'Conversation',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    topic: 'Conversation',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/subj_pronouns.png',
                    title: 'Subject Pronouns',
                    lessonColor: Color(0xFF80deaa),
                    stackColor1: Color(0xFFb0e8cc),
                    stackColor2: Color(0xFFe0f7ec),
                    topic: 'Subject Pronouns',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/poss_pronouns.png',
                    title: 'Possessive Pronouns',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    topic: 'Possessive Pronouns',
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/prepositions.png',
                    title: 'Prepositions',
                    lessonColor: Color(0xFFf4a261),
                    stackColor1: Color(0xFFf7c79e),
                    stackColor2: Color(0xFFfae3d3),
                    topic: 'Prepositions',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/conjunctions.png',
                    title: 'Conjunctions',
                    lessonColor: Color(0xFFc7bfe6),
                    stackColor1: Color(0xFFd9d2ef),
                    stackColor2: Color(0xFFedeaf7),
                    topic: 'Conjunctions',
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
