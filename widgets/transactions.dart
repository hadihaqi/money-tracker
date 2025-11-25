import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/providers/transactions.dart';
import 'package:money_tracker/widgets/transaction_item.dart';

class Transactions extends ConsumerWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final transactions = ref.watch(transactionsProvider);
    final currentUserTransactions = transactions
        .where((t) => t.userId == currentUser.id)
        .toList();
    return ListView.builder(
      itemCount: currentUserTransactions.length,
      itemBuilder: (ctx, index) {
        final transaction = currentUserTransactions[index];
        return Dismissible(
          key: ValueKey(transaction.id),
          onDismissed: (direction) {
            ref
                .read(transactionsProvider.notifier)
                .removeTransaction(transaction);
          },
          child: TransactionItem(transaction),
        );
      },
    );
  }
}
