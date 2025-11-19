import 'package:flutter_riverpod/legacy.dart';

import 'package:money_tracker/models/user.dart';
import 'package:money_tracker/dummy_data/users.dart';

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super(dummyUsers);

  void addUser(User user) {
    state = [...state, user];
  }
}

final usersProvider = StateNotifierProvider((ref) => UsersNotifier());
