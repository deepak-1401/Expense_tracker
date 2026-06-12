import 'package:budget_manager/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:budget_manager/screens/add_expense/blocs/get_categorybloc/get_category_bloc.dart';
import 'package:budget_manager/screens/add_expense/views/icon.dart';
import 'package:budget_manager/screens/add_expense/views/newcategory.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_manager/screens/add_expense/views/payment.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_manager/screens/add_expense/blocs/create_categoryblocs/create_category_bloc.dart';
import 'package:uuid/uuid.dart';

class AddExpense
    extends
        StatefulWidget {
  final VoidCallback? onExpenseSaved;

  const AddExpense({
    super.key,
    this.onExpenseSaved,
  });

  @override
  State<
    AddExpense
  >
  createState() => _AddExpenseState();
}

class _AddExpenseState
    extends
        State<
          AddExpense
        > {
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();

  IconData selectedIcon = AppIcons.transport; // default icon
  //String paymentMethod = "";
  //String selectedCategory = "";

  late Expense expense;

  @override
  void initState() {
    dateController.text =
        DateFormat(
          'dd-MM-yyyy',
        ).format(
          DateTime.now(),
        );
    expense = Expense.empty;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (
        _,
      ) {
        try {
          context
              .read<
                CreateCategoryBloc
              >()
              .add(
                const LoadCategories(),
              );
        } catch (
          _
        ) {}
      },
    );
  }

  Category? selectedCategory;
  String selectedPaymentMethod = "";

  IconData _iconFromName(
    String? name,
  ) {
    if (name ==
            null ||
        name.isEmpty) {
      return AppIcons.other;
    }
    try {
      final m = icons.firstWhere(
        (
          m,
        ) =>
            m['name'] ==
            name,
        orElse: () => {
          'icon': AppIcons.other,
        },
      );
      return m['icon']
          as IconData;
    } catch (
      _
    ) {
      return AppIcons.other;
    }
  }

  Color _colorFromString(
    String? s,
  ) {
    if (s ==
            null ||
        s.isEmpty) {
      return Colors.grey;
    }
    try {
      final hex = s.replaceFirst(
        '#',
        '',
      );
      final value = int.parse(
        hex,
        radix: 16,
      );
      return Color(
        value,
      );
    } catch (
      _
    ) {
      return Colors.grey;
    }
  }

  void resetForm() {
    setState(
      () {
        expenseController.clear();
        categoryController.clear();
        paymentController.clear();

        selectedCategory = null;
        expense = Expense.empty;
        selectedPaymentMethod = "";

        expense = Expense.empty;

        dateController.text =
            DateFormat(
              'dd-MM-yyyy',
            ).format(
              DateTime.now(),
            );
      },
    );
  }

  void openIconPicker() {
    List<
      IconData
    >
    iconList = [
      AppIcons.food,
      AppIcons.coffee,
      AppIcons.restaurant,
      AppIcons.shopping,
      AppIcons.transport,
      AppIcons.bike,
      AppIcons.flight,
      AppIcons.home,
      AppIcons.rent,
      AppIcons.bills,
      AppIcons.electricity,
      AppIcons.wifi,
      AppIcons.phone,
      AppIcons.education,
      AppIcons.book,
      AppIcons.health,
      AppIcons.hospital,
      AppIcons.medicine,
      AppIcons.movie,
      AppIcons.fitness,
      AppIcons.income,
      AppIcons.investment,
      AppIcons.other,
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(
        0xFF161D47,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            20,
          ),
        ),
      ),
      builder:
          (
            context,
          ) {
            return BlocBuilder<
              GetCategoryBloc,
              GetCategoryState
            >(
              builder:
                  (
                    context,
                    state,
                  ) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(
                        16,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: iconList.length,
                      itemBuilder:
                          (
                            context,
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selectedIcon = iconList[index];
                                  },
                                );
                                Navigator.pop(
                                  context,
                                );
                              },
                              child: Icon(
                                iconList[index],
                                color: Colors.white,
                                size: 28,
                              ),
                            );
                          },
                    );
                  },
            );
          },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(
          context,
        ).unfocus(),
        child:
            BlocListener<
              CreateExpenseBloc,
              CreateExpenseState
            >(
              listener:
                  (
                    context,
                    state,
                  ) {
                    print(
                      "CREATE EXPENSE STATE: ${state.runtimeType}",
                    );

                    if (state
                        is CreateExpenseSuccess) {
                      resetForm();
                      widget.onExpenseSaved?.call();
                    }
                  },
              child: Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Add Expense",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(
                              0xFF8B4CFF,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width:
                              MediaQuery.of(
                                context,
                              ).size.width *
                              0.8,
                          height:
                              MediaQuery.of(
                                context,
                              ).size.height *
                              0.1,
                          child: TextFormField(
                            controller: expenseController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(
                                22.0,
                              ),
                              filled: true,
                              fillColor: Color(
                                0xFF161D47,
                              ),
                              hintText: "00.00",
                              hintStyle: TextStyle(
                                color: Color(
                                  0xFFA26DFF,
                                ),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              prefixIcon: Icon(
                                Icons.currency_rupee,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        TextFormField(
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.center,
                          controller: categoryController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(
                              22.0,
                            ),
                            hintText: "Category",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            filled: true,
                            fillColor: Color(
                              0xFF161D47,
                            ),
                            prefixIcon:
                                selectedCategory ==
                                    null
                                ? Padding(
                                    padding: const EdgeInsets.all(
                                      8.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF9B4EFF,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.list_alt_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(
                                      7.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _colorFromString(
                                          selectedCategory!.color,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _iconFromName(
                                          selectedCategory!.icon,
                                        ),
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(
                                8.0,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder:
                                        (
                                          context,
                                        ) {
                                          return const NewCategory();
                                        },
                                  );
                                },

                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),

                        BlocBuilder<
                          CreateCategoryBloc,
                          CreateCategoryState
                        >(
                          builder:
                              (
                                context,
                                state,
                              ) {
                                List<
                                  Category
                                >
                                items = [];

                                if (state
                                    is CreateCategoryLoadSuccess) {
                                  items = state.categories;
                                }

                                // if (state
                                //     is CreateCategoryLoading) {
                                //   return const Center(
                                //     child: CircularProgressIndicator(),
                                //   );
                                // }

                                if (state
                                    is CreateCategoryFailure) {
                                  return const Center(
                                    child: Text(
                                      'Failed to load categories',
                                    ),
                                  );
                                }

                                if (items.isEmpty) {
                                  return const SizedBox.shrink();
                                }

                                return Container(
                                  height: 200,
                                  padding: const EdgeInsets.all(
                                    22.0,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(
                                      0xFF161D47,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      8.0,
                                    ),
                                    child: ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder:
                                          (
                                            context,
                                            i,
                                          ) {
                                            final c = items[i];
                                            final iconData = _iconFromName(
                                              c.icon,
                                            );
                                            final bgColor = _colorFromString(
                                              c.color,
                                            );
                                            return Card(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      expense.category = c;
                                                      categoryController.text = c.name;
                                                      selectedCategory = c;
                                                    },
                                                  );
                                                },
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor: bgColor,
                                                    child: Icon(
                                                      iconData,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  title: Text(
                                                    c.name,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                );
                              },
                        ),

                        const SizedBox(
                          height: 22,
                        ),
                        TextFormField(
                          controller: dateController,
                          textAlignVertical: TextAlignVertical.center,
                          readOnly: true,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: expense.date,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                Duration(
                                  days: 365,
                                ),
                              ),
                            );
                            if (newDate !=
                                null) {
                              setState(
                                () {
                                  dateController.text =
                                      DateFormat(
                                        'dd-MM-yyyy',
                                      ).format(
                                        newDate,
                                      );
                                  expense.date = newDate;
                                },
                              );
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(
                              22.0,
                            ),
                            hintText: "Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            filled: true,
                            fillColor: Color(
                              0xFF161D47,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(
                                8.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(
                                    0xFF20D3A7,
                                  ),
                                  shape: BoxShape.circle,
                                ),

                                child: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        TextFormField(
                          controller: paymentController,
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(
                              22.0,
                            ),
                            hintText: "Payment Method",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            filled: true,
                            fillColor: Color(
                              0xFF161D47,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(
                                8.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(
                                    0xFFFF9A3D,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.payment,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  final result = await showDialog(
                                    context: context,
                                    builder:
                                        (
                                          context,
                                        ) {
                                          return const Payment();
                                        },
                                  );

                                  print(
                                    "PAYMENT DIALOG RESULT = $result",
                                  );

                                  if (result !=
                                      null) {
                                    setState(
                                      () {
                                        selectedPaymentMethod = result;
                                        paymentController.text = selectedPaymentMethod;

                                        expense.paymentMethod = selectedPaymentMethod;
                                      },
                                    );

                                    print(
                                      "SELECTED PAYMENT = $selectedPaymentMethod",
                                    );
                                    print(
                                      "PAYMENT CONTROLLER = ${paymentController.text}",
                                    );
                                    print(
                                      "EXPENSE PAYMENT = ${expense.paymentMethod}",
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.expand_more,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),

                        SizedBox(
                          width:
                              MediaQuery.of(
                                context,
                              ).size.width *
                              0.75,
                          height:
                              MediaQuery.of(
                                context,
                              ).size.height *
                              0.075,

                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Color(
                                        0xFF8B5CF6,
                                      ).withValues(
                                        alpha: 0.35,
                                      ),
                                  blurRadius: 15,
                                  offset: Offset(
                                    0,
                                    6,
                                  ),
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    40,
                                  ),
                                ),
                              ),

                              onPressed: () {
                                setState(
                                  () {
                                    expense.expenseId = const Uuid().v1();

                                    expense.amount =
                                        double.tryParse(
                                          expenseController.text,
                                        ) ??
                                        0.00;
                                  },
                                );

                                print(
                                  "SAVE BUTTON CLICKED",
                                );
                                // print(
                                //   "Amount: ${amountController.text}",
                                // );
                                print(
                                  "Category: ${expense.category.name}",
                                );
                                print(
                                  "Payment: ${expense.paymentMethod}",
                                );
                                print(
                                  "Date: ${expense.date}",
                                );

                                context
                                    .read<
                                      CreateExpenseBloc
                                    >()
                                    .add(
                                      CreateExpense(
                                        Expense(
                                          expenseId: const Uuid().v1(),
                                          category: expense.category,
                                          amount:
                                              double.tryParse(
                                                expenseController.text,
                                              ) ??
                                              0.00,
                                          date: expense.date,
                                          paymentMethod: expense.paymentMethod,
                                        ),
                                      ),
                                    );
                              },

                              child: Ink(
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
                                    40,
                                  ),
                                ),

                                child: Container(
                                  alignment: Alignment.center,

                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
