import 'package:flutter/material.dart';
import 'package:money_tracker/utils/formatters.dart';
import 'package:money_tracker/models/category.dart';
import 'package:money_tracker/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(this.transaction, {super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final color = transaction.category.type == CategoryType.income
        ? const Color.fromARGB(255, 0, 145, 5)
        : const Color.fromARGB(255, 255, 17, 0);
    final sign = transaction.category.type == CategoryType.income ? '+' : '-';
    final icon = transaction.category.icon;
    final cardColor = transaction.category.color.withValues(alpha: 0.3);

    return Card(
      color: cardColor,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
        title: Text(
          transaction.title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        subtitle: Text(transaction.category.title),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$sign \$${formatNumberForDisplay(transaction.amount)}',
              style: TextStyle(color: color, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(formatRelativeDate(transaction.date)),
          ],
        ),
      ),
    );
  }
}
