import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserOverview extends StatelessWidget {
  const UserOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow[700],
            ),
          ),
          Icon(CupertinoIcons.person_fill, color: Colors.yellow[800]),
        ],
      ),
      title: Text('name'),
      subtitle: Text(
        'email',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(CupertinoIcons.settings),
      ),
    );
  }
}
