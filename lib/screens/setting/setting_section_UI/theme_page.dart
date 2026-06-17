import 'package:budget_manager/theme/colours.dart';
import 'package:flutter/material.dart';

class ThemePage
    extends
        StatefulWidget {
  const ThemePage({
    super.key,
  });

  @override
  State<
    ThemePage
  >
  createState() => _ThemePageState();
}

class _ThemePageState
    extends
        State<
          ThemePage
        > {
  String? selectedTheme;
  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      backgroundColor: AppColors.alartdialogBG,
      title: const Text(
        'Theme ',
        style: TextStyle(
          color: AppColors.primary,
        ),
      ),
      content:
          RadioGroup<
            String
          >(
            groupValue: selectedTheme,
            onChanged:
                (
                  String? value,
                ) {
                  setState(
                    () {
                      selectedTheme = value;
                    },
                  );
                },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.filledColor,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: const RadioListTile(
                    value: "Light",
                    title: Text(
                      "Light",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.filledColor,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: const RadioListTile(
                    value: "Dark",
                    title: Text(
                      "Dark",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.filledColor,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: const RadioListTile(
                    value: "System",
                    title: Text(
                      "System Default",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: AppColors.filledColor,
                //     borderRadius: BorderRadius.circular(
                //       8,
                //     ),
                //   ),
                //   //child:
                // ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(
                            context,
                          ).colorScheme.tertiary,
                          Theme.of(
                            context,
                          ).colorScheme.secondary,
                          Theme.of(
                            context,
                          ).colorScheme.primary,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        60,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color(
                                0xFF8B5CF6,
                              ).withValues(
                                alpha: 0.35,
                              ),
                          blurRadius: 15,
                          offset: Offset(
                            0,
                            6,
                          ),
                        ),
                      ],
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        // Handle save action
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
