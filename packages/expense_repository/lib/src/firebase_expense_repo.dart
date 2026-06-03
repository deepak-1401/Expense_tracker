import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FirebaseExpenseRepo
    implements
        ExpenseRepository {
  final CategoryCollection = FirebaseFirestore.instance.collection(
    'categories',
  );
  final ExpenseCollection = FirebaseFirestore.instance.collection(
    'expenses',
  );

  @override
  Future<
    void
  >
  createCategory(
    Category category,
  ) async {
    try {
      await CategoryCollection.doc(
        category.categoryId,
      ).set(
        category.toEntity().toDocument(),
      );
    } catch (
      e,
      stackTrace
    ) {
      print(
        "FIREBASE WRITE ERROR",
      );
      print(
        e,
      );
      print(
        stackTrace,
      );

      rethrow;
    }
  }

  @override
  Future<
    List<
      Category
    >
  >
  getCategory() async {
    try {
      return await CategoryCollection.get().then(
        (
          value,
        ) => value.docs
            .map(
              (
                e,
              ) => Category.fromEntity(
                CategoryEntity.fromDocument(
                  e.data(),
                ),
              ),
            )
            .toList(),
      );
    } catch (
      e
    ) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }

  @override
  Future<
    void
  >
  createExpense(
    Expense expense,
  ) async {
    try {
      await ExpenseCollection.doc(
        expense.expenseId,
      ).set(
        expense.toEntity().toDocument(),
      );
    } catch (
      e,
      stackTrace
    ) {
      print(
        "FIREBASE WRITE ERROR",
      );
      print(
        e,
      );
      print(
        stackTrace,
      );

      rethrow;
    }
  }

  @override
  @override
  Stream<
    List<
      Expense
    >
  >
  getExpenses() {
    try {
      return ExpenseCollection.snapshots().map(
        (
          snapshot,
        ) {
          return snapshot.docs.map(
            (
              doc,
            ) {
              return Expense.fromEntity(
                ExpenseEntity.fromDocument(
                  doc.data(),
                ),
              );
            },
          ).toList();
        },
      );
    } catch (
      e
    ) {
      log(
        e.toString(),
      );
      rethrow;
    }
  }
}
