import 'package:budget_manager/blocs/theme_bloc/theme_bloc.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();

    final themeState = context
        .read<
          ThemeBloc
        >()
        .state;

    if (themeState
        is LightThemeState) {
      selectedTheme = "Light";
    } else {
      selectedTheme = "Dark";
    }
  }

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
    return AlertDialog(
      backgroundColor: extraColors.alertDialogBG,
      title: Text(
        'Theme ',
        style: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.primary,
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

                  if (value ==
                      "Light") {
                    context
                        .read<
                          ThemeBloc
                        >()
                        .add(
                          LightThemeSelected(),
                        );
                  } else if (value ==
                      "Dark") {
                    context
                        .read<
                          ThemeBloc
                        >()
                        .add(
                          DarkThemeSelected(),
                        );
                  }
                },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 0,
                ),
                Material(
                  color: extraColors.filledColor,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  child:
                      RadioListTile<
                        String
                      >(
                        value: "Light",
                        // ignore: deprecated_member_use
                        groupValue: selectedTheme,
                        activeColor: Theme.of(
                          context,
                        ).colorScheme.primary,
                        title: Text(
                          "Light",
                          style: TextStyle(
                            color: extraColors.textPrimary,
                          ),
                        ),
                        // ignore: deprecated_member_use
                        onChanged:
                            (
                              value,
                            ) {
                              setState(
                                () {
                                  selectedTheme = value;
                                },
                              );

                              context
                                  .read<
                                    ThemeBloc
                                  >()
                                  .add(
                                    LightThemeSelected(),
                                  );
                            },
                      ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Material(
                  color: extraColors.filledColor,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                  child:
                      RadioListTile<
                        String
                      >(
                        value: "Dark",
                        // ignore: deprecated_member_use
                        groupValue: selectedTheme,
                        activeColor: Theme.of(
                          context,
                        ).colorScheme.primary,
                        title: Text(
                          "Dark",
                          style: TextStyle(
                            color: extraColors.textPrimary,
                          ),
                        ),
                        // ignore: deprecated_member_use
                        onChanged:
                            (
                              value,
                            ) {
                              setState(
                                () {
                                  selectedTheme = value;
                                },
                              );

                              context
                                  .read<
                                    ThemeBloc
                                  >()
                                  .add(
                                    DarkThemeSelected(),
                                  );
                            },
                      ),
                ),
              ],
            ),
          ),
    );
  }
}
