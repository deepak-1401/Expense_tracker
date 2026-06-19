import 'package:budget_manager/blocs/currency_bloc/currency_bloc.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/core/utils/helpers/analytics_page/summary_card/summary_period_helper.dart';
import 'package:budget_manager/screens/stats/stats.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_manager/core/utils/helpers/analytics_page/summary_card/summary_calculation_helper.dart';
import 'package:budget_manager/core/utils/helpers/shared/currency_formatter.dart';

class SummaryCardLayout
    extends
        StatelessWidget {
  final List<
    Expense
  >
  expenses;
  final AnalyticsPeriod selectedPeriod;

  const SummaryCardLayout({
    super.key,
    required this.expenses,
    required this.selectedPeriod,
  });

  Widget summaryCard({
    required BuildContext context,

    required IconData icon,
    required String title,
    required String value,
    //required Color color,
    String? subtitle,
  }) {
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(
          6,
        ),
        padding: const EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          color: extraColors.container,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: extraColors.fadeIconColor,
              size: 22,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              title,
              style: TextStyle(
                color: extraColors.fadeText,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              value,
              style: TextStyle(
                color: extraColors.fadeText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle !=
                null) ...[
              const SizedBox(
                height: 4,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: extraColors.fadeText,
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final totalSpent = SummaryCalculationHelper.totalSpent(
      expenses,
    );

    final highestExpense = SummaryCalculationHelper.highestExpense(
      expenses,
    );

    final topCategoryEntry = SummaryCalculationHelper.topCategory(
      expenses,
    );

    final topCategoryName =
        topCategoryEntry?.key ??
        "--";

    final topCategoryAmount =
        topCategoryEntry?.value ??
        0.0;

    final averageAmount =
        totalSpent /
        SummaryCalculationHelper.averageDivider(
          selectedPeriod,
        );

    final averageTitle = SummaryCalculationHelper.averageTitle(
      selectedPeriod,
    );
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SummaryPeriodHelper.getTitle(
                  selectedPeriod,
                ),

                style: TextStyle(
                  color: extraColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                SummaryPeriodHelper.getSubtitle(
                  selectedPeriod,
                ),

                style: TextStyle(
                  color: extraColors.fadeText,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              summaryCard(
                icon: Icons.local_fire_department_outlined,
                title: "Highest",
                value: CurrencyFormatter.format(
                  amount: highestExpense,
                  symbol: currencyState.symbol,
                ),
                context: context,
              ),
              summaryCard(
                icon: Icons.emoji_events_outlined,
                title: "Top Category",
                context: context,
                value: topCategoryName,
                subtitle: CurrencyFormatter.format(
                  amount: topCategoryAmount,
                  symbol: currencyState.symbol,
                ),
              ),
              summaryCard(
                icon: Icons.calendar_today_outlined,
                title: averageTitle,
                context: context,
                value: CurrencyFormatter.format(
                  amount: averageAmount,
                  symbol: currencyState.symbol,
                ),
              ),
            ],
          ),
        ),

        IntrinsicHeight(
          child: Row(
            children: [
              summaryCard(
                icon: Icons.account_balance_wallet_outlined,
                title: "Total Spent",
                context: context,
                value: CurrencyFormatter.format(
                  amount: totalSpent,
                  symbol: currencyState.symbol,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.white24,
          thickness: 1,
          height: 40,
        ),
      ],
    );
  }
}
