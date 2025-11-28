import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  User({
    String? id,
    required this.name,
    required this.email,
    required this.password,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  final String email;
  final String password;

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }
}
