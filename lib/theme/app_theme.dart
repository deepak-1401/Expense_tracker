import 'package:budget_manager/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:budget_manager/theme/dark_theme_colors.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: DarkColors.background,

    colorScheme: const ColorScheme.dark(
      surface: DarkColors.container,

      onSurface: DarkColors.textPrimary,

      primary: DarkColors.primary,

      secondary: DarkColors.secondary,

      tertiary: DarkColors.tertiary,
    ),

    extensions: const [
      AppExtraColors(
        filledColor: DarkColors.filledColor,

        textPrimary: DarkColors.textPrimary,

        container: DarkColors.container,

        alertDialogBG: DarkColors.alartdialogBG,

        purpleText: DarkColors.purpleText,

        fadeText: DarkColors.fadeText,

        iconColor: DarkColors.iconColor,

        fadeIconColor: DarkColors.fadeiconColor,

        success: DarkColors.success,

        error: DarkColors.error,

        warning: DarkColors.warning,

        border: DarkColors.border,
      ),
    ],
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: LightColors.background,

    colorScheme: const ColorScheme.light(
      surface: LightColors.background,

      onSurface: LightColors.textPrimary,

      primary: LightColors.primary,

      secondary: LightColors.secondary,

      tertiary: LightColors.tertiary,
    ),

    extensions: const [
      AppExtraColors(
        filledColor: LightColors.filledColor,

        container: LightColors.container,

        alertDialogBG: LightColors.alertDialogBG,

        purpleText: LightColors.purpleText,

        textPrimary: LightColors.textPrimary,

        fadeText: LightColors.fadeText,

        iconColor: LightColors.iconColor,

        fadeIconColor: LightColors.fadeIconColor,

        success: LightColors.success,

        error: LightColors.error,

        warning: LightColors.warning,

        border: LightColors.border,
      ),
    ],
  );
}
