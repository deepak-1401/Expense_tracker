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
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: const BoxDecoration(
        color: Color(
          0xFF0F1330,
        ),
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
