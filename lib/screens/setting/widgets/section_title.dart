import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:flutter/material.dart';

Widget
sectionTitle(
  String title,
  BuildContext context,
) {
  final extraColors =
      Theme.of(
            context,
          )
          .extension<
            AppExtraColors
          >()!;
  return Padding(
    padding: const EdgeInsets.only(
      left: 24,
      bottom: 10,
      top: 18,
    ),
    child: Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: extraColors.fadeText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,

            color: extraColors.fadeText.withValues(
              alpha: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
}
