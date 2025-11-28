import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:money_tracker/screens/add_transaction.dart';
import 'package:money_tracker/screens/auth/login.dart';
import 'package:money_tracker/screens/categories_screen.dart';
import 'package:money_tracker/screens/dashboard_screen.dart';
import 'package:money_tracker/screens/reports_screen.dart';
import 'package:money_tracker/services/auth_service.dart';
import 'package:money_tracker/widgets/drawer/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  void _onSelectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onSetScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier.toLowerCase() == 'categories') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => const CategoriesScreen()));
      return;
    }
    if (identifier.toLowerCase() == 'sign out') {
      AuthService.clearToken();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => Login()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const DashboardScreen();
    String title = 'Dashboard';

    if (_currentIndex == 1) {
      content = const ReportsScreen();
      title = 'Reports';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      ),
      drawer: MainDrawer(onSelectScreen: _onSetScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => const AddTransaction()));
        },
        shape: CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(pi / 4),
            ),
          ),
          child: Icon(CupertinoIcons.add),
        ),
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onSelectTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}
