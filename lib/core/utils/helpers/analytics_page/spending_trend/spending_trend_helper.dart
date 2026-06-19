import 'package:budget_manager/screens/stats/stats.dart';
import 'package:expense_repository/expense_repository.dart';

class SpendingTrendData {
  final int xValue;
  final double amount;

  SpendingTrendData({
    required this.xValue,
    required this.amount,
  });
}

class SpendingTrendHelper {
  static int getXAxisValue(
    DateTime date,
    AnalyticsPeriod period,
  ) {
    switch (period) {
      case AnalyticsPeriod.today:
        return date.hour;
      case AnalyticsPeriod.week:
        return date.weekday;
      case AnalyticsPeriod.month:
        return date.day;
      case AnalyticsPeriod.year:
        return date.month;
    }
  }

  static List<
    SpendingTrendData
  >
  generateChartData(
    List<
      Expense
    >
    expenses,
    AnalyticsPeriod period,
  ) {
    final Map<
      int,
      double
    >
    totals = {};

    for (final expense in expenses) {
      final xValue = getXAxisValue(
        expense.date,
        period,
      );

      totals[xValue] =
          (totals[xValue] ??
              0) +
          expense.amount;
    }

    return totals.entries.map(
      (
        entry,
      ) {
        return SpendingTrendData(
          xValue: entry.key,
          amount: entry.value,
        );
      },
    ).toList()..sort(
      (
        a,
        b,
      ) => a.xValue.compareTo(
        b.xValue,
      ),
    );
  }

  static double getXAxisMaximum(
    AnalyticsPeriod period,
  ) {
    final now = DateTime.now();

    switch (period) {
      case AnalyticsPeriod.today:
        return 24;
      case AnalyticsPeriod.week:
        return 7;
      case AnalyticsPeriod.month:
        return DateTime(
          now.year,
          now.month +
              1,
          0,
        ).day.toDouble();
      case AnalyticsPeriod.year:
        return 12;
    }
  }

  static double getXAxisInterval(
    AnalyticsPeriod period,
  ) {
    switch (period) {
      case AnalyticsPeriod.today:
        return 4;
      case AnalyticsPeriod.week:
        return 1;
      case AnalyticsPeriod.month:
        return 5;
      case AnalyticsPeriod.year:
        return 1;
    }
  }

  static String getTooltipLabel(
    int value,
    AnalyticsPeriod period,
  ) {
    if (period ==
        AnalyticsPeriod.today) {
      if (value ==
          0)
        return '12AM';
      if (value <
          12)
        return '${value}AM';
      if (value ==
          12)
        return '12PM';
      return '${value - 12}AM';
    }

    if (period ==
        AnalyticsPeriod.week) {
      const days = [
        '',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];
      return days[value];
    }

    if (period ==
        AnalyticsPeriod.year) {
      const months = [
        '',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return months[value];
    }

    return 'Day $value';
  }

  static String getAxisLabel(
    int value,
    AnalyticsPeriod period,
  ) {
    if (period ==
        AnalyticsPeriod.week) {
      const days = [
        '',
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ];
      return days[value];
    }

    if (period ==
        AnalyticsPeriod.year) {
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return months[value];
    }

    if (period ==
        AnalyticsPeriod.today) {
      if (value ==
          0)
        return '12AM';
      if (value <
          12)
        return '${value}AM';
      if (value ==
          12)
        return '12PM';
      return '${value - 12}PM';
    }

    return value.toString();
  }
}
