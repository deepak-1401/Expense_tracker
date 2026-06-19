import 'package:expense_repository/expense_repository.dart';

double
calculateTotalExpense(
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
