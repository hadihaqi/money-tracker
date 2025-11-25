import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/category.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/providers/transactions.dart';
import 'package:money_tracker/widgets/charts/my_pie_chart.dart';

class IncomeExpenseChart extends ConsumerWidget {
  const IncomeExpenseChart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    final currentUser = ref.watch(currentUserProvider);

    final currentUserTransactions = transactions.where(
      (t) => t.userId == currentUser.id,
    );

    final totalIncome = currentUserTransactions
        .where((t) => t.category.type == CategoryType.income)
        .fold(0.0, (sum, t) => sum + t.amount);

    final totalExpense = currentUserTransactions
        .where((t) => t.category.type == CategoryType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);

    return MyPieChart(
      data: {'Income': totalIncome, 'Expense': totalExpense},
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.secondary,
      ],
    );
  }
}
