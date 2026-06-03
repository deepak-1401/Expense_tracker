part of 'get_expenses_bloc.dart';

sealed class GetExpensesEvent
    extends
        Equatable {
  const GetExpensesEvent();

  @override
  List<
    Object
  >
  get props => [];
}

class GetExpenses
    extends
        GetExpensesEvent {}

class GetExpensesUpdated
    extends
        GetExpensesEvent {
  final List<
    Expense
  >
  expenses;

  const GetExpensesUpdated(
    this.expenses,
  );

  @override
  List<
    Object
  >
  get props => [
    expenses,
  ];
}

class GetExpensesFailed
    extends
        GetExpensesEvent {}
