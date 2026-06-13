import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';

class SummaryCardLayout
    extends
        StatelessWidget {
  final List<
    Expense
  >
  expenses;

  const SummaryCardLayout({
    super.key,
    required this.expenses,
  });

  Widget summaryCard({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(
          6,
        ),
        padding: const EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          color: const Color(
            0xFF10173A,
          ),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white70,
              size: 22,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle !=
                null) ...[
              const SizedBox(
                height: 4,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    //Total Spent Logic
    final totalSpent =
        expenses.fold<
          double
        >(
          0,
          (
            sum,
            expense,
          ) =>
              sum +
              expense.amount,
        );
    //Highest Expense Logic
    final highestExpense = expenses.isEmpty
        ? 0.0
        : expenses
              .map(
                (
                  expense,
                ) => expense.amount,
              )
              .reduce(
                (
                  a,
                  b,
                ) =>
                    a >
                        b
                    ? a
                    : b,
              );
    //Top Category Logic
    final Map<
      String,
      double
    >
    categoryTotals = {};

    for (var expense in expenses) {
      final categoryName = expense.category.name;

      categoryTotals[categoryName] =
          (categoryTotals[categoryName] ??
              0) +
          expense.amount;
    }

    final topCategoryEntry = categoryTotals.isEmpty
        ? null
        : categoryTotals.entries.reduce(
            (
              a,
              b,
            ) =>
                a.value >
                    b.value
                ? a
                : b,
          );

    final topCategoryName =
        topCategoryEntry?.key ??
        "No data";
    final topCategoryAmount =
        topCategoryEntry?.value ??
        0.0;

    //Average Per Day Logic
    final int currentDay = DateTime.now().day;
    final double averagePerDay =
        currentDay ==
            0
        ? 0
        : totalSpent /
              currentDay;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monthly Summary",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "June 2026",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              summaryCard(
                icon: Icons.local_fire_department_outlined,
                title: "Highest",
                value: "₹${highestExpense.toStringAsFixed(0)}",
              ),
              summaryCard(
                icon: Icons.emoji_events_outlined,
                title: "Top Category",
                value: topCategoryName,
                subtitle: "₹${topCategoryAmount.toStringAsFixed(0)}",
              ),
              summaryCard(
                icon: Icons.calendar_today_outlined,
                title: "Avg / Day",
                value: "₹${averagePerDay.toStringAsFixed(0)}",
              ),
            ],
          ),
        ),

        IntrinsicHeight(
          child: Row(
            children: [
              summaryCard(
                icon: Icons.account_balance_wallet_outlined,
                title: "Total Spent",
                value: "₹${totalSpent.toStringAsFixed(0)}",
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.white24,
          thickness: 1,
          height: 40,
        ),
      ],
    );
  }
}
