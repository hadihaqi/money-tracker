import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/dummy_data/users.dart';
import 'package:money_tracker/dummy_data/categories.dart';

final dummyTransactions = [
  Transaction(
    userId: dummyUsers[0].id,
    title: 'Groceries',
    amount: 45.90,
    date: DateTime.now().subtract(const Duration(days: 1)),
    category: dummyCategories[0],
    type: TransactionType.expense,
  ),
  Transaction(
    userId: dummyUsers[0].id,
    title: 'Taxi Ride',
    amount: 18.50,
    date: DateTime.now().subtract(const Duration(days: 2)),
    category: dummyCategories[1],
    type: TransactionType.expense,
  ),
  Transaction(
    userId: dummyUsers[1].id,
    title: 'New Shoes',
    amount: 89.99,
    date: DateTime.now().subtract(const Duration(days: 3)),
    category: dummyCategories[2],
    type: TransactionType.expense,
  ),
  Transaction(
    userId: dummyUsers[2].id,
    title: 'Salary Payment',
    amount: 3200.00,
    date: DateTime.now().subtract(const Duration(days: 5)),
    category: dummyCategories[3],
    type: TransactionType.income,
  ),
];
