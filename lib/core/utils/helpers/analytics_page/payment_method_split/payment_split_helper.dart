import 'package:expense_repository/expense_repository.dart';

class PaymentTotalData {
  final String method;
  final double amount;

  PaymentTotalData({
    required this.method,
    required this.amount,
  });
}

class PaymentSplitHelper {
  static List<
    PaymentTotalData
  >
  generatePaymentTotals(
    List<
      Expense
    >
    expenses,
  ) {
    final Map<
      String,
      double
    >
    paymentTotals = {
      'UPI': 0,
      'Credit Card': 0,
      'Cash': 0,
    };

    for (final expense in expenses) {
      paymentTotals[expense.paymentMethod] =
          (paymentTotals[expense.paymentMethod] ??
              0) +
          expense.amount;
    }

    return paymentTotals.entries
        .map(
          (
            entry,
          ) => PaymentTotalData(
            method: entry.key,
            amount: entry.value,
          ),
        )
        .where(
          (
            data,
          ) =>
              data.amount >
              0,
        )
        .toList();
  }

  static double calculateTotalAmount(
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
}
