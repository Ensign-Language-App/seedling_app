import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _learningLanguage = 'French';
  String _nativeLanguage = 'English';

  String get learningLanguage => _learningLanguage;
  String get nativeLanguage => _nativeLanguage;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _learningLanguage = prefs.getString('learningLanguage') ?? 'French';
    _nativeLanguage = prefs.getString('nativeLanguage') ?? 'English';
    notifyListeners();
  }

  Future<void> setLearningLanguage(String language) async {
    _learningLanguage = language;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('learningLanguage', language);
  }

  Future<void> setNativeLanguage(String language) async {
    _nativeLanguage = language;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nativeLanguage', language);
  }

  Future<void> resetPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('learningLanguage');
    await prefs.remove('nativeLanguage');
    _learningLanguage = 'French';
    _nativeLanguage = 'English';
    notifyListeners();
  }
}
