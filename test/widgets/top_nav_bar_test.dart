import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/top_nav_bar.dart';
import 'package:seedling_app/widgets/language_selector.dart';

void main() {
  testWidgets('TopNavBar Widget Test', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: TopNavBar(title: 'Home'))));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    expect(find.byType(LanguageSelector), findsOneWidget);

    expect(find.byIcon(Icons.more_vert), findsOneWidget);
  });
}