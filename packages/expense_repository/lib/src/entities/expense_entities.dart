import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/entities/category_entities.dart';
import 'package:expense_repository/src/models/models.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  double amount;
  String paymentMethod;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
    required this.paymentMethod,
  });

  Map<
    String,
    dynamic
  >
  toDocument() {
    return {
      'ExpenseId': expenseId,
      'category': category.toEntity().toDocument(),
      'date': date,
      'amount': amount,
      'PaymentMethod': paymentMethod,
    };
  }

  static ExpenseEntity fromDocument(
    Map<
      String,
      dynamic
    >
    doc,
  ) {
    return ExpenseEntity(
      expenseId: doc['ExpenseId'],
      category: Category.fromEntity(
        CategoryEntity.fromDocument(
          doc['category'],
        ),
      ),
      date:
          (doc['date']
                  as Timestamp)
              .toDate(),
      amount: doc['amount'],
      paymentMethod: doc['PaymentMethod'],
    );
  }
}
