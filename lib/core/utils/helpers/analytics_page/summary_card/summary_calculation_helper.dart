import 'package:budget_manager/screens/stats/stats.dart';
import 'package:expense_repository/expense_repository.dart';

class SummaryCalculationHelper {
  static double totalSpent(
    List<
      Expense
    >
    expenses,
  ) {
    return expenses.fold(
      0,
      (
        sum,
        expense,
      ) =>
          sum +
          expense.amount,
    );
  }

  static double highestExpense(
    List<
      Expense
    >
    expenses,
  ) {
    if (expenses.isEmpty) return 0;

    return expenses
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
  }

  static MapEntry<
    String,
    double
  >?
  topCategory(
    List<
      Expense
    >
    expenses,
  ) {
    final Map<
      String,
      double
    >
    categoryTotals = {};

    for (final expense in expenses) {
      final categoryName = expense.category.name;

      categoryTotals[categoryName] =
          (categoryTotals[categoryName] ??
              0) +
          expense.amount;
    }

    if (categoryTotals.isEmpty) return null;

    return categoryTotals.entries.reduce(
      (
        a,
        b,
      ) =>
          a.value >
              b.value
          ? a
          : b,
    );
  }

  static int averageDivider(
    AnalyticsPeriod period,
  ) {
    final now = DateTime.now();

    switch (period) {
      case AnalyticsPeriod.today:
        return 24;
      case AnalyticsPeriod.week:
        return 7;
      case AnalyticsPeriod.month:
        return DateTime(
          now.year,
          now.month +
              1,
          0,
        ).day;
      case AnalyticsPeriod.year:
        return 12;
    }
  }

  static String averageTitle(
    AnalyticsPeriod period,
  ) {
    switch (period) {
      case AnalyticsPeriod.today:
        return 'Avg / Hour';
      case AnalyticsPeriod.week:
      case AnalyticsPeriod.month:
        return 'Avg / Day';
      case AnalyticsPeriod.year:
        return 'Avg / Month';
    }
  }
}
