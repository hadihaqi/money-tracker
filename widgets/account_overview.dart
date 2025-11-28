import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/category.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/providers/transactions.dart';
import 'package:money_tracker/utils/formatters.dart';

class AccountOverview extends ConsumerWidget {
  const AccountOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final currentUserTransactions = ref
        .watch(transactionsProvider)
        .where((t) => t.userId == currentUser!.id);

    final incomesList = currentUserTransactions.where(
      (t) => t.category.type == CategoryType.income,
    );
    final totalIncome = incomesList.fold(0.0, (sum, t) => sum + t.amount);

    final expnsesList = currentUserTransactions.where(
      (t) => t.category.type == CategoryType.expense,
    );
    final totalExpense = expnsesList.fold(0.0, (sum, t) => sum + t.amount);

    final balance = totalIncome - totalExpense;

    final formattedIncome = formatNumberForDisplay(totalIncome);
    final formattedExpense = formatNumberForDisplay(totalExpense);
    final formatedBalance = formatNumberForDisplay(balance);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.tertiary,
          ],
          transform: const GradientRotation(pi / 4),
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.grey.shade300,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '\$ $formatedBalance',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.arrow_up,
                            size: 16,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '\$ $formattedIncome',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white38,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.arrow_down,
                          size: 16,
                          color: Colors.red,
                          weight: 1,
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expense',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '\$ $formattedExpense',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
