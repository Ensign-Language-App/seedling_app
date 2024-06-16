import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seedling_app/providers/theme_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeNotifier', () {
    late ThemeNotifier themeNotifier;

    setUp(() {
      themeNotifier = ThemeNotifier();
    });

    tearDown(() {
      themeNotifier.dispose();
    });

    test('initially sets theme based on platform brightness', () {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      expect(themeNotifier.isDarkMode, brightness == Brightness.dark);
    });

    test('toggles theme correctly', () {
      final initialMode = themeNotifier.isDarkMode;
      themeNotifier.toggleTheme();
      expect(themeNotifier.isDarkMode, !initialMode);
    });

    test('notifies listeners on theme toggle', () {
      bool listenerCalled = false;
      themeNotifier.addListener(() {
        listenerCalled = true;
      });
      themeNotifier.toggleTheme();
      expect(listenerCalled, true);
    });

    test('updates theme when platform brightness changes', () {
      final binding = TestWidgetsFlutterBinding.instance;
      binding.handlePlatformBrightnessChanged();
      final newBrightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      themeNotifier.didChangePlatformBrightness();
      expect(themeNotifier.isDarkMode, newBrightness == Brightness.dark);
    });
  });
}
