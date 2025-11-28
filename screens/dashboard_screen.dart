import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/providers/transactions.dart';
import 'package:money_tracker/screens/all_transactions.dart';

import 'package:money_tracker/widgets/charts/charts_slider.dart';
import 'package:money_tracker/widgets/transactions.dart';
import 'package:money_tracker/widgets/user_overview.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTransactions = ref.watch(transactionsProvider);

    final currentUser = ref.watch(currentUserProvider);

    final currentUserTransactions = allTransactions
        .where((t) => t.userId == currentUser!.id)
        .toList();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              UserOverview(),
              const SizedBox(height: 10),

              AspectRatio(aspectRatio: 2 / 1.4, child: ChartsSlider()),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => AllTransactions(
                            allRecords: currentUserTransactions,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Transactions()),
            ],
          ),
        ),
      ),
    );
  }
}
