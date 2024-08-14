import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      filledButtonTheme: FilledButtonThemeData(
          style:
              FilledButton.styleFrom(maximumSize: Size(double.infinity, 60))));
}
