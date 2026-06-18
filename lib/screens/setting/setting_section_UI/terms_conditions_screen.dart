import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:flutter/material.dart';

class TermsConditionsScreen
    extends
        StatelessWidget {
  const TermsConditionsScreen({
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
          'Terms & Conditions',
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
        child: Text(
          '''
Terms & Conditions

Last updated: June 2026

Welcome to Expense Tracker. By using this app, you agree to follow these Terms & Conditions.

1. App Purpose

Expense Tracker is designed to help users record, organize, and review their personal expenses. The app is for personal finance tracking only.

2. User Responsibility

You are responsible for the accuracy of the expense details you enter in the app, including amount, category, date, payment method, and description.

3. Account Security

You are responsible for keeping your login details safe. Do not share your account password with others.

4. Data Storage

Your expense and profile information may be stored using Firebase services. This helps the app save and display your data across sessions.

5. No Financial Advice

Expense Tracker does not provide financial, investment, tax, or legal advice. The charts and summaries shown in the app are only for personal understanding.

6. App Availability

We try to keep the app working properly, but we do not guarantee that the app will always be available, error-free, or uninterrupted.

7. Limitation of Liability

We are not responsible for any loss, damage, or incorrect decision made based on the information shown in the app.

8. Changes to Terms

These Terms & Conditions may be updated in the future. Continued use of the app means you accept the updated terms.

9. Contact

For questions or support, please contact the app developer.
          ''',
          style: TextStyle(
            color: extraColors.textPrimary,
            fontSize: 15,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
