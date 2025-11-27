import 'package:flutter/material.dart';

import 'package:money_tracker/widgets/charts/charts_slider.dart';
import 'package:money_tracker/widgets/transactions.dart';
import 'package:money_tracker/widgets/user_overview.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
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
