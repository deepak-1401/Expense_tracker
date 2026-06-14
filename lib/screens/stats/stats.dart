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
