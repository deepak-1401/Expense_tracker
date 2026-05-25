import 'package:budget_manager/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //for the upper top left area
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                        Icon(CupertinoIcons.person_fill),
                      ],
                    ),
                    const SizedBox(width: 8),

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
                        Text(
                          "Deepak",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF11183D),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.settings),
                  ),
                ),
              ],
            ),
            // balance card
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],

                  transform: const GradientRotation(pi / 4),
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "\₹ 1,00,000",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Income row
                        Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 12,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Income",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "\₹ 50,000",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // expense row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20.0,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_up,
                                    size: 12,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expense",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "\₹ 10,000",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
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
                ],
              ),
            ),

            const SizedBox(height: 20),
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
                  onTap: () {},
                  child: const Text(
                    "views all",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8B4CFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            // list if expenses
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactionData.length,

                itemBuilder: (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF11183D),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
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
                                        color: transactionData[i]['color'],
                                        shape: BoxShape.circle,
                                      ),
                                    ),

                                    FaIcon(transactionData[i]['icon']),
                                    //   const Icon(
                                    //     Icons.fastfood,
                                    //     color: Colors.black,
                                    //   ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  transactionData[i]['name'],
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
                                  transactionData[i]['todayExpense'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFB8BFD6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  transactionData[i]['date'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF7F89AE),
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
            ),
          ],
        ),
      ),
    );
  }
}
