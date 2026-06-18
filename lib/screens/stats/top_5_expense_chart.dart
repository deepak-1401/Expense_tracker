import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String category;
  final double amount;
  final String color;

  ChartData({
    required this.category,
    required this.amount,
    required this.color,
  });
}

class Mychart
    extends
        StatefulWidget {
  final List<
    Expense
  >
  expenses;

  const Mychart({
    super.key,
    required this.expenses,
  });

  @override
  State<
    Mychart
  >
  createState() => _MychartState();
}

class _MychartState
    extends
        State<
          Mychart
        > {
  Map<
    String,
    Map<
      String,
      dynamic
    >
  >
  getCategoryTotals() {
    final Map<
      String,
      Map<
        String,
        dynamic
      >
    >
    totals = {};

    for (var expense in widget.expenses) {
      final name = expense.category.name;
      final color = expense.category.color;

      if (totals.containsKey(
        name,
      )) {
        totals[name]!['amount'] += expense.amount;
      } else {
        totals[name] = {
          'amount': expense.amount,
          'color': color,
        };
      }
    }

    return totals;
  }

  List<
    ChartData
  >
  getChartData() {
    final categoryTotals = getCategoryTotals();

    final sortedCategories = categoryTotals.entries.toList()
      ..sort(
        (
          a,
          b,
        ) => b.value['amount'].compareTo(
          a.value['amount'],
        ),
      );

    final topCategories = sortedCategories
        .take(
          5,
        )
        .toList();

    return topCategories.map(
      (
        entry,
      ) {
        return ChartData(
          category: entry.key,
          amount: entry.value['amount'],
          color: entry.value['color'],
        );
      },
    ).toList();
  }

  String formatCurrency(
    double amount,
  ) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    ).format(
      amount,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    final chartData = getChartData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top 5 Expenses",
          style: TextStyle(
            color: extraColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: MediaQuery.of(
            context,
          ).size.width,
          height: 320,
          child: Container(
            width: MediaQuery.of(
              context,
            ).size.width,
            padding: const EdgeInsets.all(
              16.0,
            ),
            decoration: BoxDecoration(
              color: extraColors.container,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: chartData.isEmpty
                ? Center(
                    child: Text(
                      'No expense data available for the selected period.',
                      style: TextStyle(
                        color: extraColors.fadeText,
                      ),
                    ),
                  )
                : SfCartesianChart(
                    backgroundColor: Colors.transparent,
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      isInversed: true,
                      majorGridLines: const MajorGridLines(
                        width: 0,
                      ),
                      labelStyle: TextStyle(
                        color: extraColors.fadeText,
                        fontSize: 12,
                      ),
                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: false,
                      majorGridLines: const MajorGridLines(
                        width: 0,
                      ),
                    ),
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                    ),
                    series:
                        <
                          CartesianSeries
                        >[
                          BarSeries<
                            ChartData,
                            String
                          >(
                            dataSource: chartData,
                            xValueMapper:
                                (
                                  ChartData data,
                                  _,
                                ) => data.category,
                            yValueMapper:
                                (
                                  ChartData data,
                                  _,
                                ) => data.amount,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              labelAlignment: ChartDataLabelAlignment.outer,
                              textStyle: TextStyle(
                                color: extraColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Theme.of(
                                  context,
                                ).colorScheme.secondary,
                                Theme.of(
                                  context,
                                ).colorScheme.primary,
                                Theme.of(
                                  context,
                                ).colorScheme.tertiary,
                              ],
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                12,
                              ),
                            ),
                          ),
                        ],
                  ),
          ),
        ),
        Divider(
          color: extraColors.fadeText.withValues(
            alpha: 0.2,
          ),
          thickness: 1,
          height: 40,
        ),
      ],
    );
  }
}
