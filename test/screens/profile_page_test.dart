<<<<<<< HEAD
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/screens/profile_page.dart';

void main() {
  testWidgets('ProfilePage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

    // Verify that ProfilePage is displayed
    expect(find.byType(ProfilePage), findsOneWidget);

  });}
=======
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seedling_app/screens/profile_page.dart';
import 'package:seedling_app/widgets/language_selector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('AppBar is displayed with correct title and back button', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const ProfilePage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Profile section displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const ProfilePage()));

    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.text('User Name'), findsOneWidget);
    expect(find.byType(LanguageSelector), findsWidgets);
  });

  testWidgets('Learning Path section displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const ProfilePage()));

    expect(find.text('Current Learning Path:'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byType(LanguageSelector), findsWidgets);
  });

  testWidgets('Achievements section displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const ProfilePage()));

    expect(find.text('Achievements'), findsOneWidget);
    expect(find.byIcon(Icons.emoji_events), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsOneWidget);
    expect(find.byIcon(Icons.military_tech), findsOneWidget);
  });

  testWidgets('Social Media section displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const ProfilePage()));

    expect(find.text('Social Media'), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.facebook), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.twitter), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.instagram), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.youtube), findsOneWidget);
  });

  testWidgets('Favorites and Practice sections display correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const ProfilePage()));

    expect(find.text('Favorites'), findsOneWidget);
    expect(find.byIcon(Icons.list), findsOneWidget);
    expect(find.text('Practice'), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.book), findsOneWidget);
  });
}
>>>>>>> f7ed613e46869cd0980a5e5f9722781dea289e4d
