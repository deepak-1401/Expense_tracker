import 'package:budget_manager/screens/stats/stats.dart';
import 'package:expense_repository/expense_repository.dart';

List<
  Expense
>
applyAnalyticsFilter(
  List<
    Expense
  >
  expenses,
  AnalyticsPeriod selectedPeriod,
) {
  final now = DateTime.now();

  return expenses.where(
    (
      expense,
    ) {
      final expenseDate = expense.date;

      if (selectedPeriod ==
          AnalyticsPeriod.today) {
        return expenseDate.year ==
                now.year &&
            expenseDate.month ==
                now.month &&
            expenseDate.day ==
                now.day;
      }

      if (selectedPeriod ==
          AnalyticsPeriod.week) {
        final startOfWeek =
            DateTime(
              now.year,
              now.month,
              now.day,
            ).subtract(
              Duration(
                days:
                    now.weekday -
                    1,
              ),
            );

        final endOfWeek = startOfWeek.add(
          const Duration(
            days: 7,
          ),
        );

        return !expenseDate.isBefore(
              startOfWeek,
            ) &&
            expenseDate.isBefore(
              endOfWeek,
            );
      }

      if (selectedPeriod ==
          AnalyticsPeriod.month) {
        return expenseDate.year ==
                now.year &&
            expenseDate.month ==
                now.month;
      }

      if (selectedPeriod ==
          AnalyticsPeriod.year) {
        return expenseDate.year ==
            now.year;
      }

      return true;
    },
  ).toList();
}
