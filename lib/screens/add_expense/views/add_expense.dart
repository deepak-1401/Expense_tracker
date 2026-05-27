import 'package:budget_manager/screens/add_expense/views/icon.dart';
import 'package:budget_manager/screens/add_expense/views/newcategory.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense
    extends
        StatefulWidget {
  const AddExpense({
    super.key,
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
  TextEditingController ExpenseController = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  TextEditingController DateController = TextEditingController();

  IconData selectedIcon = AppIcons.transport; // default icon

  @override
  void initState() {
    DateController.text =
        DateFormat(
          'dd-MM-yyyy',
        ).format(
          DateTime.now(),
        );
    super.initState();
  }

  List<
    Category
  >
  categories = [];
  Category? selectedCategory;

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
      backgroundColor: Color(
        0xFF161D47,
      ),
      shape: RoundedRectangleBorder(
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
            return GridView.builder(
              padding: EdgeInsets.all(
                16,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      controller: ExpenseController,
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
                    controller: CategoryController,
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
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(
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
                                    return NewCategory(
                                      onSave:
                                          (
                                            name,
                                            icon,
                                            color,
                                          ) {
                                            categories.add(
                                              Category(
                                                categoryId: const Uuid().v1(),
                                                name: name,
                                                icon: icon.toString(),
                                                color: color.toString(),
                                                todayExpense: 0,
                                              ),
                                            );

                                            setState(
                                              () {},
                                            );

                                            // Navigator.pop(
                                            //   context,
                                            // );
                                          },
                                    );
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
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(
                        22.0,
                      ),
                      hintText: "Description",
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
                              0xFF4D7CFF,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.note_alt_outlined,
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
                    controller: DateController,
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          Duration(
                            days: 365,
                          ),
                        ),
                      );
                      if (newDate !=
                          null) {
                        DateController.text =
                            DateFormat(
                              'dd-MM-yyyy',
                            ).format(
                              newDate,
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
                        //print("Save button pressed");
                      },

                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(
                                0xFF9B4EFF,
                              ),
                              Color(
                                0xFF4D7CFF,
                              ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
