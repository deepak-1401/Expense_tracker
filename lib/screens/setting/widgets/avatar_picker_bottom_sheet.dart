import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:flutter/material.dart';
import 'package:budget_manager/data/avatar_data.dart';

class AvatarPickerBottomSheet
    extends
        StatelessWidget {
  const AvatarPickerBottomSheet({
    super.key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  final String selectedAvatar;
  final ValueChanged<
    String
  >
  onAvatarSelected;

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
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: extraColors.container,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            24,
          ),
        ),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: avatarList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
        ),
        itemBuilder:
            (
              context,
              index,
            ) {
              final avatar = avatarList[index];
              final isSelected =
                  avatar ==
                  selectedAvatar;

              return GestureDetector(
                onTap: () {
                  onAvatarSelected(
                    avatar,
                  );
                  Navigator.pop(
                    context,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(
                    3,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(
                              context,
                            ).colorScheme.primary
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      avatar,
                    ),
                  ),
                ),
              );
            },
      ),
    );
  }
}
