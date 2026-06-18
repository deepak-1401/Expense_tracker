import 'package:flutter/material.dart';

@immutable
class AppExtraColors
    extends
        ThemeExtension<
          AppExtraColors
        > {
  final Color filledColor;
  final Color container;
  final Color alertDialogBG;
  final Color purpleText;
  final Color fadeText;
  final Color iconColor;
  final Color fadeIconColor;
  final Color success;
  final Color error;
  final Color warning;
  final Color border;

  const AppExtraColors({
    required this.filledColor,
    required this.container,
    required this.alertDialogBG,
    required this.purpleText,
    required this.fadeText,
    required this.iconColor,
    required this.fadeIconColor,
    required this.success,
    required this.error,
    required this.warning,
    required this.border,
  });

  Color? get textPrimary => null;

  @override
  AppExtraColors copyWith({
    Color? filledColor,
    Color? container,
    Color? alertDialogBG,
    Color? purpleText,
    Color? fadeText,
    Color? iconColor,
    Color? fadeIconColor,
    Color? success,
    Color? error,
    Color? warning,
    Color? border,
  }) {
    return AppExtraColors(
      filledColor:
          filledColor ??
          this.filledColor,
      container:
          container ??
          this.container,
      alertDialogBG:
          alertDialogBG ??
          this.alertDialogBG,
      purpleText:
          purpleText ??
          this.purpleText,
      fadeText:
          fadeText ??
          this.fadeText,
      iconColor:
          iconColor ??
          this.iconColor,
      fadeIconColor:
          fadeIconColor ??
          this.fadeIconColor,
      success:
          success ??
          this.success,
      error:
          error ??
          this.error,
      warning:
          warning ??
          this.warning,
      border:
          border ??
          this.border,
    );
  }

  @override
  AppExtraColors lerp(
    ThemeExtension<
      AppExtraColors
    >?
    other,
    double t,
  ) {
    if (other
        is! AppExtraColors)
      return this;

    return AppExtraColors(
      filledColor: Color.lerp(
        filledColor,
        other.filledColor,
        t,
      )!,
      container: Color.lerp(
        container,
        other.container,
        t,
      )!,
      alertDialogBG: Color.lerp(
        alertDialogBG,
        other.alertDialogBG,
        t,
      )!,
      purpleText: Color.lerp(
        purpleText,
        other.purpleText,
        t,
      )!,
      fadeText: Color.lerp(
        fadeText,
        other.fadeText,
        t,
      )!,
      iconColor: Color.lerp(
        iconColor,
        other.iconColor,
        t,
      )!,
      fadeIconColor: Color.lerp(
        fadeIconColor,
        other.fadeIconColor,
        t,
      )!,
      success: Color.lerp(
        success,
        other.success,
        t,
      )!,
      error: Color.lerp(
        error,
        other.error,
        t,
      )!,
      warning: Color.lerp(
        warning,
        other.warning,
        t,
      )!,
      border: Color.lerp(
        border,
        other.border,
        t,
      )!,
    );
  }
}
