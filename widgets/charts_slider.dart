import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_tracker/widgets/account_overview.dart';
import 'package:money_tracker/widgets/charts/income_expense_chart.dart';

class ChartsSlider extends StatefulWidget {
  const ChartsSlider({super.key});

  @override
  State<ChartsSlider> createState() {
    return _ChartSliderState();
  }
}

class _ChartSliderState extends State<ChartsSlider> {
  PageController _controller = PageController();
  int _pageIndex = 0;

  // PageView(
  //   controller: _controller,
  //   onPageChanged: (index) {
  //     setState(() => _pageIndex = index);
  //   },
  //   children: [...]
  // );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _pageIndex = index);
            },
            children: [AccountOverview(), IncomeExpenseChart()],
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
