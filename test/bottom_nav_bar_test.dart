// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:seedling_app/widgets/bottom_nav_bar.dart';
//
// void main() {
//   testWidgets('BottomNavBar Widget Test', (WidgetTester tester) async {
//     // Build the BottomNavBar widget inside a MaterialApp
//     await tester.pumpWidget(const MaterialApp(
//       home: Scaffold(
//         body: BottomNavBar(),
//       ),
//     ));
//
//     // Verify the presence of the BottomNavigationBar
//     expect(find.byType(BottomNavigationBar), findsOneWidget);
//
//     // Verify the presence of each BottomNavigationBarItem
//     expect(find.byIcon(Icons.home), findsOneWidget);
//     expect(find.byIcon(Icons.menu_book), findsOneWidget);
//     expect(find.byIcon(Icons.collections_bookmark), findsOneWidget);
//
//     // Verify the presence of the text labels
//     expect(find.text('Home'), findsOneWidget);
//     expect(find.text('Learn'), findsOneWidget);
//     expect(find.text('Bookmark'), findsOneWidget);
//   });
// }
