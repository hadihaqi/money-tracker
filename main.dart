import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:money_tracker/screens/tabs_screen.dart';
import 'package:money_tracker/screens/auth/signup.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade100,
    onSurface: Colors.black,
    primary: const Color(0xFF00B2E7),
    secondary: const Color(0xFFE064F7),
    tertiary: const Color(0xFFFF8D6C),
    outline: Colors.grey,
  ),
);

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: TabsScreen(),
    );
  }
}
