import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/models/expense_filter_model.dart';
import 'package:flutter/material.dart';

class Filters
    extends
        StatefulWidget {
  const Filters({
    super.key,
  });

  @override
  State<
    Filters
  >
  createState() => _FiltersState();
}

String
selectedPeriod = "";
String
selectedSort = "";
final List<
  String
>
selectedPayments = [];

class _FiltersState
    extends
        State<
          Filters
        > {
  void togglePayment(
    String payment,
  ) {
    setState(
      () {
        if (selectedPayments.contains(
          payment,
        )) {
          selectedPayments.remove(
            payment,
          ); // unselect
        } else {
          selectedPayments.add(
            payment,
          ); // select
        }
      },
    );
  }

  void clearAllFilters() {
    setState(
      () {
        selectedPeriod = "";
        selectedPayments.clear();
        selectedSort = "";
      },
    );
  }

  void applyFilters() {
    final filter = ExpenseFilter(
      period: selectedPeriod,
      paymentMethods: selectedPayments,
      sortBy: selectedSort,
    );

    Navigator.pop(
      context,
      filter,
    );
  }

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

    return SingleChildScrollView(
      child: BottomSheet(
        // backgroundColor: Color(
        //   0xFF161D47,
        // ),
        onClosing: () {},
        builder:
            (
              context,
            ) {
              return Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 1000,
                  child: Wrap(
                    children: [
                      Center(
                        child: Text(
                          'Filters',
                          style: TextStyle(
                            color: extraColors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(
                        height: 30,
                        indent: 50,
                        endIndent: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Period",
                        style: TextStyle(
                          color: extraColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      Wrap(
                        spacing: 12,
                        children: [
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Today",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedPeriod ==
                                "Today",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedPeriod ==
                                          "Today") {
                                        selectedPeriod = ""; // Unselect
                                      } else {
                                        selectedPeriod = "Today"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "This Week",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedPeriod ==
                                "This Week",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedPeriod ==
                                          "This Week") {
                                        selectedPeriod = ""; // Unselect
                                      } else {
                                        selectedPeriod = "This Week"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "This Month",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedPeriod ==
                                "This Month",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedPeriod ==
                                          "This Month") {
                                        selectedPeriod = ""; // Unselect
                                      } else {
                                        selectedPeriod = "This Month"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "This Year",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedPeriod ==
                                "This Year",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedPeriod ==
                                          "This Year") {
                                        selectedPeriod = ""; // Unselect
                                      } else {
                                        selectedPeriod = "This Year"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "payment Method",
                        style: TextStyle(
                          color: extraColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Wrap(
                        spacing: 12,
                        runSpacing: 20,
                        children: [
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Cash",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected: selectedPayments.contains(
                              "Cash",
                            ),
                            onSelected:
                                (
                                  value,
                                ) {
                                  togglePayment(
                                    "Cash",
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Credit Card",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected: selectedPayments.contains(
                              "Credit Card",
                            ),
                            onSelected:
                                (
                                  value,
                                ) {
                                  togglePayment(
                                    "Credit Card",
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "UPI",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected: selectedPayments.contains(
                              "UPI",
                            ),
                            onSelected:
                                (
                                  value,
                                ) {
                                  togglePayment(
                                    "UPI",
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Other",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected: selectedPayments.contains(
                              "Other",
                            ),
                            onSelected:
                                (
                                  value,
                                ) {
                                  togglePayment(
                                    "Other",
                                  );
                                },
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Sort-By",
                        style: TextStyle(
                          color: extraColors.textPrimary,

                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Wrap(
                        spacing: 12,
                        runSpacing: 20,
                        children: [
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Newest First",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedSort ==
                                "Newest First",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedSort ==
                                          "Newest First") {
                                        selectedSort = ""; // Unselect
                                      } else {
                                        selectedSort = "Newest First"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Oldest First",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedSort ==
                                "Oldest First",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedSort ==
                                          "Oldest First") {
                                        selectedSort = ""; // Unselect
                                      } else {
                                        selectedSort = "Oldest First"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Amount High → Low",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedSort ==
                                "Amount High → Low",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedSort ==
                                          "Amount High → Low") {
                                        selectedSort = ""; // Unselect
                                      } else {
                                        selectedSort = "Amount High → Low"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                          FilterChip(
                            backgroundColor: extraColors.filledColor,
                            label: Text(
                              "Amount Low → High",
                              style: TextStyle(
                                color: extraColors.textPrimary,
                              ),
                            ),
                            selected:
                                selectedSort ==
                                "Amount Low → High",
                            onSelected:
                                (
                                  value,
                                ) {
                                  setState(
                                    () {
                                      if (selectedSort ==
                                          "Amount Low → High") {
                                        selectedSort = ""; // Unselect
                                      } else {
                                        selectedSort = "Amount Low → High"; // Select
                                      }
                                    },
                                  );
                                },
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              clearAllFilters();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              width: 100,
                              decoration: BoxDecoration(
                                color: extraColors.filledColor,
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: Text(
                                "Clear All",
                                style: TextStyle(
                                  color: extraColors.textPrimary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Apply filters and close the bottom sheet
                              applyFilters();
                              // Navigator.of(
                              //   context,
                              // ).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              width: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
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
                                  10,
                                ),
                              ),
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                  color: extraColors.textPrimary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }
}
