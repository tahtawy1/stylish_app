import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
    ),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600, //w500
    ),

    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400, //w500, w600
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400, //w500, w600
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400, //w500, w600
    ),
  );
}
