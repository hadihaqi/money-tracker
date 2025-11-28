import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/models/category.dart';
import 'package:money_tracker/models/transaction.dart';
import 'package:money_tracker/utils/formatters.dart';

class IncomeCategoryChart extends StatelessWidget {
  const IncomeCategoryChart({super.key, required this.userTransactions});

  final List<Transaction> userTransactions;

  @override
  Widget build(BuildContext context) {
    final incomes = userTransactions
        .where((t) => t.category.type == CategoryType.income)
        .toList();

    if (incomes.isEmpty) {
      return const Center(child: Text("No Income yet"));
    }

    final Map<Category, double> totals = {};

    for (final t in incomes) {
      totals[t.category] = (totals[t.category] ?? 0) + t.amount;
    }

    final totalIncome = totals.values.fold(0.0, (a, b) => a + b);

    final sections = totals.entries.map((entry) {
      final percent = (entry.value / totalIncome) * 100;

      return PieChartSectionData(
        value: entry.value,
        color: entry.key.color,
        title: '${formatNumberForDisplay(percent)}%',
        radius: 40,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
    return Column(
      children: [
        const Text(
          "Income by Category",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    sectionsSpace: 2,
                    centerSpaceRadius: 30,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: totals.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: entry.key.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${entry.key.title} — ${entry.value.toStringAsFixed(0)}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
