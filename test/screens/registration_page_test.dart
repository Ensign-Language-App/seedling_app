import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/screens/registration_page.dart';

void main() {
  testWidgets('RegistrationPage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationPage()));

    expect(find.byType(RegistrationPage), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(6));
  });
}