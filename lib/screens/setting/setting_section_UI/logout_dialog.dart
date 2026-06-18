import 'package:budget_manager/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void
showLogoutDialog(
  BuildContext context,
) {
  final extraColors =
      Theme.of(
            context,
          )
          .extension<
            AppExtraColors
          >()!;
  showDialog(
    context: context,
    builder:
        (
          dialogContext,
        ) {
          return AlertDialog(
            backgroundColor: extraColors.alertDialogBG,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            title: Text(
              'Logout?',
              style: TextStyle(
                color: extraColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to logout from your account?',
              style: TextStyle(
                color: extraColors.fadeText,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    dialogContext,
                  );
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    dialogContext,
                  );

                  context
                      .read<
                        AuthenticationBloc
                      >()
                      .add(
                        const LogOutRequired(),
                      );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        },
  );
}
