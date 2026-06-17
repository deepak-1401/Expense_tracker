import 'package:budget_manager/theme/colours.dart';
import 'package:budget_manager/screens/stats/stats.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_repository/expense_repository.dart';

class SpendingTrendData {
  final int xValue;
  final double amount;

  SpendingTrendData({
    required this.xValue,
    required this.amount,
  });
}

class MySpendingChart
    extends
        StatelessWidget {
  final AnalyticsPeriod selectedPeriod;

  final List<
    Expense
  >
  expenses;
  const MySpendingChart({
    required this.expenses,
    super.key,
    required this.selectedPeriod,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final now = DateTime.now();
    final daysInMonth = DateTime(
      now.year,
      now.month +
          1,
      0,
    ).day;

    final Map<
      int,
      double
    >
    dailyTotals = {};
    int getXAxisValue(
      DateTime date,
    ) {
      switch (selectedPeriod) {
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

    for (final expense in expenses) {
      final xValue = getXAxisValue(
        expense.date,
      );

      dailyTotals[xValue] =
          (dailyTotals[xValue] ??
              0) +
          expense.amount;
    }

    final chartData =
        dailyTotals.entries.map(
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
    double getXAxisMaximum() {
      switch (selectedPeriod) {
        case AnalyticsPeriod.today:
          return 24;

        case AnalyticsPeriod.week:
          return 7;

        case AnalyticsPeriod.month:
          return daysInMonth.toDouble();

        case AnalyticsPeriod.year:
          return 12;
      }
    }

    double getXAxisInterval() {
      switch (selectedPeriod) {
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

    String getTooltipLabel(
      int value,
    ) {
      if (selectedPeriod ==
          AnalyticsPeriod.today) {
        if (value ==
            0) {
          return '12AM';
        }
        if (value <
            12) {
          return '${value}AM';
        }
        if (value ==
            12) {
          return '12PM';
        }
        return '${value - 12}PM';
      }

      if (selectedPeriod ==
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

      if (selectedPeriod ==
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Spending Trend",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 12,
        ),

        Container(
          height: 260,
          width: double.infinity,
          padding: const EdgeInsets.all(
            16,
          ),
          decoration: BoxDecoration(
            color: AppColors.container,
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: AppColors.fadeText.withValues(
                alpha: 0.06,
              ),
              width: 1,
            ),
          ),
          child: Center(
            child: chartData.isEmpty
                ? const Center(
                    child: Text(
                      "No spending data available for the selected period.",
                      style: TextStyle(
                        color: AppColors.fadeText,
                        fontSize: 13,
                      ),
                    ),
                  )
                : SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      color: AppColors.primary,
                      builder:
                          (
                            data,
                            point,
                            series,
                            pointIndex,
                            seriesIndex,
                          ) {
                            final chartData =
                                data
                                    as SpendingTrendData;

                            return Container(
                              padding: const EdgeInsets.all(
                                10,
                              ),
                              child: Text(
                                '${getTooltipLabel(chartData.xValue)} : ₹${chartData.amount.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                    ),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: NumericAxis(
                      minimum: 0,
                      maximum: getXAxisMaximum(),

                      interval: getXAxisInterval(),

                      majorGridLines: const MajorGridLines(
                        width: 0,
                      ),
                      axisLine: const AxisLine(
                        width: 0,
                      ),
                      // labelFormat: "Day {value}",
                      labelStyle: const TextStyle(
                        color: AppColors.fadeText,
                        fontSize: 11,
                      ),
                      axisLabelFormatter:
                          (
                            AxisLabelRenderDetails details,
                          ) {
                            final value = details.value.toInt();

                            String label = value.toString();

                            if (selectedPeriod ==
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
                              label = days[value];
                            }

                            if (selectedPeriod ==
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
                              label = months[value];
                            }

                            if (selectedPeriod ==
                                AnalyticsPeriod.today) {
                              if (value ==
                                  0) {
                                label = '12AM';
                              } else if (value <
                                  12) {
                                label = '${value}AM';
                              } else if (value ==
                                  12) {
                                label = '12PM';
                              } else {
                                label = '${value - 12}AM';
                              }
                            }

                            return ChartAxisLabel(
                              label,
                              details.textStyle,
                            );
                          },
                    ),

                    primaryYAxis: const NumericAxis(
                      // minimum: 0,
                      // maximum: 1600,
                      // interval: 400,
                      majorGridLines: MajorGridLines(
                        width: 0,
                      ),
                      axisLine: AxisLine(
                        width: 0,
                      ),
                      //labelFormat: "\${{value}}",
                      labelStyle: TextStyle(
                        color: AppColors.fadeText,
                        fontSize: 11,
                      ),
                    ),

                    series:
                        <
                          CartesianSeries<
                            SpendingTrendData,
                            int
                          >
                        >[
                          SplineAreaSeries<
                            SpendingTrendData,
                            int
                          >(
                            dataSource: chartData,
                            xValueMapper:
                                (
                                  SpendingTrendData data,
                                  _,
                                ) => data.xValue,
                            yValueMapper:
                                (
                                  SpendingTrendData data,
                                  _,
                                ) => data.amount,
                            borderWidth: 3,
                            borderColor: AppColors.textPrimary,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Theme.of(
                                  context,
                                ).colorScheme.primary,
                                Theme.of(
                                  context,
                                ).colorScheme.secondary,
                                Theme.of(
                                  context,
                                ).colorScheme.tertiary,
                              ],
                            ),
                            markerSettings: const MarkerSettings(
                              isVisible: true,
                              height: 6,
                              width: 6,
                            ),
                          ),
                        ],
                  ),
          ),
        ),
        Divider(
          color: AppColors.fadeText.withValues(
            alpha: 0.2,
          ),
          thickness: 1,
          height: 40,
        ),
      ],
    );
  }
}
