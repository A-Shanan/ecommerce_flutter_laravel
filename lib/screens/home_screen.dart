// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/services/auth1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences preferences;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  final storage = const FlutterSecureStorage();

  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token!);
    print('TOKEN READ FROM SECURE STORAGE : $token');
  }

  @override
  Widget build(BuildContext context) {
    // var token = Provider.of<Auth>(context).token;
    // var headers = {
    //   'Authorization': 'Bearer $token',
    // };
    //

    //////////////////////////////////////////////////

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen '),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false)
                    .logout(preferences, context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // Text(preferences!.getInt('user_id').toString()),
                  // Text(preferences!.getString('name').toString()),
                  // Text(preferences!.getString('email').toString()),
                  // Text(preferences?.getInt('user_id').toString() ??
                  //     'User ID is null'),
                  Text(preferences.getString('name') ?? 'Name is null'),
                  Text(preferences.getString('email') ?? 'Email is null'),
                  Text(preferences.getString('token') ?? 'Emailsss is null'),
                  Text(preferences.getString('ship') ??
                      'Emaiasdasdasdsalsss is null'),
                  Text((preferences.getStringList('ship1') ?? ['ssss'])
                      .join('s, ')),
                ],
              ),
      ),
    );
  }
}
