// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_flutter_laravel/nav_bar.dart';
import 'package:ecommerce_flutter_laravel/screens/login_screen.dart';

import 'API.dart';

class Auth extends ChangeNotifier {
  bool isLoggedIn = false;

  String? token;

  bool get authenticated => isLoggedIn;
  late SharedPreferences preferences;

  final storage = const FlutterSecureStorage();

  void login(Map<String, dynamic> creds, BuildContext context) async {
    final result = await API().postRequest('/loginn', creds);
    print("info from login function ${jsonDecode(result.body)}");
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['user']['id']);
      await preferences.setString('name', response['user']['name']);
      await preferences.setString('email', response['user']['email']);
      await preferences.setString('token', response['token']);
      isLoggedIn = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavBar()),
      );
      notifyListeners();
    } else {
      print(response.statusCode);
      print(response["message"]);
    }
  }

  void logout(
      SharedPreferences pref, BuildContext context, String token) async {
    try {
      pref.clear();
      final result = await API().postRequestL("/logout", token);
      print("result: $result");
      isLoggedIn = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      notifyListeners();
    } catch (error) {
      print(['error logout: $error']);
    }
  }
}
