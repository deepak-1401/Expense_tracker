import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
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
    final now = DateTime.now();

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
      String,
      double
    >
    paymentTotals = {
      "UPI": 0,
      "Credit Card": 0,
      "Cash": 0,
    };

    for (var expense in currentMonthExpenses) {
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
                  color: Colors.white70,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              percentage,
              style: const TextStyle(
                color: Colors.white,
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
            color: Colors.white,
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
          child: chartData.isEmpty
              ? const Center(
                  child: Text(
                    "No payment data this month",
                    style: TextStyle(
                      color: Colors.white54,
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
                          color: const Color(
                            0xFF1B2145,
                          ),
                          borderWidth: 0,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
                                innerRadius: '55%',
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
