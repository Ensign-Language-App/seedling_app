import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seedling_app/screens/settings_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('AppBar is displayed with correct title', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const SettingsPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('SettingsPage displays all ListTiles', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const SettingsPage()));

    expect(find.byType(ListTile), findsNWidgets(7));

    expect(find.widgetWithIcon(ListTile, Icons.subscriptions), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'My Subscription'), findsOneWidget);

    expect(find.widgetWithIcon(ListTile, Icons.settings), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'General'), findsOneWidget);

    expect(find.widgetWithIcon(ListTile, Icons.privacy_tip), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Privacy'), findsOneWidget);

    expect(find.widgetWithIcon(ListTile, Icons.notifications), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Notifications'), findsOneWidget);

    expect(find.text('Advance'), findsOneWidget);

    expect(find.widgetWithIcon(ListTile, Icons.help), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Help & Support'), findsOneWidget);

    expect(find.widgetWithIcon(ListTile, Icons.delete_forever), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Delete or Suspend Account'), findsOneWidget);
  });
}
