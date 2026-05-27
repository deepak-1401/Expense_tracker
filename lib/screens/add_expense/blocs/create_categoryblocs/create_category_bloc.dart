import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:flutter/foundation.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends
        Bloc<
          CreateCategoryEvent,
          CreateCategoryState
        > {
  final ExpenseRepository expenserepository;
  CreateCategoryBloc(
    this.expenserepository,
  ) : super(
        CreateCategoryInitial(),
      ) {
    on<
      CreateCategory
    >(
      (
        event,
        emit,
      ) async {
        emit(
          CreateCategoryLoading(),
        );
        try {
          await expenserepository.createCategory(
            event.category,
          );
          emit(
            CreateCategorySuccess(),
          );
        } catch (
          e
        ) {
          print(
            "BLOC ERROR",
          );
          print(
            e,
          );

          emit(
            CreateCategoryFailure(),
          );
        }
      },
    );
  }
}
