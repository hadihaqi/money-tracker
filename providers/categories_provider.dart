import 'package:money_tracker/models/category.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/dummy_data/categories.dart';

class CategoriesProviderNotifier extends StateNotifier<List<Category>> {
  CategoriesProviderNotifier() : super(dummyCategories);

  void addCategory(Category category) {
    state = [...state, category];
  }

  void removeCategory(String id) {
    state = state.where((c) => c.id != id).toList();
  }
}

final categoriesProvider = StateNotifierProvider(
  (ref) => CategoriesProviderNotifier(),
);
