import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  Future<
    void
  >
  createCategory(
    Category category,
  );
  Future<
    List<
      Category
    >
  >
  getCategory();

  Future<
    void
  >
  createExpense(
    Expense expense,
  );

  Stream<
    List<
      Expense
    >
  >
  getExpenses();

  Future<
    void
  >
  deleteExpense(
    String expenseId,
  );
}
