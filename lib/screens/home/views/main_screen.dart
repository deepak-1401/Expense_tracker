import 'package:budget_manager/core/widget/user_name_text.dart';
import 'package:budget_manager/models/expense_filter_model.dart';
import 'package:budget_manager/screens/home/views/expense_filters.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:budget_manager/screens/add_expense/views/icon.dart';

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

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >=
            5 &&
        hour <
            12) {
      return 'Good Morning ☀️';
    } else if (hour >=
            12 &&
        hour <
            17) {
      return 'Good Afternoon 🌤️';
    } else if (hour >=
            17 &&
        hour <
            21) {
      return 'Good Evening 🌆';
    } else {
      return 'Good Night 🌙';
    }
  }

  String getCurrentDate() {
    return DateFormat(
      'EEEE, d MMMM',
    ).format(
      DateTime.now(),
    );
  }

  String formatCurrency(
    double amount,
  ) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹ ',
      decimalDigits: 0,
    ).format(
      amount,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final expenses = widget.expenses;
    List<
      Expense
    >
    filteredExpenses = List.from(
      expenses,
    );

    // Filter by payment method
    if (activeFilter !=
            null &&
        activeFilter!.paymentMethods.isNotEmpty) {
      filteredExpenses = filteredExpenses.where(
        (
          expense,
        ) {
          return activeFilter!.paymentMethods.contains(
            expense.paymentMethod,
          );
        },
      ).toList();
    }

    // Filter by period
    if (activeFilter !=
            null &&
        activeFilter!.period !=
            null) {
      final now = DateTime.now();

      filteredExpenses = filteredExpenses.where(
        (
          expense,
        ) {
          final expenseDate = expense.date;

          if (activeFilter!.period ==
              'Today') {
            return expenseDate.year ==
                    now.year &&
                expenseDate.month ==
                    now.month &&
                expenseDate.day ==
                    now.day;
          }

          if (activeFilter!.period ==
              'This Week') {
            final startOfWeek =
                DateTime(
                  now.year,
                  now.month,
                  now.day,
                ).subtract(
                  Duration(
                    days:
                        now.weekday -
                        1,
                  ),
                );

            final endOfWeek = startOfWeek.add(
              const Duration(
                days: 7,
              ),
            );

            return !expenseDate.isBefore(
                  startOfWeek,
                ) &&
                expenseDate.isBefore(
                  endOfWeek,
                );
          }

          if (activeFilter!.period ==
              'This Month') {
            return expenseDate.year ==
                    now.year &&
                expenseDate.month ==
                    now.month;
          }

          if (activeFilter!.period ==
              'This Year') {
            return expenseDate.year ==
                now.year;
          }

          return true;
        },
      ).toList();
    }

    // Sorting
    if (activeFilter !=
            null &&
        activeFilter!.sortBy !=
            null) {
      if (activeFilter!.sortBy ==
          'Amount Low → High') {
        filteredExpenses.sort(
          (
            a,
            b,
          ) => a.amount.compareTo(
            b.amount,
          ),
        );
      }

      if (activeFilter!.sortBy ==
          'Amount High → Low') {
        filteredExpenses.sort(
          (
            a,
            b,
          ) => b.amount.compareTo(
            a.amount,
          ),
        );
      }
    }
    if (activeFilter?.sortBy ==
        'Newest First') {
      filteredExpenses.sort(
        (
          a,
          b,
        ) => b.date.compareTo(
          a.date,
        ),
      );
    }
    if (activeFilter?.sortBy ==
        'Oldest First') {
      filteredExpenses.sort(
        (
          a,
          b,
        ) => a.date.compareTo(
          b.date,
        ),
      );
    }
    if (activeFilter?.sortBy ==
        null) {
      filteredExpenses.sort(
        (
          a,
          b,
        ) => b.date.compareTo(
          a.date,
        ),
      );
    }
    // Total expense logic

    double totalExpense = 0;

    for (var expense in filteredExpenses) {
      totalExpense += expense.amount;
    }

    final Map<
      String,
      List<
        Expense
      >
    >
    groupedExpenses = {};

    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final yesterday = today.subtract(
      const Duration(
        days: 1,
      ),
    );

    for (var expense in filteredExpenses) {
      final expenseDay = DateTime(
        expense.date.year,
        expense.date.month,
        expense.date.day,
      );

      String dateTitle;

      if (expenseDay ==
          today) {
        dateTitle = 'TODAY';
      } else if (expenseDay ==
          yesterday) {
        dateTitle = 'YESTERDAY';
      } else {
        dateTitle =
            DateFormat(
                  'd MMMM',
                )
                .format(
                  expense.date,
                )
                .toUpperCase();
      }

      groupedExpenses.putIfAbsent(
        dateTitle,
        () => [],
      );

      groupedExpenses[dateTitle]!.add(
        expense,
      );
    }

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
                              color: Colors.yellow,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.person_fill,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),

                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          UserNameText(
                            style: const TextStyle(
                              color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
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
                                color: Colors.white.withValues(
                                  alpha: 0.7,
                                ),
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
                                color: Colors.white.withValues(
                                  alpha: 0.65,
                                ),
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
                                    ? '₹ ••••••'
                                    : formatCurrency(
                                        totalExpense,
                                      ),

                                style: const TextStyle(
                                  fontSize: 44,
                                  color: Colors.white,
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
                                  const Icon(
                                    CupertinoIcons.calendar,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    activeFilter?.period ??
                                        "This Month",
                                    style: const TextStyle(
                                      color: Colors.white,
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
                              color: Colors.white,
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
                  const Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
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
                          color: Color(
                            0xFF8B4CFF,
                          ),
                        ),

                        const Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(
                              0xFF8B4CFF,
                            ),
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
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 70,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'No expenses yet!',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Tap the + button to create your first expense.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
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
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.outline,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 1,
                                          color:
                                              Theme.of(
                                                context,
                                              ).dividerColor.withValues(
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
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(
                                              0xFF11183D,
                                            ),
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
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "₹ ${expense.amount.toStringAsFixed(2)}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color(
                                                          0xFFB8BFD6,
                                                        ),
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      expense.paymentMethod,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color(
                                                          0xFF7F89AE,
                                                        ),
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
