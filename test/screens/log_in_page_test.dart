import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/screens/log_in_page.dart';

void main() {
  testWidgets('LogInPage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LogInPage()));

    expect(find.byType(LogInPage), findsOneWidget);

    expect(find.byType(TextField), findsNWidgets(2));

    expect(find.text('SIGN IN'), findsOneWidget);

    expect(find.text('Forgot Password?'), findsOneWidget);

    expect(find.text("Don't have an account?"), findsOneWidget);

    expect(find.text('Sign up'), findsOneWidget);
  });
}