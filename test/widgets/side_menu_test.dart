import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:seedling_app/providers/theme_notifier.dart';
import 'package:seedling_app/screens/profile_page.dart';
import 'package:seedling_app/screens/settings_page.dart';
import 'package:seedling_app/widgets/side_menu.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetForTesting({required Widget child}) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('SideMenu displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const SideMenu()));

    expect(find.byType(DrawerHeader), findsOneWidget);
    expect(find.text('Leo'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(5));
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.info), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  testWidgets('Navigates to ProfilePage when Profile ListTile is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const SideMenu()));

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);
  });

  testWidgets('Navigates to SettingsPage when Settings ListTile is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const SideMenu()));

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsPage), findsOneWidget);
  });

  testWidgets('Toggles theme when Dark Mode switch is toggled', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: const SideMenu()));
    final themeNotifier = Provider.of<ThemeNotifier>(tester.element(find.byType(SideMenu)), listen: false);

    bool initialThemeMode = themeNotifier.isDarkMode;
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(themeNotifier.isDarkMode, !initialThemeMode);
  });

  // testWidgets('Navigates to LogInPage when Log out ListTile is tapped', (WidgetTester tester) async {
  //   await tester.pumpWidget(createWidgetForTesting(child: const SideMenu()));
  //
  //   await tester.tap(find.text('Log out'));
  //   await tester.pump(const Duration(seconds: 1));
  //
  //   expect(find.byType(LogInPage), findsOneWidget);
  // });
}
