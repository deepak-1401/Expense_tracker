import 'package:budget_manager/theme/colours.dart';
import 'package:flutter/material.dart';

class HelpSupportScreen
    extends
        StatelessWidget {
  const HelpSupportScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(
          20,
        ),
        children: const [
          Text(
            'How can we help you?',
            style: TextStyle(
              color: AppColors.textPrimary,

              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 8,
          ),

          Text(
            'Find answers to common questions about using Expense Tracker.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.fadeText,
            ),
          ),

          SizedBox(
            height: 24,
          ),

          _FaqTile(
            question: 'How do I add a new expense?',
            answer: 'Tap the + button or Add Expense tab, enter the amount, select a category, choose the date and payment method, then tap Save.',
          ),

          _FaqTile(
            question: 'Why are my analytics empty?',
            answer: 'Analytics will appear only after you add expenses. If there are no expenses, the charts and summaries may be empty.',
          ),

          _FaqTile(
            question: 'How do I reset my password?',
            answer: 'Go to the Forgot Password screen from the login page, enter your registered email address, and you will receive a password reset link.',
          ),

          _FaqTile(
            question: 'How do I change theme or currency?',
            answer: 'Open Settings, then select Theme or Currency. You can choose your preferred app appearance and currency format.',
          ),

          _FaqTile(
            question: 'Why are my expenses not updating?',
            answer: 'Check your internet connection and make sure you are logged in. Your expenses are stored using Firebase and need network access to sync.',
          ),

          SizedBox(
            height: 30,
          ),

          Divider(),

          SizedBox(
            height: 20,
          ),

          Text(
            'Contact Support',
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
            'If you face any issue or have suggestions, please contact the app developer.',
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.fadeText,
            ),
          ),

          SizedBox(
            height: 12,
          ),

          Row(
            children: [
              Icon(
                Icons.email_outlined,
                color: AppColors.iconColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'your-email@example.com',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FaqTile
    extends
        StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            color: AppColors.textPrimary,

            fontWeight: FontWeight.w600,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        children: [
          Text(
            answer,
            style: const TextStyle(
              color: AppColors.fadeText,

              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
