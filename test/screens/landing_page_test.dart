import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seedling_app/screens/log_in_page.dart';
import 'package:seedling_app/screens/landing_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LandingScreen Tests', () {
    testWidgets('LandingScreen renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LandingScreen()));

      expect(find.byType(LandingScreen), findsOneWidget);
      expect(find.byType(AnimatedBuilder), findsWidgets);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Animation works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LandingScreen()));

      LandingScreenState state = tester.state(find.byType(LandingScreen));
      expect(state.controller.isAnimating, isTrue);

      await tester.pump(const Duration(seconds: 3));
      expect(state.controller.isAnimating, isTrue);
    });

    testWidgets('Navigates to LogInPage after delay', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LandingScreen()));

      // Verify LandingScreen is displayed
      expect(find.byType(LandingScreen), findsOneWidget);

      // Simulate delay
      await tester.pump(const Duration(seconds: 10));

      // Verify navigation to LogInPage
      expect(find.byType(LogInPage), findsNothing);
    });
  });
}
