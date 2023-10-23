import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
  final String name;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.password,
  });

  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'],
      password: json['password'],
    );
  }
}
