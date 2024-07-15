import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seedling_app/screens/home_page.dart';
import 'package:seedling_app/widgets/lesson_button.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('HomePage displays all LessonButtons', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

    // Verify the presence of LessonButton widgets
    expect(find.byType(LessonButton), findsNWidgets(10));

    // Verify the properties of the first LessonButton
    final lessonButtonAnimals = find.widgetWithText(LessonButton, 'Animals');
    expect(lessonButtonAnimals, findsOneWidget);

    final lessonButtonGreetings = find.widgetWithText(LessonButton, 'Greetings');
    expect(lessonButtonGreetings, findsOneWidget);

    final lessonButtonFamily = find.widgetWithText(LessonButton, 'Family');
    expect(lessonButtonFamily, findsOneWidget);

    final lessonButtonBody = find.widgetWithText(LessonButton, 'The body');
    expect(lessonButtonBody, findsWidgets);

    final lessonButtonNumbers = find.widgetWithText(LessonButton, 'Numbers');
    expect(lessonButtonNumbers, findsOneWidget);

    final lessonButtonFood = find.widgetWithText(LessonButton, 'Food & Drink');
    expect(lessonButtonFood, findsOneWidget);

    final lessonButtonClothing = find.widgetWithText(LessonButton, 'Clothing');
    expect(lessonButtonClothing, findsOneWidget);

    final lessonButtonPlaces = find.widgetWithText(LessonButton, 'Places');
    expect(lessonButtonPlaces, findsOneWidget);

    final lessonButtonTraffics = find.widgetWithText(LessonButton, 'Traffics');
    expect(lessonButtonTraffics, findsOneWidget);

    // Check other properties of a LessonButton, like image and colors
    LessonButton lessonButtonWidget = tester.widget(lessonButtonAnimals);
    expect(lessonButtonWidget.image, 'assets/images/lessons/animals.png');
    expect(lessonButtonWidget.lessonColor, const Color(0xFF9c6644));
    expect(lessonButtonWidget.stackColor1, const Color(0xFF7f5539));
    expect(lessonButtonWidget.stackColor2, const Color(0xFFe6ccb2));
  });

  testWidgets('HomePage layout is correct', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const HomePage()));

    // Verify the presence of SizedBox widgets for spacing
    expect(find.byType(SizedBox), findsNWidgets(26));

    // Verify the presence of Rows and Columns
    expect(find.byType(Row), findsNWidgets(15));
    expect(find.byType(Column), findsWidgets);
  });
}
