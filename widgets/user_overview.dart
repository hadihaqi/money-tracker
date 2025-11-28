import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/current_user.dart';
import 'package:money_tracker/screens/settings.dart';

class UserOverview extends ConsumerWidget {
  const UserOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider)!;
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
      title: Text(currentUser.name),
      subtitle: Text(
        currentUser.email,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      // trailing: IconButton(
      //   onPressed: () {
      //     Navigator.of(
      //       context,
      //     ).push(MaterialPageRoute(builder: (ctx) => const Settings()));
      //   },
      //   icon: Icon(CupertinoIcons.settings),
      // ),
    );
  }
}
