import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format({
    required double amount,
    required String symbol,
    String locale = 'en_IN',
    int decimalDigits = 0,
  }) {
    return NumberFormat.currency(
      locale: locale,
      symbol: '$symbol ',
      decimalDigits: decimalDigits,
    ).format(
      amount,
    );
  }

  static String hiddenAmount(
    String symbol,
  ) {
    return '$symbol ••••••';
  }
}
