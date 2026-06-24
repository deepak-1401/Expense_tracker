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
      // Beginning of the selected date
      final startOfDay = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );

      // Beginning of the next day
      final endOfDay = startOfDay.add(
        const Duration(
          days: 1,
        ),
      );

      // Check if an expense with the same category and same date already exists
      final existingExpense =
          await ExpenseCollection.where(
                'category.categoryId',
                isEqualTo: expense.category.categoryId,
              )
              .where(
                'date',
                isGreaterThanOrEqualTo: Timestamp.fromDate(
                  startOfDay,
                ),
              )
              .where(
                'date',
                isLessThan: Timestamp.fromDate(
                  endOfDay,
                ),
              )
              .limit(
                1,
              )
              .get();

      if (existingExpense.docs.isNotEmpty) {
        // Existing expense found -> update amount
        final oldDoc = existingExpense.docs.first;

        final oldAmount =
            (oldDoc.data()['amount']
                    as num)
                .toDouble();

        await oldDoc.reference.update(
          {
            'amount':
                oldAmount +
                expense.amount,
          },
        );
      } else {
        // No existing expense -> create new document
        await ExpenseCollection.doc(
          expense.expenseId,
        ).set(
          expense.toEntity().toDocument(),
        );
      }
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
  Stream<
    List<
      Expense
    >
  >
  getExpenses() {
    try {
      return ExpenseCollection.orderBy(
        'date',
        descending: true,
      ).snapshots().map(
        (
          snapshot,
        ) {
          return snapshot.docs.map(
            (
              doc,
            ) {
              final data = doc.data();

              data['expenseId'] = doc.id;

              return Expense.fromEntity(
                ExpenseEntity.fromDocument(
                  data,
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

  @override
  Future<
    void
  >
  deleteExpense(
    String expenseId,
  ) async {
    try {
      await ExpenseCollection.doc(
        expenseId,
      ).delete();
    } catch (
      e,
      stackTrace
    ) {
      print(
        "FIREBASE DELETE ERROR",
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
}
