import 'package:budget_manager/theme/colours.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen
    extends
        StatelessWidget {
  const PrivacyPolicyScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(
          20,
        ),
        child: Text(
          '''
Privacy Policy

Last updated: June 2026

This Privacy Policy explains how Expense Tracker handles user information.

1. Information We Collect

Expense Tracker may collect and store information such as your name, email address, profile details, expense amount, category, date, payment method, and description.

2. How We Use Your Information

Your information is used to:
- Create and manage your account
- Save and display your expenses
- Show charts and summaries
- Improve the app experience

3. Data Storage

Your data may be stored using Firebase services, including Firebase Authentication and Cloud Firestore.

4. Account Information

Your email address is used for login, authentication, password reset, and account identification.

5. Expense Data

Expense details entered by you are used only for tracking and displaying your personal expense history.

6. Data Security

We try to keep your data safe using Firebase security features and database rules. However, no online service can be guaranteed to be completely secure.

7. Data Sharing

We do not sell or share your personal expense data with third parties for marketing purposes.

8. User Responsibility

You are responsible for entering accurate information and keeping your login details safe.

9. Changes to This Policy

This Privacy Policy may be updated in the future. Continued use of the app means you accept the updated policy.

10. Contact

For questions about this Privacy Policy, please contact the app developer.
          ''',
          style: TextStyle(
            color: AppColors.textPrimary,

            fontSize: 15,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
