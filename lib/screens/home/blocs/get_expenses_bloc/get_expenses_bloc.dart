import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_expenses_event.dart';
part 'get_expenses_state.dart';

class GetExpensesBloc
    extends
        Bloc<
          GetExpensesEvent,
          GetExpensesState
        > {
  final ExpenseRepository expenseRepository;

  StreamSubscription<
    List<
      Expense
    >
  >?
  _expenseSubscription;

  GetExpensesBloc(
    this.expenseRepository,
  ) : super(
        GetExpensesInitial(),
      ) {
    on<
      GetExpenses
    >(
      (
        event,
        emit,
      ) async {
        emit(
          GetExpensesLoading(),
        );

        await _expenseSubscription?.cancel();

        _expenseSubscription = expenseRepository.getExpenses().listen(
          (
            expenses,
          ) {
            add(
              GetExpensesUpdated(
                expenses,
              ),
            );
          },
          onError:
              (
                error,
              ) {
                add(
                  GetExpensesFailed(),
                );
              },
        );
      },
    );

    on<
      GetExpensesUpdated
    >(
      (
        event,
        emit,
      ) {
        emit(
          GetExpensesSuccess(
            event.expenses,
          ),
        );
      },
    );

    on<
      GetExpensesFailed
    >(
      (
        event,
        emit,
      ) {
        emit(
          GetExpensesFailure(),
        );
      },
    );
  }

  @override
  Future<
    void
  >
  close() {
    _expenseSubscription?.cancel();
    return super.close();
  }
}
