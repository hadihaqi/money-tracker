import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/providers/transactions.dart';
import 'package:money_tracker/widgets/account_overview.dart';
import 'package:money_tracker/widgets/charts/expense_category_chart.dart';
import 'package:money_tracker/widgets/charts/income_expense_chart.dart';

class ChartsSlider extends ConsumerStatefulWidget {
  const ChartsSlider({super.key});

  @override
  ConsumerState<ChartsSlider> createState() {
    return _ChartSliderState();
  }
}

class _ChartSliderState extends ConsumerState<ChartsSlider> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final allTransactions = ref.watch(transactionsProvider);

    final currentUser = ref.watch(currentUserProvider);

    final currentUserTransactions = allTransactions
        .where((t) => t.userId == currentUser.id)
        .toList();

    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _pageIndex = index);
            },
            children: [
              AccountOverview(),
              IncomeExpenseChart(),
              ExpenseCategoryChart(transactions: currentUserTransactions),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            return Container(
              margin: const EdgeInsets.all(4),
              width: _pageIndex == i ? 12 : 8,
              height: _pageIndex == i ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _pageIndex == i ? Colors.blue : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}
