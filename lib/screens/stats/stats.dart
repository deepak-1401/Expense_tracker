//import 'dart:math';
import 'package:budget_manager/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_manager/screens/stats/top_5_expense_chart.dart';
import 'package:budget_manager/screens/stats/SpendingTrendChart.dart';
import 'package:budget_manager/screens/stats/Payment_Method_Split_Chart.dart';
import 'package:budget_manager/screens/stats/summary_card.dart';
import 'package:expense_repository/expense_repository.dart';
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
  List<
    Expense
  >
  applyAnalyticsFilter(
    List<
      Expense
    >
    expenses,
  ) {
    final now = DateTime.now();

    return expenses.where(
      (
        expense,
      ) {
        final expenseDate = expense.date;

        if (selectedPeriod ==
            AnalyticsPeriod.today) {
          return expenseDate.year ==
                  now.year &&
              expenseDate.month ==
                  now.month &&
              expenseDate.day ==
                  now.day;
        }
        if (selectedPeriod ==
            AnalyticsPeriod.week) {
          final startOfWeek = now.subtract(
            Duration(
              days:
                  now.weekday -
                  1,
            ),
          );

          final endOfWeek = startOfWeek.add(
            const Duration(
              days: 6,
            ),
          );

          return !expenseDate.isBefore(
                startOfWeek,
              ) &&
              !expenseDate.isAfter(
                endOfWeek,
              );
        }

        if (selectedPeriod ==
            AnalyticsPeriod.month) {
          return expenseDate.year ==
                  now.year &&
              expenseDate.month ==
                  now.month;
        }

        if (selectedPeriod ==
            AnalyticsPeriod.year) {
          return expenseDate.year ==
              now.year;
        }

        return true;
      },
    ).toList();
  }

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
                    final filteredExpenses = applyAnalyticsFilter(
                      state.expenses,
                    );
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
                                            : Colors.white.withValues(
                                                alpha: 0.08,
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
                              expenses: filteredExpenses,
                            ),

                            MySpendingChart(
                              expenses: filteredExpenses,
                            ),
                            Mychart(
                              expenses: filteredExpenses,
                            ),

                            PaymentMethodSplitChart(
                              expenses: filteredExpenses,
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
