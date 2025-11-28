import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/user.dart';
import 'package:money_tracker/providers/auth_provider.dart';
import 'package:money_tracker/providers/users.dart';

final currentUserProvider = Provider<User?>((ref) {
  final users = ref.watch(usersProvider);
  final tokenAsync = ref.watch(authTokenProvider);

  if (tokenAsync.isLoading) return null;

  final token = tokenAsync.value;
  if (token == null) return null;

  try {
    return users.firstWhere((u) => u.id == token);
  } catch (e) {
    return null;
  }
});
