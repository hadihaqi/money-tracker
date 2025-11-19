import 'package:flutter_riverpod/legacy.dart';
import 'package:money_tracker/models/user.dart';

final currentUserProvider = StateProvider<User?>((ref) => null);
