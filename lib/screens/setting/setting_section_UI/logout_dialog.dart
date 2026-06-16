import 'package:budget_manager/blocs/authentication_bloc/authentication_bloc.dart';
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
            backgroundColor: const Color(
              0xFF161D47,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            title: const Text(
              'Logout?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Are you sure you want to logout from your account?',
              style: TextStyle(
                color: Colors.grey,
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
