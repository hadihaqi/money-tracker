import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/dummy_data/transactions.dart';

import 'package:money_tracker/models/transaction.dart';
class TransactionsNotifier extends StateNotifier<List<Transaction>> {
  TransactionsNotifier() : super(dummyTransactions);

  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }

  void removeTransaction(Transaction transaction) {
    state = state.where((t) => t.id != transaction.id).toList();
  }
}

final transactionsProvider =
    StateNotifierProvider<TransactionsNotifier, List<Transaction>>(
      (ref) => TransactionsNotifier(),
    );
