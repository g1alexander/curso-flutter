import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(255, 60, 198, 97);

const List<Color> _colorsTheme = [
  _customColor,
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.cyan,
];

class AppTheme {
  final int colorIndex;

  AppTheme({required this.colorIndex})
      : assert(colorIndex >= 0 && colorIndex < _colorsTheme.length,
            "Color must be between 0 and ${_colorsTheme.length}");

  ThemeData themeData() {
    return ThemeData(
        useMaterial3: true, colorSchemeSeed: _colorsTheme[colorIndex]);
  }
}
