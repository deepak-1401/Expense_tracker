import 'package:intl/intl.dart';

class AddExpenseDateHelper {
  static String formatSelectedDate(
    DateTime date,
  ) {
    return DateFormat(
      'dd-MM-yyyy',
    ).format(
      date,
    );
  }
}
