import 'package:flutter/material.dart';

import 'package:money_tracker/dummy_data/users.dart';
import 'package:money_tracker/models/category.dart';

final dummyCategories = [
  Category(
    userId: dummyUsers[0].id,
    title: 'Food',
    icon: const Icon(Icons.fastfood),
    color: Colors.orange,
  ),
  Category(
    userId: dummyUsers[0].id,
    title: 'Transport',
    icon: const Icon(Icons.directions_car),
    color: Colors.blue,
  ),
  Category(
    userId: dummyUsers[1].id,
    title: 'Shopping',
    icon: const Icon(Icons.shopping_bag),
    color: Colors.purple,
  ),
  Category(
    userId: dummyUsers[2].id,
    title: 'Salary',
    icon: const Icon(Icons.attach_money),
    color: Colors.green,
  ),
];
