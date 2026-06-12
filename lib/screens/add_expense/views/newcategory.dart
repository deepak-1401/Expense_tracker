import 'package:budget_manager/screens/add_expense/blocs/create_categoryblocs/create_category_bloc.dart';
import 'package:budget_manager/screens/add_expense/views/icon.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class NewCategory
    extends
        StatefulWidget {
  const NewCategory({
    super.key,
  });

  @override
  State<
    NewCategory
  >
  createState() => _NewCategoryState();
}

class _NewCategoryState
    extends
        State<
          NewCategory
        > {
  final TextEditingController nameController = TextEditingController();
  //final CategoryIconController = TextEditingController();
  //final CategoryColorController = TextEditingController();
  //TextEditingController CategorynameController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  IconData? selectedIcon;
  Color? selectedColor;
  String? selectedIconName;

  void openIconPicker() {
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
            return GridView.builder(
              padding: const EdgeInsets.all(
                16,
              ),
              itemCount: icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder:
                  (
                    context,
                    index,
                  ) {
                    final item = icons[index];
                    final icon = item['icon'];

                    return GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            selectedIcon = icon;

                            selectedIconName = item['name'];
                          },
                        );
                        Navigator.pop(
                          context,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              selectedIcon ==
                                  icon
                              ? const Color(
                                  0xFF8B4CFF,
                                )
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          border: Border.all(
                            color: Colors.white24,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
            );
          },
    );
  }

  void openColorPicker() {
    // simple static colors (you can upgrade later)
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];

    showModalBottomSheet(
      context: context,
      builder:
          (
            context,
          ) {
            return Container(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Wrap(
                spacing: 10,
                children: colors.map(
                  (
                    color,
                  ) {
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            selectedColor = color;
                          },
                        );
                        Navigator.pop(
                          context,
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: color,
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      backgroundColor: const Color(
        0xFF161D47,
      ),

      title: const Text(
        "Create Category",
        style: TextStyle(
          color: Color(
            0xFF8B4CFF,
          ),
          fontWeight: FontWeight.w600,
        ),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // NAME
          TextFormField(
            controller: nameController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: "name",
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
              filled: true,
              fillColor: const Color(
                0xFF0F1330,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          // ICON
          TextFormField(
            controller: iconController,
            readOnly: true,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: "icon",
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
              filled: true,
              fillColor: const Color(
                0xFF0F1330,
              ),
              prefixIcon: Icon(
                selectedIcon ??
                    Icons.category,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                onPressed: openIconPicker,
                icon: const Icon(
                  Icons.expand_more,
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          // COLOR
          TextFormField(
            controller: colorController,
            readOnly: true,
            onTap: openColorPicker,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: "color",
              hintStyle: const TextStyle(
                color: Colors.white54,
              ),
              filled: true,
              fillColor: const Color(
                0xFF0F1330,
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(
                  10,
                ),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color:
                      selectedColor ??
                      Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // SAVE BUTTON
          SizedBox(
            width: double.infinity,
            child: Container(
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
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(
                  60,
                ),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),

                onPressed: () {
                  final category = Category(
                    categoryId: const Uuid().v1(),

                    name: nameController.text,

                    icon:
                        selectedIconName ??
                        '',

                    color:
                        selectedColor ==
                            null
                        ? ''
                        : '#${selectedColor!.toARGB32().toRadixString(16)}',

                    todayExpense: 0,
                  );

                  context
                      .read<
                        CreateCategoryBloc
                      >()
                      .add(
                        CreateCategory(
                          category: category,
                        ),
                      );

                  Navigator.pop(
                    context,
                  );
                },

                child: const Text(
                  "Save Category",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
