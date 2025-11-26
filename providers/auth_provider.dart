import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/services/auth_service.dart';

final authTokenProvider = FutureProvider<String?>(
  (ref) async => await AuthService.getToken(),
);
