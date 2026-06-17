import 'package:budget_manager/blocs/currency_bloc/currency_bloc.dart';
import 'package:budget_manager/theme/colours.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PaymentMethodData {
  final String method;
  final double amount;
  final Color color;

  PaymentMethodData({
    required this.method,
    required this.amount,
    required this.color,
  });
}

class PaymentMethodSplitChart
    extends
        StatelessWidget {
  final List<
    Expense
  >
  expenses;

  const PaymentMethodSplitChart({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final currencyState = context
        .watch<
          CurrencyBloc
        >()
        .state;
    // final now = DateTime.now();

    // final currentMonthExpenses = expenses.where(
    //   (
    //     expense,
    //   ) {
    //     return expense.date.month ==
    //             now.month &&
    //         expense.date.year ==
    //             now.year;
    //   },
    // ).toList();

    final Map<
      String,
      double
    >
    paymentTotals = {
      "UPI": 0,
      "Credit Card": 0,
      "Cash": 0,
    };

    for (var expense in expenses) {
      final method = expense.paymentMethod.toLowerCase().trim();

      if (method ==
          "upi") {
        paymentTotals["UPI"] =
            paymentTotals["UPI"]! +
            expense.amount;
      } else if (method ==
          "credit card") {
        paymentTotals["Credit Card"] =
            paymentTotals["Credit Card"]! +
            expense.amount;
      } else if (method ==
          "cash") {
        paymentTotals["Cash"] =
            paymentTotals["Cash"]! +
            expense.amount;
      }
    }

    final List<
      PaymentMethodData
    >
    chartData =
        [
              PaymentMethodData(
                method: "UPI",
                amount: paymentTotals["UPI"]!,
                color: Theme.of(
                  context,
                ).colorScheme.primary,
              ),
              PaymentMethodData(
                method: "Credit Card",
                amount: paymentTotals["Credit Card"]!,
                color: Theme.of(
                  context,
                ).colorScheme.secondary,
              ),
              PaymentMethodData(
                method: "Cash",
                amount: paymentTotals["Cash"]!,
                color: Theme.of(
                  context,
                ).colorScheme.tertiary,
              ),
            ]
            .where(
              (
                data,
              ) =>
                  data.amount >
                  0,
            )
            .toList();

    final double totalAmount = chartData.fold(
      0,
      (
        sum,
        item,
      ) =>
          sum +
          item.amount,
    );
    String formatCurrency(
      double amount,
      String symbol,
    ) {
      return NumberFormat.currency(
        locale: 'en_IN',
        symbol: '$symbol ',
        decimalDigits: 0,
      ).format(
        amount,
      );
    }

    Widget legendItem({
      required Color color,
      required String method,
      required String percentage,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                method,
                style: const TextStyle(
                  color: AppColors.fadeText,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              percentage,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method Split",
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
          height: 280,
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
          child: chartData.isEmpty
              ? const Center(
                  child: Text(
                    "No payment data available for the selected period.",
                    style: TextStyle(
                      color: AppColors.fadeText,
                      fontSize: 13,
                    ),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SfCircularChart(
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
                                final paymentData =
                                    data
                                        as PaymentMethodData;

                                return Container(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.container,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Text(
                                    '${paymentData.method}\n₹${paymentData.amount.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              },
                        ),
                        series:
                            <
                              CircularSeries<
                                PaymentMethodData,
                                String
                              >
                            >[
                              DoughnutSeries<
                                PaymentMethodData,
                                String
                              >(
                                dataSource: chartData,
                                xValueMapper:
                                    (
                                      data,
                                      _,
                                    ) => data.method,
                                yValueMapper:
                                    (
                                      data,
                                      _,
                                    ) => data.amount,
                                pointColorMapper:
                                    (
                                      data,
                                      _,
                                    ) => data.color,
                                radius: '85%',
                                innerRadius: '70%',
                              ),
                            ],
                        annotations:
                            <
                              CircularChartAnnotation
                            >[
                              CircularChartAnnotation(
                                widget: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      formatCurrency(
                                        totalAmount,
                                        currencyState.symbol,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.fadeText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: chartData.map(
                          (
                            data,
                          ) {
                            return legendItem(
                              color: data.color,
                              method: data.method,
                              percentage: "${((data.amount / totalAmount) * 100).toStringAsFixed(0)}%",
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
