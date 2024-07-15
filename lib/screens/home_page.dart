// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/lesson_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/animals.png',
                    title: 'Animals',
                    lessonColor: Color(0xFF9c6644),
                    stackColor1: Color(0xFF7f5539),
                    stackColor2: Color(0xFFe6ccb2),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Animals',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/greets.png',
                    title: 'Greetings',
                    lessonColor: Color(0xFF8d99ae),
                    stackColor1: Color(0xFF2b2d42),
                    stackColor2: Color(0xFFedf2f4),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Greetings',
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
                    image: 'assets/images/lessons/family.png',
                    title: 'Family',
                    lessonColor: Color(0xFF83c5be),
                    stackColor1: Color(0xFF006d77),
                    stackColor2: Color(0xFFb08968),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Family',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/the_body.png',
                    title: 'The Body',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Body',
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
                    image: 'assets/images/lessons/numbers.png',
                    title: 'Numbers',
                    lessonColor: Color(0xFF48cae4),
                    stackColor1: Color(0xFFade8f4),
                    stackColor2: Color(0xFFcaf0f8),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Numbers',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/food.png',
                    title: 'Food & Drink',
                    lessonColor: Color(0xFFd5bdaf),
                    stackColor1: Color(0xFFe3d5ca),
                    stackColor2: Color(0xFFf5ebe0),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Food & Drink',
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
                    image: 'assets/images/lessons/clothing.png',
                    title: 'Clothing',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Clothing',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/places.png',
                    title: 'Places',
                    lessonColor: Color(0xFFe9edc9),
                    stackColor1: Color(0xFFfaedcd),
                    stackColor2: Color(0xFFfefae0),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
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
                    image: 'assets/images/lessons/the_body.png',
                    title: 'The Body',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'The Body',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/traffics.png',
                    title: 'Traffics',
                    lessonColor: Color(0xFFff9f1c),
                    stackColor1: Color(0xFFffbf69),
                    stackColor2: Color(0xFFffffff),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Traffics',
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
                    title: 'People',
                    lessonColor: Color(0xFF9c6644),
                    stackColor1: Color(0xFF7f5539),
                    stackColor2: Color(0xFFe6ccb2),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'People',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/greets.png',
                    title: 'Home',
                    lessonColor: Color(0xFF8d99ae),
                    stackColor1: Color(0xFF2b2d42),
                    stackColor2: Color(0xFFedf2f4),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Home',
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
                    image: 'assets/images/lessons/family.png',
                    title: 'Places',
                    lessonColor: Color(0xFF83c5be),
                    stackColor1: Color(0xFF006d77),
                    stackColor2: Color(0xFFb08968),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Places',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/the_body.png',
                    title: 'Dining',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Dining',
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
                    image: 'assets/images/lessons/numbers.png',
                    title: 'Travel',
                    lessonColor: Color(0xFF48cae4),
                    stackColor1: Color(0xFFade8f4),
                    stackColor2: Color(0xFFcaf0f8),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Travel',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/food.png',
                    title: 'Directions',
                    lessonColor: Color(0xFFd5bdaf),
                    stackColor1: Color(0xFFe3d5ca),
                    stackColor2: Color(0xFFf5ebe0),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
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
                    image: 'assets/images/lessons/clothing.png',
                    title: 'Health',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Health',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/places.png',
                    title: 'Emergency',
                    lessonColor: Color(0xFFe9edc9),
                    stackColor1: Color(0xFFfaedcd),
                    stackColor2: Color(0xFFfefae0),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Emergency',
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
                    title: 'Shopping',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Shopping',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/traffics.png',
                    title: 'Money',
                    lessonColor: Color(0xFFff9f1c),
                    stackColor1: Color(0xFFffbf69),
                    stackColor2: Color(0xFFffffff),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
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
                    image: 'assets/images/lessons/clothing.png',
                    title: 'Colors',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Colors',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/places.png',
                    title: 'Days',
                    lessonColor: Color(0xFFe9edc9),
                    stackColor1: Color(0xFFfaedcd),
                    stackColor2: Color(0xFFfefae0),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Days',
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
                    title: 'Months',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Months',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/traffics.png',
                    title: 'Time',
                    lessonColor: Color(0xFFff9f1c),
                    stackColor1: Color(0xFFffbf69),
                    stackColor2: Color(0xFFffffff),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Time',
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
                    title: 'Questions',
                    lessonColor: Color(0xFF9c6644),
                    stackColor1: Color(0xFF7f5539),
                    stackColor2: Color(0xFFe6ccb2),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Questions',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/greets.png',
                    title: 'Conversation',
                    lessonColor: Color(0xFF8d99ae),
                    stackColor1: Color(0xFF2b2d42),
                    stackColor2: Color(0xFFedf2f4),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
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
                    image: 'assets/images/lessons/family.png',
                    title: 'Adjectives',
                    lessonColor: Color(0xFF83c5be),
                    stackColor1: Color(0xFF006d77),
                    stackColor2: Color(0xFFb08968),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Adjectives',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/the_body.png',
                    title: 'Verbs',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Verbs',
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
                    image: 'assets/images/lessons/numbers.png',
                    title: 'Regular Verbs',
                    lessonColor: Color(0xFF48cae4),
                    stackColor1: Color(0xFFade8f4),
                    stackColor2: Color(0xFFcaf0f8),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Regular Verbs',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/food.png',
                    title: 'Irregular Verbs',
                    lessonColor: Color(0xFFd5bdaf),
                    stackColor1: Color(0xFFe3d5ca),
                    stackColor2: Color(0xFFf5ebe0),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
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
                    image: 'assets/images/lessons/clothing.png',
                    title: 'Subj. Pronouns',
                    lessonColor: Color(0xFFf6bd60),
                    stackColor1: Color(0xFFf5cac3),
                    stackColor2: Color(0xFFf7ede2),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Subject Pronouns',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/places.png',
                    title: 'Poss. Pronouns',
                    lessonColor: Color(0xFFe9edc9),
                    stackColor1: Color(0xFFfaedcd),
                    stackColor2: Color(0xFFfefae0),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
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
                    image: 'assets/images/lessons/the_body.png',
                    title: 'Prepositions',
                    lessonColor: Color(0xFFff8fab),
                    stackColor1: Color(0xFFffb3c6),
                    stackColor2: Color(0xFFffe5ec),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
                    topic: 'Prepositions',
                  ),
                ),
                Flexible(
                  child: LessonButton(
                    image: 'assets/images/lessons/traffics.png',
                    title: 'Conjunctions',
                    lessonColor: Color(0xFFff9f1c),
                    stackColor1: Color(0xFFffbf69),
                    stackColor2: Color(0xFFffffff),
                    nativeLanguage: 'English',
                    learningLanguage: 'French',
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

  Future<List<String>> fetchSubjects() async {
    List<String> subjects = [];
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Vocabulary')
          .doc('Subjects')
          .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        subjects = data.keys.toList();
      }
    } catch (e) {
      print('Failed to fetch subjects: $e');
    }
    return subjects;
  }
}
