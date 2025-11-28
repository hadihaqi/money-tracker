import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  String? subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(color: const Color.fromARGB(255, 102, 102, 102)),
            )
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
