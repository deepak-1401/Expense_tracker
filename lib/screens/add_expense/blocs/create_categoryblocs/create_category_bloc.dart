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
  final ExpenseRepository expenseRepository;

  CreateCategoryBloc(
    this.expenseRepository,
  ) : super(
        CreateCategoryInitial(),
      ) {
    on<
      LoadCategories
    >(
      (
        event,
        emit,
      ) async {
        emit(
          CreateCategoryLoading(),
        );
        try {
          final cats = await expenseRepository.getCategory();
          emit(
            CreateCategoryLoadSuccess(
              cats,
            ),
          );
        } catch (
          e
        ) {
          emit(
            CreateCategoryFailure(),
          );
        }
      },
    );

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
          await expenseRepository.createCategory(
            event.category,
          );
          final cats = await expenseRepository.getCategory();
          emit(
            CreateCategoryLoadSuccess(
              cats,
            ),
          );
        } catch (
          e
        ) {
          emit(
            CreateCategoryFailure(),
          );
        }
      },
    );
  }
}
