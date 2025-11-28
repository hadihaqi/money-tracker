import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Coming',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 52,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              'Soon',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 40,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              '...',
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
