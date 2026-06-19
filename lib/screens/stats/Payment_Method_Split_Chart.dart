import 'package:budget_manager/blocs/currency_bloc/currency_bloc.dart';
import 'package:budget_manager/core/utils/helpers/analytics_page/payment_method_split/payment_split_helper.dart';
import 'package:budget_manager/core/utils/helpers/shared/currency_formatter.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    final currencyState = context
        .watch<
          CurrencyBloc
        >()
        .state;

    final paymentTotals = PaymentSplitHelper.generatePaymentTotals(
      expenses,
    );

    final chartData = paymentTotals.map(
      (
        data,
      ) {
        return PaymentMethodData(
          method: data.method,
          amount: data.amount,
          color: switch (data.method) {
            'UPI' => Theme.of(
              context,
            ).colorScheme.primary,
            'Credit Card' => Theme.of(
              context,
            ).colorScheme.secondary,
            'Cash' => Theme.of(
              context,
            ).colorScheme.tertiary,
            _ => Theme.of(
              context,
            ).colorScheme.primary,
          },
        );
      },
    ).toList();

    final totalAmount = PaymentSplitHelper.calculateTotalAmount(
      expenses,
    );

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
                style: TextStyle(
                  color: extraColors.fadeText,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              percentage,
              style: TextStyle(
                color: extraColors.textPrimary,
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
        Text(
          "Payment Method Split",
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
          height: 280,
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
          child: chartData.isEmpty
              ? Center(
                  child: Text(
                    "No payment data available for the selected period.",
                    style: TextStyle(
                      color: extraColors.fadeText,
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
                                final paymentData =
                                    data
                                        as PaymentMethodData;

                                return Container(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: extraColors.container,
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Text(
                                    '${paymentData.method}\n₹${paymentData.amount.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      color: extraColors.textPrimary,
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
                                      CurrencyFormatter.format(
                                        amount: totalAmount,
                                        symbol: currencyState.symbol,
                                      ),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: extraColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: extraColors.fadeText,
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
