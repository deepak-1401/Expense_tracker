//import 'dart:math';
import 'package:budget_manager/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/screens/stats/top_5_expense_chart.dart';
import 'package:budget_manager/screens/stats/spending_trend_chart.dart';
import 'package:budget_manager/screens/stats/payment_method_split_chart.dart';
import 'package:budget_manager/screens/stats/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_manager/core/utils/helpers/analytics_page/analytics_filter_helper.dart';

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
  AppExtraColors get extraColors =>
      Theme.of(
            context,
          )
          .extension<
            AppExtraColors
          >()!;
  AnalyticsPeriod selectedPeriod = AnalyticsPeriod.month;

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
                      selectedPeriod,
                    );
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22.0,
                          vertical: 22.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Analytics",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: extraColors.fadeText.withValues(
                                alpha: 0.2,
                              ),
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
                                            : extraColors.container.withValues(
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
                                              ? extraColors.textPrimary
                                              : extraColors.fadeText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            Divider(
                              color: extraColors.fadeText.withValues(
                                alpha: 0.2,
                              ),
                              thickness: 1,
                              height: 40,
                            ),
                            SummaryCardLayout(
                              expenses: filteredExpenses,
                              selectedPeriod: selectedPeriod,
                            ),

                            MySpendingChart(
                              expenses: filteredExpenses,
                              selectedPeriod: selectedPeriod,
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
