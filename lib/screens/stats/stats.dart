//import 'dart:math';
import 'package:budget_manager/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_manager/screens/stats/Bar_chart.dart';
import 'package:budget_manager/screens/stats/SpendingTrendChart.dart';
import 'package:budget_manager/screens/stats/category_breakdown_chart.dart';
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

class _StatScreenState
    extends
        State<
          StatScreen
        > {
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

                            const SizedBox(
                              height: 24,
                            ),

                            SummaryCardLayout(
                              expenses: state.expenses,
                            ),

                            const SizedBox(
                              height: 28,
                            ),

                            const Text(
                              "Top 5 Expenses",
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
                              width: MediaQuery.of(
                                context,
                              ).size.width,
                              height: MediaQuery.of(
                                context,
                              ).size.width,
                              padding: const EdgeInsets.all(
                                16.0,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xff10173A,
                                ),
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Mychart(
                                expenses: state.expenses,
                              ),
                            ),
                            // SizedBox(
                            //   height: 28,
                            // ),
                            // const Text(
                            //   "Spending Trend",
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 12,
                            ),
                            MySpendingChart(
                              expenses: state.expenses,
                            ),

                            const SizedBox(
                              height: 28,
                            ),

                            CategoryBreakdownChart(),
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
