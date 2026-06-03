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
  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transactions",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
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
      ),
    );
  }
}
