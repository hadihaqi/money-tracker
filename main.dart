import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/auth_provider.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/screens/auth/login.dart';
import 'package:money_tracker/screens/splash_screen.dart';
import 'package:money_tracker/screens/tabs_screen.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade100,
    onSurface: Colors.black,
    primary: const Color(0xFF00B2E7),
    secondary: const Color(0xFFE064F7),
    tertiary: const Color(0xFFFF8D6C),
    outline: Colors.grey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade200,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    errorStyle: const TextStyle(color: Colors.red, fontSize: 13),
    hintStyle: TextStyle(color: Colors.grey.shade600),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(57, 199, 199, 199),
    centerTitle: true,
    titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    foregroundColor: Color.fromARGB(255, 99, 99, 99),
  ),
);

Future<void> main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authTokenProvider);

    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: authState.when(
        loading: () => const SplashScreen(),
        error: (error, stackTrace) => Login(),
        data: (token) {
          if (token == null) {
            return Login();
          }
          final currentUser = ref.watch(currentUserProvider);

          if (currentUser == null) {
            return SplashScreen();
          }

          return const TabsScreen();
        },
      ),
    );
  }
}
