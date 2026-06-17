import 'package:flutter/material.dart';
import 'package:budget_manager/theme/colours.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.dark(
      surface: AppColors.container,
      onSurface: AppColors.textPrimary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
    ),

    extensions: const [
      AppExtraColors(
        filledColor: AppColors.filledColor,
        alertDialogBG: AppColors.alartdialogBG,
        purpleText: AppColors.purpleText,
        fadeText: AppColors.fadeText,
        iconColor: AppColors.iconColor,
        fadeIconColor: AppColors.fadeiconColor,
        success: AppColors.success,
        error: AppColors.error,
        warning: AppColors.warning,
        border: AppColors.border,
      ),
    ],
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(
      0xFFF5F7FA,
    ),

    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      onSurface: Color(
        0xFF1A1A1A,
      ),
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

    extensions: const [
      AppExtraColors(
        filledColor: Color(
          0xFFF0F2F5,
        ),
        alertDialogBG: Colors.white,
        purpleText: Color(
          0xFFFF0080,
        ),
        fadeText: Color(
          0xFF666666,
        ),
        iconColor: Color(
          0xFF7928CA,
        ),
        fadeIconColor: Color(
          0xFF8A8A8A,
        ),
        success: Color(
          0xFF00A86B,
        ),
        error: Color(
          0xFFE53935,
        ),
        warning: Color(
          0xFFFFA000,
        ),
        border: Color(
          0xFFE0E0E0,
        ),
      ),
    ],
  );
}
