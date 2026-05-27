import 'package:budget_manager/screens/add_expense/views/add_expense.dart';
import 'package:budget_manager/screens/home/views/main_screen.dart';
import 'package:budget_manager/screens/setting/settings.dart';
import 'package:budget_manager/screens/stats/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen
    extends
        StatefulWidget {
  const HomeScreen({
    super.key,
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
          onTap:
              (
                value,
              ) => {
                setState(
                  () {
                    index = value;
                  },
                ),

                print(
                  value,
                ),
              },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(
            0xFF11183D,
          ),
          elevation: 3,

          // for  creating new Icons
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color:
                    index ==
                        0
                    ? SelectedItem
                    : UnselectedItem,
              ),

              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.add_circled,
              ),
              label: 'ADD',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.graph_square,
                color:
                    index ==
                        1
                    ? SelectedItem
                    : UnselectedItem,
              ),
              label: 'stats',
            ),

            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.settings,
                color:
                    index ==
                        2
                    ? SelectedItem
                    : UnselectedItem,
              ),
              label: 'settings',
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
          ? MainScreen()
          : index ==
                1
          ? AddExpense()
          : index ==
                2
          ? StatScreen()
          : Setting(),
    );
  }
}
