// ignore_for_file: unused_import

import 'package:ecommerce_flutter_laravel/screens/home_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/login_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/registeration_screen.dart';
import 'package:ecommerce_flutter_laravel/services/auth.dart';
import 'package:ecommerce_flutter_laravel/services/auth1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Auth()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const LoginScreen(),
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Some error has Occurred');
            } else if (snapshot.hasData) {
              final token = snapshot.data!.getString('token');
              if (token != null) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            } else {
              return LoginScreen();
            }
          }),
      // Consumer<Auth>(builder: (context, auth, child) {
      //   if (auth.authenticated) {
      //     return HomeScreen();
      //   } else {
      //     return LoginScreen();
      //   }
      // }),
    );
  }
}
