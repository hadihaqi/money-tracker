import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/db/users_db_helper.dart';

import 'package:money_tracker/models/user.dart';

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]) {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final users = await UsersDbHelper.getUsers();
    state = users;
  }

  Future<void> addUser(User user) async {
    await UsersDbHelper.insertUser(user);
    state = [...state, user];
  }
}

final usersProvider = StateNotifierProvider<UsersNotifier, List<User>>(
  (ref) => UsersNotifier(),
);
