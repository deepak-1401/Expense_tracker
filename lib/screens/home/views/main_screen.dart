import 'package:budget_manager/blocs/currency_bloc/currency_bloc.dart';
import 'package:budget_manager/core/utils/helpers/Home_page/expense_filter_helper.dart';
import 'package:budget_manager/core/utils/helpers/Home_page/greeting_helper.dart';
import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/core/widget/user_name_text.dart';
import 'package:budget_manager/models/expense_filter_model.dart';
import 'package:budget_manager/screens/home/views/expense_filters.dart';
import 'package:budget_manager/core/widget/user_avatar.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_manager/screens/add_expense/views/icon.dart';
import 'package:budget_manager/core/utils/helpers/Home_page/home_date_helper.dart';
import 'package:budget_manager/core/utils/helpers/Home_page/expense_calculation_helper.dart';
import 'package:budget_manager/core/utils/helpers/Home_page/expense_group_helper.dart';
import 'package:budget_manager/core/utils/helpers/shared/currency_formatter.dart';

class MainScreen
    extends
        StatefulWidget {
  final List<
    Expense
  >
  expenses;
  const MainScreen(
    this.expenses, {
    super.key,
  });

  @override
  State<
    MainScreen
  >
  createState() => _MainScreenState();
}

class _MainScreenState
    extends
        State<
          MainScreen
        > {
  ExpenseFilter? activeFilter;

  bool hideAmount = false;

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

    // Filter AND Sorting function
    final filteredExpenses = filterAndSortExpenses(
      widget.expenses,
      activeFilter,
    );

    // Total expense function
    final totalExpense = calculateTotalExpense(
      filteredExpenses,
    );

    // Grouping function
    final groupedExpenses = groupExpensesByDate(
      filteredExpenses,
    );

    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      },
      displacement: 100,
      child: SafeArea(
        //for the upper top left area
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                          UserAvatar(
                            radius: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              color: extraColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          UserNameText(
                            style: TextStyle(
                              color: extraColors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // balance card
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  24.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.tertiary,
                      Theme.of(
                        context,
                      ).colorScheme.secondary,
                      Theme.of(
                        context,
                      ).colorScheme.primary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(
                            alpha: 0.35,
                          ),
                      blurRadius: 24,
                      offset: const Offset(
                        0,
                        12,
                      ),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      bottom: -60,
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(
                            alpha: 0.07,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      right: 50,
                      bottom: -80,
                      child: Container(
                        width: 145,
                        height: 145,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(
                            alpha: 0.045,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      right: -10,
                      bottom: 35,
                      child: Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(
                            alpha: 0.035,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getGreeting(),
                              style: TextStyle(
                                fontSize: 18,
                                color: extraColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              getCurrentDate(),
                              style: TextStyle(
                                fontSize: 14,
                                color: extraColors.fadeText,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            Text(
                              "TOTAL EXPENSES",
                              style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                                color: extraColors.fadeText,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(
                                milliseconds: 250,
                              ),
                              transitionBuilder:
                                  (
                                    child,
                                    animation,
                                  ) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },

                              child: Text(
                                hideAmount
                                    ? CurrencyFormatter.hiddenAmount(
                                        currencyState.symbol,
                                      )
                                    : CurrencyFormatter.format(
                                        amount: totalExpense,
                                        symbol: currencyState.symbol,
                                      ),

                                style: TextStyle(
                                  fontSize: 44,
                                  color: extraColors.textPrimary,
                                  //fontWeight: FontWeight.bold,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CupertinoIcons.calendar,
                                    color: extraColors.iconColor,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    activeFilter?.period ??
                                        "This Month",
                                    style: TextStyle(
                                      color: extraColors.textPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                hideAmount = !hideAmount;
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(
                                alpha: 0.12,
                              ),
                            ),
                            child: Icon(
                              hideAmount
                                  ? CupertinoIcons.eye_slash_fill
                                  : CupertinoIcons.eye_fill,
                              color: extraColors.iconColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 18,
                      color: extraColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result =
                          await showModalBottomSheet<
                            ExpenseFilter
                          >(
                            context: context,
                            builder:
                                (
                                  context,
                                ) => const Filters(),
                          );
                      if (result !=
                          null) {
                        setState(
                          () {
                            activeFilter = result;
                            print(
                              activeFilter?.sortBy,
                            );
                          },
                        );

                        print(
                          activeFilter?.period,
                        );
                        print(
                          activeFilter?.paymentMethods,
                        );
                        print(
                          activeFilter?.sortBy,
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 20,
                          color: extraColors.textPrimary,
                        ),

                        Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 18,
                            color: extraColors.textPrimary,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // list if expenses
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: filteredExpenses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 70,
                              color: extraColors.iconColor,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'No expenses yet!',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: extraColors.fadeText,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Tap the + button to create your first expense.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: extraColors.fadeText,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: groupedExpenses.length,

                        itemBuilder:
                            (
                              context,
                              int i,
                            ) {
                              final dateTitle = groupedExpenses.keys.elementAt(
                                i,
                              );
                              final expensesInGroup = groupedExpenses[dateTitle]!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 4,
                                        ),
                                        child: Text(
                                          dateTitle,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1.2,
                                            color: extraColors.fadeText,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 1,
                                          color: extraColors.fadeText.withValues(
                                            alpha: 0.3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ...expensesInGroup.map(
                                    (
                                      expense,
                                    ) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 18.0,
                                        ),
                                        child: Dismissible(
                                          key: ValueKey(
                                            expense.expenseId,
                                          ),
                                          direction: DismissDirection.endToStart,

                                          confirmDismiss:
                                              (
                                                _,
                                              ) async {
                                                final shouldDelete =
                                                    await showDialog<
                                                      bool
                                                    >(
                                                      context: context,
                                                      builder:
                                                          (
                                                            context,
                                                          ) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                'Delete Expense?',
                                                              ),
                                                              content: const Text(
                                                                'This action cannot be undone.',
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                      context,
                                                                      false,
                                                                    );
                                                                  },
                                                                  child: const Text(
                                                                    'Cancel',
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                      context,
                                                                      true,
                                                                    );
                                                                  },
                                                                  child: const Text(
                                                                    'Delete',
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                    );

                                                if (shouldDelete !=
                                                    true) {
                                                  return false;
                                                }

                                                try {
                                                  await context
                                                      .read<
                                                        ExpenseRepository
                                                      >()
                                                      .deleteExpense(
                                                        expense.expenseId,
                                                      );

                                                  return true;
                                                } catch (
                                                  e
                                                ) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Failed to delete expense',
                                                      ),
                                                    ),
                                                  );

                                                  return false;
                                                }
                                              },

                                          background: Container(
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                              right: 24,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(
                                                20,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),

                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: extraColors.container,
                                              borderRadius: BorderRadius.circular(
                                                20,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                18.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                              color: Color(
                                                                int.parse(
                                                                  'FF${expense.category.color.replaceFirst('#', '')}',
                                                                  radix: 16,
                                                                ),
                                                              ),
                                                              shape: BoxShape.circle,
                                                            ),
                                                          ),

                                                          Icon(
                                                            color: extraColors.iconColor,
                                                            getIconByName(
                                                              expense.category.icon,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        expense.category.name,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: extraColors.textPrimary,

                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        CurrencyFormatter.format(
                                                          amount: expense.amount,
                                                          symbol: currencyState.symbol,
                                                          decimalDigits: 2,
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: extraColors.fadeText,

                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        expense.paymentMethod,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: extraColors.fadeText,

                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
