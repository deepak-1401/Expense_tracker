import 'package:budget_manager/screens/stats/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatScreen
    extends
        StatelessWidget {
  const StatScreen({
    super.key,
  });

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
                child: Mychart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
