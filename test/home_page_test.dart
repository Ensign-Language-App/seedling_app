import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seedling_app/Widgets/bottom_nav_bar.dart';
import 'package:seedling_app/Widgets/side_menu.dart';
import 'package:seedling_app/Widgets/top_nav_bar.dart';
import 'package:seedling_app/screens/home_page.dart'; 

void main() {
  testWidgets('HomePage UI test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    // Verify that the TopNavBar widget is displayed
    expect(find.byType(TopNavBar), findsOneWidget);

    // Verify that the SideMenu widget is displayed
    expect(find.byType(SideMenu), findsOneWidget);

    // Verify that the BottomNavBar widget is displayed
    expect(find.byType(BottomNavBar), findsOneWidget);

    // You can continue to add more tests for other UI elements as needed
  });
}