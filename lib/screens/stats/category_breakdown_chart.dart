import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryBreakdownData {
  final String category;
  final double amount;
  final Color color;

  CategoryBreakdownData({
    required this.category,
    required this.amount,
    required this.color,
  });
}

class CategoryBreakdownChart
    extends
        StatelessWidget {
  CategoryBreakdownChart({
    super.key,
  });

  final List<
    CategoryBreakdownData
  >
  chartData = [
    CategoryBreakdownData(
      category: "Food",
      amount: 100,
      color: Colors.deepPurple,
    ),
    CategoryBreakdownData(
      category: "Travel",
      amount: 200,
      color: Colors.purpleAccent,
    ),
    CategoryBreakdownData(
      category: "Bills",
      amount: 300,
      color: Colors.pinkAccent,
    ),
    CategoryBreakdownData(
      category: "Entertainment",
      amount: 150,
      color: Colors.orangeAccent,
    ),
    CategoryBreakdownData(
      category: "others",
      amount: 200,
      color: Colors.blueAccent,
    ),
  ];

  Widget legendItem({
    required Color color,
    required String category,
    required String percentage,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child: Text(
              category,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Text(
            percentage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final double totalAmount = chartData.fold(
      0,
      (
        sum,
        item,
      ) =>
          sum +
          item.amount,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category Breakdown",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),

        Container(
          height: 280,
          width: double.infinity,
          padding: const EdgeInsets.all(
            16,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xff10173A,
            ),
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.06,
              ),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: SfCircularChart(
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    color: const Color(
                      0xFF1B2145,
                    ),
                    borderWidth: 3,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  series:
                      <
                        CircularSeries<
                          CategoryBreakdownData,
                          String
                        >
                      >[
                        DoughnutSeries<
                          CategoryBreakdownData,
                          String
                        >(
                          dataSource: chartData,
                          xValueMapper:
                              (
                                CategoryBreakdownData data,
                                _,
                              ) => data.category,
                          yValueMapper:
                              (
                                CategoryBreakdownData data,
                                _,
                              ) => data.amount,
                          pointColorMapper:
                              (
                                CategoryBreakdownData data,
                                _,
                              ) => data.color,

                          radius: '85%',
                          innerRadius: '50%',

                          // dataLabelSettings: const DataLabelSettings(
                          //   isVisible: true,
                          //   textStyle: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ),
                      ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),

              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...chartData.map(
                      (
                        data,
                      ) {
                        return legendItem(
                          color: data.color,
                          category: data.category,
                          percentage: "${((data.amount / totalAmount) * 100).toStringAsFixed(0)}%",
                        );
                      },
                    ).toList(),
                    // legendItem(
                    //   color: chartData[1].color,
                    //   category: chartData[1].category,
                    //   percentage: "24%",
                    // ),
                    // legendItem(
                    //   color: chartData[2].color,
                    //   category: chartData[2].category,
                    //   percentage: "18%",
                    // ),
                    // legendItem(
                    //   color: chartData[3].color,
                    //   category: chartData[3].category,
                    //   percentage: "14%",
                    // ),
                    // legendItem(
                    //   color: chartData[4].color,
                    //   category: chartData[4].category,
                    //   percentage: "12%",
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
