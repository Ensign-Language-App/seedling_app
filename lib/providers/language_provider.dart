import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _learningLanguage = 'French';
  String _nativeLanguage = 'English';

  String get learningLanguage => _learningLanguage;
  String get nativeLanguage => _nativeLanguage;

  LanguageProvider() {
    _loadPreferences();
  }

  void setLearningLanguage(String language) {
    _learningLanguage = language;
    _savePreferences();
    notifyListeners();
  }

  void setNativeLanguage(String language) {
    _nativeLanguage = language;
    _savePreferences();
    notifyListeners();
  }

  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('learningLanguage', _learningLanguage);
    await prefs.setString('nativeLanguage', _nativeLanguage);
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _learningLanguage = prefs.getString('learningLanguage') ?? 'French';
    _nativeLanguage = prefs.getString('nativeLanguage') ?? 'English';
    notifyListeners();
  }
}
