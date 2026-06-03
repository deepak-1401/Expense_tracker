//import 'package:budget_manager/data/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';
//import 'package:budget_manager/blocs/get_expense_bloc/get_expense_bloc.dart';

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
    Map<
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

  Color colorFromString(
    String colorString,
  ) {
    if (colorString.isEmpty) {
      return Colors.purple;
    }

    return Color(
      int.parse(
        colorString.replaceAll(
          '#',
          '0xff',
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final categoryTotals = getCategoryTotals();
    // print(
    //   widget.expenses.length,
    // );
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
            categoryTotals.length,
            (
              i,
            ) {
              final entry = categoryTotals.entries.toList()[i];
              return PieChartSectionData(
                value: entry.value['amount'],
                color: colorFromString(
                  entry.value['color'],
                ),
                radius:
                    MediaQuery.of(
                      context,
                    ).size.width *
                    0.3,
                title: entry.key,
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
