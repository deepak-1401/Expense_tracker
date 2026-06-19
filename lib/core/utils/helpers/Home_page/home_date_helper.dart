import 'package:intl/intl.dart';

String
getCurrentDate() {
  return DateFormat(
    'EEEE, d MMMM',
  ).format(
    DateTime.now(),
  );
}
