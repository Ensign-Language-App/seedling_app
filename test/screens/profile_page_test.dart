import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/screens/profile_page.dart';

void main() {
  testWidgets('ProfilePage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));

    // Verify that ProfilePage is displayed
    expect(find.byType(ProfilePage), findsOneWidget);

  });}