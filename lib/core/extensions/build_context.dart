import 'package:flutter/material.dart';

extension ColorSchemeExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension TextThemeExt on BuildContext {
  TextTheme get textStyle => Theme.of(this).textTheme;
}

extension ThemeExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
