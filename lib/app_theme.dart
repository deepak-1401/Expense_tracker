import 'package:flutter/material.dart';
import 'package:budget_manager/core/utils/colours.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.dark(
      surface: AppColors.background,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
    ),
  );
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(
      0xFFF5F7FA,
    ),

    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      primary: Color(
        0xFFFF0080,
      ),
      secondary: Color(
        0xFF7928CA,
      ),
      tertiary: Color(
        0xFF00E5FF,
      ),
    ),
  );
}
