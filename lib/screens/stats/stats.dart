import 'package:budget_manager/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:budget_manager/screens/stats/chart.dart';
//import 'package:flutter/cupertino.dart';
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
  Widget summaryCard({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(
          6,
        ),
        padding: const EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          color: const Color(
            0xFF10173A,
          ),
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white70,
              size: 22,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
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
                style: const TextStyle(
                  color: Colors.white54,
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
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              "Analytics",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Divider(
            //   color: Colors.white24,
            //   thickness: 1,
            //   height: 40,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),

              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Monthly Summary",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "June 2026",
                          style: TextStyle(
                            color: Colors.white54,
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
                          value: "₹4,200",
                        ),
                        summaryCard(
                          icon: Icons.emoji_events_outlined,
                          title: "Top Category",
                          value: "Food",
                          subtitle: "₹8,700",
                        ),
                        summaryCard(
                          icon: Icons.calendar_today_outlined,
                          title: "Avg / Day",
                          value: "₹825",
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
                          value: "₹24,850",
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white24,
                    thickness: 1,
                    height: 40,
                  ),
                  // const SizedBox(
                  //   height: 28,
                  // ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Top 5 Expenses",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(
                          context,
                        ).size.width,
                        height: MediaQuery.of(
                          context,
                        ).size.width,
                        decoration: BoxDecoration(
                          color: Color(
                            0xff10173A,
                          ),

                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(
                            16.0,
                          ),
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
                                        return Mychart(
                                          expenses: state.expenses,
                                        );
                                      }
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
