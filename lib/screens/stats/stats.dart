//import 'dart:math';
import 'package:budget_manager/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_manager/screens/stats/top_5_expense_chart.dart';
import 'package:budget_manager/screens/stats/SpendingTrendChart.dart';
import 'package:budget_manager/screens/stats/Payment_Method_Split_Chart.dart';
import 'package:budget_manager/screens/stats/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatScreen
    extends
        StatefulWidget {
  const StatScreen({
    super.key,
  });

  @override
  State<
    StatScreen
  >
  createState() => _StatScreenState();
}

enum AnalyticsPeriod {
  today,
  week,
  month,
  year,
}

class _StatScreenState
    extends
        State<
          StatScreen
        > {
  AnalyticsPeriod selectedPeriod = AnalyticsPeriod.month;
  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child:
          BlocBuilder<
            GetExpensesBloc,
            GetExpensesState
          >(
            builder:
                (
                  context,
                  state,
                ) {
                  if (state
                      is GetExpensesSuccess) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Analytics",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: Colors.white24,
                              thickness: 1,
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: AnalyticsPeriod.values.map(
                                (
                                  period,
                                ) {
                                  final isSelected =
                                      selectedPeriod ==
                                      period;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          selectedPeriod = period;
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : Colors.white.withOpacity(
                                                0.08,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                      ),
                                      child: Text(
                                        period.name.toUpperCase(),
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white70,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            Divider(
                              color: Colors.white24,
                              thickness: 1,
                              height: 40,
                            ),
                            SummaryCardLayout(
                              expenses: state.expenses,
                            ),

                            MySpendingChart(
                              expenses: state.expenses,
                            ),
                            Mychart(
                              expenses: state.expenses,
                            ),

                            PaymentMethodSplitChart(
                              expenses: state.expenses,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
          ),
    );
  }
}
