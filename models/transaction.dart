import 'package:money_tracker/models/category.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum TransactionType { income, expense }

class Transaction {
  Transaction({
    String? id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
  }) : id = id ?? uuid.v4();

  final String id;
  final String userId;
  final String title;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final Category category;
}
