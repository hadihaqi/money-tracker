import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  User({required this.fullName, required this.email, required this.password})
    : id = uuid.v4();

  final String id;
  final String fullName;
  final String email;
  final String password;
}
