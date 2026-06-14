import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_repository/expense_repository.dart';

class SpendingTrendData {
  final int day;
  final double amount;

  SpendingTrendData({
    required this.day,
    required this.amount,
  });
}

class MySpendingChart
    extends
        StatelessWidget {
  final List<
    Expense
  >
  expenses;
  MySpendingChart({
    required this.expenses,
    super.key,
  });

  // final List<
  //   SpendingTrendData
  // >
  // chartData = [
  //   SpendingTrendData(
  //     day: 1,
  //     amount: 400,
  //   ),
  //   SpendingTrendData(
  //     day: 5,
  //     amount: 900,
  //   ),
  //   SpendingTrendData(
  //     day: 10,
  //     amount: 650,
  //   ),
  //   SpendingTrendData(
  //     day: 15,
  //     amount: 1200,
  //   ),
  //   SpendingTrendData(
  //     day: 20,
  //     amount: 850,
  //   ),
  //   SpendingTrendData(
  //     day: 25,
  //     amount: 1500,
  //   ),
  //   SpendingTrendData(
  //     day: 30,
  //     amount: 1000,
  //   ),
  // ];

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

    final currentMonthExpenses = expenses.where(
      (
        expense,
      ) {
        return expense.date.month ==
                now.month &&
            expense.date.year ==
                now.year;
      },
    ).toList();

    final Map<
      int,
      double
    >
    dailyTotals = {};
    for (final expense in currentMonthExpenses) {
      final day = expense.date.day;
      dailyTotals[day] =
          (dailyTotals[day] ??
              0) +
          expense.amount;
    }

    final chartData =
        dailyTotals.entries.map(
          (
            entry,
          ) {
            return SpendingTrendData(
              day: entry.key,
              amount: entry.value,
            );
          },
        ).toList()..sort(
          (
            a,
            b,
          ) => a.day.compareTo(
            b.day,
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Spending Trend",
          style: TextStyle(
            color: Colors.white,
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
            color: const Color(
              0xff10173A,
            ),
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.06,
              ),
              width: 1,
            ),
          ),
          child: Center(
            child: chartData.isEmpty
                ? const Center(
                    child: Text(
                      "No spending data for this month",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  )
                : SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      color: const Color(
                        0xFF1B2145,
                      ),

                      borderWidth: 0,
                      format: 'Day point.x\n₹point.y',

                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: NumericAxis(
                      minimum: 0,
                      maximum: daysInMonth.toDouble(),
                      interval: 5,
                      majorGridLines: const MajorGridLines(
                        width: 0,
                      ),
                      axisLine: const AxisLine(
                        width: 0,
                      ),
                      // labelFormat: "Day {value}",
                      labelStyle: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),

                    primaryYAxis: const NumericAxis(
                      // minimum: 0,
                      // maximum: 1600,
                      // interval: 400,
                      majorGridLines: const MajorGridLines(
                        width: 0,
                      ),
                      axisLine: const AxisLine(
                        width: 0,
                      ),
                      //labelFormat: "\${{value}}",
                      labelStyle: const TextStyle(
                        color: Colors.white54,
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
                                ) => data.day,
                            yValueMapper:
                                (
                                  SpendingTrendData data,
                                  _,
                                ) => data.amount,
                            borderWidth: 3,
                            borderColor: Color(
                              0xffffffff,
                            ),
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
      ],
    );
  }
}
