import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seedling_app/Widgets/bottom_nav_bar.dart';
import 'package:seedling_app/Widgets/side_menu.dart';
import 'package:seedling_app/Widgets/top_nav_bar.dart';
import 'package:seedling_app/screens/home_page.dart'; 

void main() {
  testWidgets('HomePage UI test', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    expect(find.byType(TopNavBar), findsOneWidget);

    expect(find.byType(BottomNavBar), findsOneWidget);

  });
}