import 'package:budget_manager/data/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Mychart
    extends
        StatefulWidget {
  const Mychart({
    super.key,
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
  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: MediaQuery.of(
        context,
      ).size.width,
      height: MediaQuery.of(
        context,
      ).size.width,
      child: PieChart(
        PieChartData(
          sections: List.generate(
            transactionData.length,
            (
              i,
            ) {
              return PieChartSectionData(
                value: transactionData[i]['todayExpense'],
                color: transactionData[i]['color'],
                radius:
                    MediaQuery.of(
                      context,
                    ).size.width *
                    0.3,
                title: transactionData[i]['name'],
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
