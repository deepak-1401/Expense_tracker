import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:flutter/material.dart';

class SettingsTile
    extends
        StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;
  final Widget? trailing;

  const SettingsTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    return InkWell(
      borderRadius: BorderRadius.circular(
        20,
      ),
      onTap: onTap,
      child: Container(
        width:
            MediaQuery.of(
              context,
            ).size.width *
            0.9,
        padding: const EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          color: extraColors.container,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(
                  27,
                ),
              ),
              child: Icon(
                icon,
                color: extraColors.iconColor,
                size: 22,
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,

                    style: TextStyle(
                      color: extraColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: extraColors.fadeText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            trailing ??
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: extraColors.iconColor,
                  size: 18,
                ),
          ],
        ),
      ),
    );
  }
}
