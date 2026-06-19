import 'package:budget_manager/models/expense_filter_model.dart';
import 'package:expense_repository/expense_repository.dart';

List<
  Expense
>
filterAndSortExpenses(
  List<
    Expense
  >
  expenses,
  ExpenseFilter? activeFilter,
) {
  List<
    Expense
  >
  filteredExpenses = List.from(
    expenses,
  );

  if (activeFilter !=
          null &&
      activeFilter.paymentMethods.isNotEmpty) {
    filteredExpenses = filteredExpenses.where(
      (
        expense,
      ) {
        return activeFilter.paymentMethods.contains(
          expense.paymentMethod,
        );
      },
    ).toList();
  }

  if (activeFilter !=
          null &&
      activeFilter.period !=
          null) {
    final now = DateTime.now();

    filteredExpenses = filteredExpenses.where(
      (
        expense,
      ) {
        final expenseDate = expense.date;

        if (activeFilter.period ==
            'Today') {
          return expenseDate.year ==
                  now.year &&
              expenseDate.month ==
                  now.month &&
              expenseDate.day ==
                  now.day;
        }

        if (activeFilter.period ==
            'This Week') {
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

        if (activeFilter.period ==
            'This Month') {
          return expenseDate.year ==
                  now.year &&
              expenseDate.month ==
                  now.month;
        }

        if (activeFilter.period ==
            'This Year') {
          return expenseDate.year ==
              now.year;
        }

        return true;
      },
    ).toList();
  }

  if (activeFilter?.sortBy ==
      'Amount Low → High') {
    filteredExpenses.sort(
      (
        a,
        b,
      ) => a.amount.compareTo(
        b.amount,
      ),
    );
  } else if (activeFilter?.sortBy ==
      'Amount High → Low') {
    filteredExpenses.sort(
      (
        a,
        b,
      ) => b.amount.compareTo(
        a.amount,
      ),
    );
  } else if (activeFilter?.sortBy ==
      'Oldest First') {
    filteredExpenses.sort(
      (
        a,
        b,
      ) => a.date.compareTo(
        b.date,
      ),
    );
  } else {
    filteredExpenses.sort(
      (
        a,
        b,
      ) => b.date.compareTo(
        a.date,
      ),
    );
  }

  return filteredExpenses;
}
