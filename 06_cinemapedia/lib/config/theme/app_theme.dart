import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme(bool isDarkmode) => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff2862f5),
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
      );
}
