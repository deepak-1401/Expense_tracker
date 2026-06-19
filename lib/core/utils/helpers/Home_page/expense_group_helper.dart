import 'package:expense_repository/expense_repository.dart';
import 'package:intl/intl.dart';

Map<
  String,
  List<
    Expense
  >
>
groupExpensesByDate(
  List<
    Expense
  >
  expenses,
) {
  final Map<
    String,
    List<
      Expense
    >
  >
  groupedExpenses = {};

  final now = DateTime.now();

  final today = DateTime(
    now.year,
    now.month,
    now.day,
  );

  final yesterday = today.subtract(
    const Duration(
      days: 1,
    ),
  );

  for (final expense in expenses) {
    final expenseDay = DateTime(
      expense.date.year,
      expense.date.month,
      expense.date.day,
    );

    String dateTitle;

    if (expenseDay ==
        today) {
      dateTitle = 'TODAY';
    } else if (expenseDay ==
        yesterday) {
      dateTitle = 'YESTERDAY';
    } else {
      dateTitle =
          DateFormat(
                'd MMMM',
              )
              .format(
                expense.date,
              )
              .toUpperCase();
    }

    groupedExpenses.putIfAbsent(
      dateTitle,
      () => [],
    );

    groupedExpenses[dateTitle]!.add(
      expense,
    );
  }

  return groupedExpenses;
}
