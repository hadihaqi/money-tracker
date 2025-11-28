import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/category.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key, required this.categories});

  final List<Category> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (categories.isEmpty) {
      return const Center(child: Text("No Categories yet"));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemCount: categories.length,
      itemBuilder: (ctx, index) {
        final category = categories[index];
        return ListTile(
          contentPadding: const EdgeInsets.only(bottom: 10),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: category.color,
            ),
            child: category.icon,
          ),
          title: Text(category.title),
        );
      },
    );
  }
}
