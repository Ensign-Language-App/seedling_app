import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:seedling_app/widgets/flip_card.dart';

void main() {
  testWidgets('FlipCard Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Center(child: LanguageLearningApp())));

    expect(find.byType(FlipCard), findsOneWidget);
    expect(find.widgetWithText(Card, 'Question'), findsOneWidget);
    expect(find.widgetWithText(Card, 'Answer'), findsOneWidget);
  });
}