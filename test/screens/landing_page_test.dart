import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/screens/landing_screen.dart';

void main() {
  testWidgets('LandingScreen Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LandingScreen()));

    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(LandingScreen), findsNothing);

    expect(find.text('Seedling'), findsNothing);

    expect(find.byType(Image), findsNothing);
  });
}