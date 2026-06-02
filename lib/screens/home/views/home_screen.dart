import 'package:budget_manager/blocs/create_expensebloc/create_expense_bloc.dart';
import 'package:budget_manager/screens/add_expense/views/add_expense.dart';
import 'package:budget_manager/screens/home/views/main_screen.dart';
import 'package:budget_manager/screens/setting/settings.dart';
import 'package:budget_manager/screens/stats/stats.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:budget_manager/packages/expense_repository/lib/src/firebase_expense_repo.dart';

class HomeScreen
    extends
        StatefulWidget {
  const HomeScreen({
    super.key,
    int index = 0,
  });
  @override
  State<
    HomeScreen
  >
  createState() => _HomeScreenState();
}

class _HomeScreenState
    extends
        State<
          HomeScreen
        > {
  // var WidgetList = [MainScreen(), StatScreen(), Setting()];
  int index = 0;
  Color SelectedItem = Colors.white;
  Color UnselectedItem = Colors.grey;

  Widget? get bottomNavigationBar => null;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(
            30,
          ),
        ),
        // curve in the icon
        child: BottomNavigationBar(
          currentIndex: index,

          onTap:
              (
                value,
              ) {
                print(
                  "BOTTOM NAV CLICKED: $value",
                );

                setState(
                  () {
                    index = value;
                  },
                );
              },

          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,

          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.add_circled,
              ),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.graph_square,
              ),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.settings,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
      // for add expese button
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   shape: const CircleBorder(),
      //   child: Container(
      //     width: 60,
      //     height: 60,
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       gradient: LinearGradient(
      //         colors: [
      //           Theme.of(context).colorScheme.primary,
      //           Theme.of(context).colorScheme.secondary,
      //           Theme.of(context).colorScheme.tertiary,
      //         ],

      //         transform: const GradientRotation(pi / 4),
      //       ),
      //     ),
      //     child: const Icon(CupertinoIcons.add),
      //   ),
      // ),
      body:
          index ==
              0
          ? const MainScreen()
          : index ==
                1
          ? BlocProvider(
              create:
                  (
                    context,
                  ) => CreateExpenseBloc(
                    FirebaseExpenseRepo(),
                  ),
              child: AddExpense(
                onExpenseSaved: () {
                  setState(
                    () {
                      index = 0;
                    },
                  );
                },
              ),
            )
          : index ==
                2
          ? const StatScreen()
          : const Setting(),
    );
  }
}
