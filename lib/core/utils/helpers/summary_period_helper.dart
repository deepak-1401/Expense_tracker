import 'package:intl/intl.dart';
import 'package:budget_manager/screens/stats/stats.dart';

class SummaryPeriodHelper {
  static String getTitle(
    AnalyticsPeriod period,
  ) {
    switch (period) {
      case AnalyticsPeriod.today:
        return 'Today Summary';
      case AnalyticsPeriod.week:
        return 'Weekly Summary';
      case AnalyticsPeriod.month:
        return 'Monthly Summary';
      case AnalyticsPeriod.year:
        return 'Yearly Summary';
    }
  }

  static String getSubtitle(
    AnalyticsPeriod period,
  ) {
    final now = DateTime.now();

    switch (period) {
      case AnalyticsPeriod.today:
        return DateFormat(
          'dd MMM yyyy',
        ).format(
          now,
        );

      case AnalyticsPeriod.week:
        final startOfWeek = now.subtract(
          Duration(
            days:
                now.weekday -
                1,
          ),
        );

        final endOfWeek = startOfWeek.add(
          const Duration(
            days: 6,
          ),
        );

        return '${DateFormat('dd MMM').format(startOfWeek)} - ${DateFormat('dd MMM').format(endOfWeek)}';

      case AnalyticsPeriod.month:
        return DateFormat(
          'MMMM yyyy',
        ).format(
          now,
        );

      case AnalyticsPeriod.year:
        return DateFormat(
          'yyyy',
        ).format(
          now,
        );
    }
  }
}
