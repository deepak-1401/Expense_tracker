import 'package:expense_repository/expense_repository.dart';

class TopExpenseChartData {
  final String category;
  final double amount;
  final String color;

  TopExpenseChartData({
    required this.category,
    required this.amount,
    required this.color,
  });
}

class TopExpenseChartHelper {
  static List<
    TopExpenseChartData
  >
  getTopFiveExpenses(
    List<
      Expense
    >
    expenses,
  ) {
    final Map<
      String,
      Map<
        String,
        dynamic
      >
    >
    totals = {};

    for (final expense in expenses) {
      final name = expense.category.name;
      final color = expense.category.color;

      totals[name] = {
        'amount':
            (totals[name]?['amount'] ??
                0) +
            expense.amount,
        'color': color,
      };
    }

    final sortedCategories = totals.entries.toList()
      ..sort(
        (
          a,
          b,
        ) => b.value['amount'].compareTo(
          a.value['amount'],
        ),
      );

    return sortedCategories
        .take(
          5,
        )
        .map(
          (
            entry,
          ) {
            return TopExpenseChartData(
              category: entry.key,
              amount: entry.value['amount'],
              color: entry.value['color'],
            );
          },
        )
        .toList();
  }
}
