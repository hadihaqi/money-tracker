import 'package:flutter/material.dart';
import 'package:money_tracker/screens/dashboard/widgets/user_overview.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [UserOverview()]),
        ),
      ),
    );
  }
}
