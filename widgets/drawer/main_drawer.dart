import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/drawer/drawer_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).appBarTheme.backgroundColor!,
                  Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.38),
                ],
                begin: AlignmentGeometry.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.wallet,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Spend wisely,\n live freely',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).appBarTheme.foregroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          DrawerItem(
            icon: Icons.category_rounded,
            title: 'Categories',
            onSelectScreen: onSelectScreen,
          ),
          DrawerItem(
            icon: Icons.logout_outlined,
            title: 'Sign out',
            onSelectScreen: onSelectScreen,
          ),
        ],
      ),
    );
  }
}
