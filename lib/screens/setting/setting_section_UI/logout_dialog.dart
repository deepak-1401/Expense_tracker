import 'package:budget_manager/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:budget_manager/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void
showLogoutDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder:
        (
          dialogContext,
        ) {
          return AlertDialog(
            backgroundColor: AppColors.alartdialogBG,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            title: const Text(
              'Logout?',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Are you sure you want to logout from your account?',
              style: TextStyle(
                color: AppColors.fadeText,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    dialogContext,
                  );
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.primary,
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
