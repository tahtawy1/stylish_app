import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      primary: Color(0xff1A1A1A),
      brightness: Brightness.light,
      onPrimary: Colors.white,
      secondary: const Color(0xff979797),
      onSecondary: Colors.white,
      error: const Color(0xFFF44336),
      onError: const Color(0xFFFFFFFF),
      surface: const Color(0xffFFFFFF),
      onSurface: const Color(0xff1A1A1A),
      onSurfaceVariant: const Color(0xff808080),
      surfaceContainer: Color(0xff1A1A1A),
      outline: const Color(0xffCCCCCC),
      shadow: Color(0xffFFFFFF).withValues(alpha: 15),
    ),
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      primary: Color(0xffE6E6E6),
      brightness: Brightness.dark,
      onPrimary: const Color(0xff1A1A1A),
      secondary: const Color(0xff979797),
      onSecondary: Color(0xffE6E6E6),
      error: const Color(0xFFF44336),
      onError: const Color(0xffE6E6E6),
      surface: const Color(0xff1A1A1A),
      onSurface: const Color(0xffE6E6E6),
      onSurfaceVariant: const Color(0xffA0A0A0),
      surfaceContainer: Color(0xff1A1A1A),
      outline: const Color(0xff3A3A3A),
      shadow: Color(0xff1A1A1A).withValues(alpha: 15),
    ),
    useMaterial3: true,
  );
}
