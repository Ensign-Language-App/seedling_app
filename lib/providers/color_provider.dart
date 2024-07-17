import 'package:flutter/material.dart';

class ColorProvider with ChangeNotifier {
  Color _backgroundColor = const Color.fromRGBO(241, 141, 70, 1.0);
  Color _gradientStartColor = const Color(0xffd17d3e);
  Color _gradientEndColor = const Color(0xFFEACE92);

  Color get backgroundColor => _backgroundColor;
  Color get gradientStartColor => _gradientStartColor;
  Color get gradientEndColor => _gradientEndColor;

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  void setGradientColors(Color startColor, Color endColor) {
    _gradientStartColor = startColor;
    _gradientEndColor = endColor;
    notifyListeners();
  }
}