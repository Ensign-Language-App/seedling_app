import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:seedling_app/widgets/side_menu.dart';
import 'package:seedling_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('SideMenu Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: const MaterialApp(home: Scaffold(body: SideMenu())),
      ),
    );

    expect(find.byType(Drawer), findsOneWidget);

    expect(find.byType(DrawerHeader), findsOneWidget);
    expect(find.text('Duo'), findsOneWidget);

    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    expect(find.byIcon(Icons.info), findsOneWidget);
    expect(find.text('About'), findsOneWidget);

    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.text('Dark Mode'), findsOneWidget);


    expect(find.byType(Switch), findsOneWidget);
  });
}
