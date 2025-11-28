import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/providers/transactions.dart';
import 'package:money_tracker/widgets/transaction_item.dart';

class AllTransactions extends ConsumerWidget {
  const AllTransactions({super.key, required this.allRecords});

  final List<Transaction> allRecords;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Records',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: allRecords.length,
        itemBuilder: (context, index) {
          final record = allRecords[index];
          return Dismissible(
            key: ValueKey(record.id),
            child: TransactionItem(record),
            onDismissed: (direction) {
              ref.read(transactionsProvider.notifier).removeTransaction(record);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${record.title} removed from your transactions.',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
