import 'package:flutter/material.dart';

const Color customColor = Color(0xff01b4e4);

class AppTheme {
  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: customColor,
    ),
  );
}
