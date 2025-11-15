import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/models/user.dart';

class UsersNotifier extends StateNotifier<List<User>> {
  UsersNotifier() : super([]);

  void addUser(User user) {
    state = [...state, user];
  }
}

final usersProvider = StateNotifierProvider((ref) => UsersNotifier());
