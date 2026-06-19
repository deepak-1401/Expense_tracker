import 'package:budget_manager/core/utils/helpers/analytics_page/spending_trend/spending_trend_helper.dart';
import 'package:budget_manager/core/utils/helpers/shared/currency_formatter.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/screens/stats/stats.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expense_repository/expense_repository.dart';

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
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;

    final chartData = SpendingTrendHelper.generateChartData(
      expenses,
      selectedPeriod,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Spending Trend",
          style: TextStyle(
            color: extraColors.textPrimary,
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
            color: extraColors.container,
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: extraColors.fadeText.withValues(
                alpha: 0.06,
              ),
              width: 1,
            ),
          ),
          child: Center(
            child: chartData.isEmpty
                ? Center(
                    child: Text(
                      "No spending data available for the selected period.",
                      style: TextStyle(
                        color: extraColors.fadeText,
                        fontSize: 13,
                      ),
                    ),
                  )
                : SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary,
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
                                '${SpendingTrendHelper.getTooltipLabel(chartData.xValue, selectedPeriod)} : ${CurrencyFormatter.format(amount: chartData.amount, symbol: "₹")}',
                                style: TextStyle(
                                  color: extraColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                    ),
                    plotAreaBorderWidth: 0,
                    primaryXAxis: NumericAxis(
                      minimum: 0,
                      maximum: SpendingTrendHelper.getXAxisMaximum(
                        selectedPeriod,
                      ),
                      interval: SpendingTrendHelper.getXAxisInterval(
                        selectedPeriod,
                      ),
                      majorGridLines: const MajorGridLines(
                        width: 0,
                      ),
                      axisLine: const AxisLine(
                        width: 0,
                      ),
                      // labelFormat: "Day {value}",
                      labelStyle: TextStyle(
                        color: extraColors.fadeText,
                        fontSize: 11,
                      ),
                      axisLabelFormatter:
                          (
                            AxisLabelRenderDetails details,
                          ) {
                            final label = SpendingTrendHelper.getAxisLabel(
                              details.value.toInt(),
                              selectedPeriod,
                            );

                            return ChartAxisLabel(
                              label,
                              details.textStyle,
                            );
                          },
                    ),

                    primaryYAxis: NumericAxis(
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
                      labelStyle: TextStyle(
                        color: extraColors.fadeText,
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
                            borderColor: extraColors.textPrimary,
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
