import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/category.dart';
import 'package:money_tracker/providers/categories_provider.dart';
import 'package:money_tracker/providers/current_user.dart';

const availableIcons = [
  Icons.shopping_cart,
  Icons.restaurant,
  Icons.directions_car,
  Icons.home,
  Icons.school,
  Icons.sports_soccer,
  Icons.local_hospital,
  Icons.flight,
];

const availableColors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.pink,
  Colors.teal,
  Colors.brown,
];

Future<Map<String, dynamic>?> showAddCategorySheet(
  BuildContext context,
  WidgetRef ref,
) {
  final currentUser = ref.read(currentUserProvider);

  final titleController = TextEditingController();
  Color? selectedColor;
  IconData? selectedIcon;
  CategoryType selectedType = CategoryType.expense;

  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),

                    // ---------------- TITLE FIELD ----------------
                    const Text(
                      "Category Title",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Enter category name",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField<CategoryType>(
                      initialValue: selectedType,
                      items: const [
                        DropdownMenuItem(
                          value: CategoryType.income,
                          child: Text("Income"),
                        ),
                        DropdownMenuItem(
                          value: CategoryType.expense,
                          child: Text("Expense"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // ---------------- ICON PICKER ----------------
                    const Text(
                      "Choose Icon",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: availableIcons.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemBuilder: (context, index) {
                        final icon = availableIcons[index];
                        final isSelected = icon == selectedIcon;

                        return InkWell(
                          onTap: () {
                            setState(() => selectedIcon = icon);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade200,
                            ),
                            child: Icon(
                              icon,
                              size: 26,
                              color: isSelected ? Colors.white : Colors.black87,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // ---------------- COLOR PICKER ----------------
                    const Text(
                      "Choose Color",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: availableColors.map((color) {
                        final isSelected = color == selectedColor;
                        return InkWell(
                          onTap: () {
                            setState(() => selectedColor = color);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                              border: isSelected
                                  ? Border.all(color: Colors.black, width: 3)
                                  : null,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // ---------------- SAVE BUTTON ----------------
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isEmpty ||
                              selectedIcon == null ||
                              selectedColor == null) {
                            Navigator.pop(context, null);
                            return;
                          }

                          final newCategory = Category(
                            userId: currentUser!.id,
                            title: titleController.text.trim(),
                            type: selectedType,
                            icon: Icon(selectedIcon),
                            color: selectedColor!,
                          );

                          ref
                              .read(categoriesProvider.notifier)
                              .addCategory(newCategory);

                          Navigator.pop(context, {
                            "title": titleController.text.trim(),
                            "icon": selectedIcon,
                            "color": selectedColor,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Add Category",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
