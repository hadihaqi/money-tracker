import 'package:flutter/material.dart';

import 'package:money_tracker/dummy_data/users.dart';
import 'package:money_tracker/models/category.dart';

final dummyCategories = [
  Category(
    userId: dummyUsers[0].id,
    title: 'Food',
    type: CategoryType.expense,
    icon: const Icon(Icons.fastfood),
    color: Colors.orange,
  ),
  Category(
    userId: dummyUsers[0].id,
    title: 'Transport',
    type: CategoryType.expense,
    icon: const Icon(Icons.directions_car),
    color: Colors.blue,
  ),
  Category(
    userId: dummyUsers[0].id,
    title: 'Shopping',
    type: CategoryType.expense,
    icon: const Icon(Icons.shopping_bag),
    color: Colors.purple,
  ),
  Category(
    userId: dummyUsers[0].id,
    title: 'Salary',
    icon: const Icon(Icons.attach_money),
    type: CategoryType.income,
    color: Colors.green,
  ),
];
