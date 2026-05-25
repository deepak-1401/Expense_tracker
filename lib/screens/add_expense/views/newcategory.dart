import 'package:budget_manager/screens/add_expense/views/icon.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatefulWidget {
  final Function(String name, IconData icon, Color color) onSave;

  const NewCategory({super.key, required this.onSave});

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final TextEditingController nameController = TextEditingController();

  IconData selectedIcon = Icons.category;
  Color selectedColor = Colors.blue;

  // 👉 YOUR ICON LIST (replace with your AppIcons if you have one)
  final List<IconData> icons = [
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
    AppIcons.games,
    AppIcons.music,
    AppIcons.fitness,
    AppIcons.gym,
    AppIcons.work,
    AppIcons.business,
    AppIcons.salary,
    AppIcons.income,
    AppIcons.investment,
    AppIcons.stocks,
    AppIcons.gift,
    AppIcons.other,
  ];

  void openIconPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161D47),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: icons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final icon = icons[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIcon = icon;
                });
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIcon == icon
                      ? const Color(0xFF8B4CFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: Icon(icon, color: Colors.white),
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
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 10,
            children: colors.map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                  Navigator.pop(context);
                },
                child: CircleAvatar(backgroundColor: color),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF161D47),
      title: const Text(
        "Create Category",
        style: TextStyle(color: Color(0xFF8B4CFF), fontWeight: FontWeight.w600),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // NAME
          TextFormField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "name",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF0F1330),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ICON
          TextFormField(
            readOnly: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "icon",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF0F1330),
              prefixIcon: Icon(selectedIcon, color: Colors.white),
              suffixIcon: IconButton(
                onPressed: openIconPicker,
                icon: const Icon(Icons.expand_more, color: Colors.white),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // COLOR
          TextFormField(
            readOnly: true,
            onTap: openColorPicker,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "color",
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF0F1330),
              prefixIcon: Container(
                margin: const EdgeInsets.all(10),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: selectedColor,
                  shape: BoxShape.circle,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // SAVE BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B4CFF),
              ),
              onPressed: () {
                widget.onSave(nameController.text, selectedIcon, selectedColor);

                Navigator.pop(context);
              },
              child: const Text("Save Category"),
            ),
          ),
        ],
      ),
    );
  }
}
