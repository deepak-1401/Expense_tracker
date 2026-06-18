import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:flutter/material.dart';

class AboutAppScreen
    extends
        StatelessWidget {
  const AboutAppScreen({
    super.key,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About App',
          style: TextStyle(
            color: Theme.of(
              context,
            ).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.account_balance_wallet_rounded,
                color: extraColors.iconColor,
                size: 80,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'Expense Tracker',
                style: TextStyle(
                  color: extraColors.textPrimary,

                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: extraColors.fadeText,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            Text(
              'About',
              style: TextStyle(
                color: extraColors.textPrimary,

                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Expense Tracker is a simple and secure personal finance app '
              'designed to help users manage their daily expenses. '
              'You can record transactions, categorize spending, view '
              'analytics, and gain insights into your financial habits.',
              style: TextStyle(
                color: extraColors.fadeText,
                fontSize: 15,
                height: 1.6,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Text(
              'Features',
              style: TextStyle(
                color: extraColors.textPrimary,

                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '• Track daily expenses\n'
              '• Organize spending by category\n'
              '• Multiple payment methods\n'
              '• Analytics and charts\n'
              '• Secure cloud backup with Firebase\n'
              '• Dark mode support',
              style: TextStyle(
                color: extraColors.fadeText,
                fontSize: 15,
                height: 1.6,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Text(
              'Developer',
              style: TextStyle(
                color: extraColors.textPrimary,

                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Developed by Deepak as a Flutter & Firebase project to help users manage personal finances efficiently.',
              style: TextStyle(
                color: extraColors.fadeText,

                fontSize: 15,
                height: 1.6,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Divider(),

            const SizedBox(
              height: 12,
            ),

            Center(
              child: Text(
                '© 2026 Expense Tracker\nAll rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: extraColors.fadeText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
