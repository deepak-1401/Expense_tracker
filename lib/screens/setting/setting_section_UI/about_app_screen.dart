import 'package:budget_manager/theme/colours.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About App',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Center(
              child: Icon(
                Icons.account_balance_wallet_rounded,
                color: AppColors.iconColor,
                size: 80,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'Expense Tracker',
                style: TextStyle(
                  color: AppColors.textPrimary,

                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: AppColors.fadeText,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            Text(
              'About',
              style: TextStyle(
                color: AppColors.textPrimary,

                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Expense Tracker is a simple and secure personal finance app '
              'designed to help users manage their daily expenses. '
              'You can record transactions, categorize spending, view '
              'analytics, and gain insights into your financial habits.',
              style: TextStyle(
                color: AppColors.fadeText,
                fontSize: 15,
                height: 1.6,
              ),
            ),

            SizedBox(
              height: 24,
            ),

            Text(
              'Features',
              style: TextStyle(
                color: AppColors.textPrimary,

                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
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
                color: AppColors.fadeText,
                fontSize: 15,
                height: 1.6,
              ),
            ),

            SizedBox(
              height: 24,
            ),

            Text(
              'Developer',
              style: TextStyle(
                color: AppColors.textPrimary,

                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Developed by Deepak as a Flutter & Firebase project to help users manage personal finances efficiently.',
              style: TextStyle(
                color: AppColors.fadeText,

                fontSize: 15,
                height: 1.6,
              ),
            ),

            SizedBox(
              height: 24,
            ),

            Divider(),

            SizedBox(
              height: 12,
            ),

            Center(
              child: Text(
                '© 2026 Expense Tracker\nAll rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.fadeText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
