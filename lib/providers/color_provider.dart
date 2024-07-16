import 'package:flutter/material.dart';

//TODO: PICKER COLOR IS NEVER SYNCED WITH THE BACKGROUND COLOR AND CURRENT COLOR
class ColorProvider with ChangeNotifier {
  Color _backgroundColor = const Color.fromRGBO(255, 150, 79, 1.0);

  Color get backgroundColor => _backgroundColor;

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
}