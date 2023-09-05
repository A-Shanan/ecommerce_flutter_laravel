// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class User {
  String name;
  String email;
  String password;
  User({
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  // User.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       email = json['email'],
  //       password = json['password'],
  //       email_verified_at = json['email_verified_at'],
  //       remember_token = json['remember_token'],
  //       created_at = json['created_at'],
  //       updated_at = json['updated_at'],
  //       id = json['id'];

  // factory User.fromJson(Map<String, dynamic> json) {
  //   if (json is Map<String, dynamic>) {
  //     return User(
  //       name: json['name'],
  //       email: json['email'],
  //       password: json['password'],
  //     );
  //   } else {
  //     if (json is List<dynamic>) {
  //       // Handle the list structure here
  //       if (json.isNotEmpty) {
  //         final userJson = json[0];
  //         return User(
  //           name: userJson['name'],
  //           email: userJson['email'],
  //           password: userJson['password'],
  //         );
  //       }
  //     }
  //   }
  //   throw Exception('Invalid user data');
  // }

  static List<User> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => User.fromJson(json)).toList();
  }
}
