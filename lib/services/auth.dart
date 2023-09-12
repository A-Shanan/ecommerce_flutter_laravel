// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:ecommerce_flutter_laravel/models/user_model.dart';
import 'package:ecommerce_flutter_laravel/nav_bar.dart';
import 'package:ecommerce_flutter_laravel/screens/login_screen.dart';

import '../screens/home_screen.dart';
import 'API.dart';

class Auth extends ChangeNotifier {
  bool isLoggedIn = false;

  // User? user;
  String? token;

  bool get authenticated => isLoggedIn;
  // User get userGetter => user!;
  late SharedPreferences preferences;

  final storage = const FlutterSecureStorage();

  // postRequest(String route, Map<String, dynamic> data) async {
  //   String url = "http://192.168.137.1:8000/api/v1$route";
  //   return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
  //     HttpHeaders.acceptHeader: 'application/json',
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   });
  // }

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

  // void tryToken(String token) async {
  //   if (token.isEmpty) {
  //     print("dddddd_________________________");
  //     return;
  //   } else {
  //     try {
  //       Dio.Response response = await dio().get(
  //         "/user",
  //         options: Dio.Options(
  //           headers: {'Authorization': 'Bearer $token'},
  //         ),
  //       );
  //       isLoggedIn = true;
  //       user = User.fromJson(response.data);
  //       storeToken(token);
  //       notifyListeners();
  //       print("info from tryToken function for users: $user");
  //     } catch (e) {
  //       print("error from tryToken______ function Catch: ${e.toString()}");
  //     }
  //   }
  // }

  // void storeToken(String token) async {
  //   storage.write(key: 'token', value: token);
  // }

  void logout(SharedPreferences pref, BuildContext context) {
    pref.clear();
    isLoggedIn = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    notifyListeners();
  }
}
