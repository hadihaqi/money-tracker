import 'package:flutter/material.dart';
import 'package:money_tracker/widgets/settings_item.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SettingsItem(
            icon: Icons.person,
            title: 'Manage Account',
            subtitle: 'Edit Info , ',
          ),
          SettingsItem(
            icon: Icons.category_rounded,
            title: 'Categories',
            subtitle: 'Manage Categories',
          ),
          SettingsItem(icon: Icons.logout_outlined, title: 'Sign Out'),
        ],
      ),
    );
  }
}
