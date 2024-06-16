import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/language_selector.dart';

void main() {
  testWidgets('LanguageSelector Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: LanguageSelector(width: 50, height: 50))));

    expect(find.byType(LanguageSelector), findsOneWidget);
  });
}