import 'package:flutter/material.dart';
import 'package:stylish_app/core/theme/app_colors.dart';
import 'package:stylish_app/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Inter',
      textTheme: AppTextStyles.textTheme,
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        brightness: Brightness.light,

        // Primary
        primary: AppColors.grey1,
        onPrimary: AppColors.white,

        // Secondary
        secondary: AppColors.grey6,
        onSecondary: AppColors.white,

        // Error
        error: const Color(0xFFF44336),
        onError: AppColors.white,

        // Surface
        surface: AppColors.white,
        onSurface: AppColors.grey1,
        onSurfaceVariant: AppColors.grey5,
        surfaceContainer: AppColors.grey1,

        // Utility
        outline: AppColors.grey9,
        shadow: AppColors.white.withValues(alpha: 75),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Inter',
      textTheme: AppTextStyles.textTheme,
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,

        // Primary
        primary: AppColors.white,
        onPrimary: AppColors.grey1,

        // Secondary
        secondary: AppColors.grey5,
        onSecondary: AppColors.grey1,

        // Error
        error: const Color(0xFFF44336),
        onError: AppColors.white,

        // Surface
        surface: AppColors.grey1,
        onSurface: AppColors.white,
        onSurfaceVariant: AppColors.grey8,
        surfaceContainer: AppColors.white,

        // Utility
        outline: AppColors.grey4,
        shadow: AppColors.grey1.withValues(alpha: 15),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.grey1,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 0,
      ),
    );
  }
}
