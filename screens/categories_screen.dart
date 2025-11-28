import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/category.dart';
import 'package:money_tracker/providers/categories_provider.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/widgets/add_category.dart';
import 'package:money_tracker/widgets/category_list.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCategories = ref.watch(categoriesProvider);

    final currentUser = ref.watch(currentUserProvider);

    final currentUserCategories = allCategories
        .where((c) => c.userId == currentUser!.id)
        .toList();

    final incomeCategories = currentUserCategories
        .where((c) => c.type == CategoryType.income)
        .toList();

    final expenseCategories = currentUserCategories
        .where((c) => c.type == CategoryType.expense)
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Categories',
            style: TextStyle(
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Income"),
              Tab(text: "Expense"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoryList(categories: incomeCategories),
            CategoryList(categories: expenseCategories),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 70,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                showAddCategorySheet(context, ref);
              },
              label: Text('Add Category'),
              icon: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
