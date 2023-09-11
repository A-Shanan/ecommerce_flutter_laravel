// ignore_for_file: unused_import

import 'package:ecommerce_flutter_laravel/nav_bar.dart';
import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/home_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/login_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/registeration_screen.dart';
import 'package:ecommerce_flutter_laravel/services/auth.dart';
import 'package:ecommerce_flutter_laravel/services/auth1.dart';
import 'package:ecommerce_flutter_laravel/services/getProducts.dart';
import 'package:ecommerce_flutter_laravel/services/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Auth()),
      ChangeNotifierProvider(create: (context) => GetProducts()),
      ChangeNotifierProvider(create: (context) => Wishlist()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
    ],
    child: const MyApp(),
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
      debugShowCheckedModeBanner: false,
      // home: const LoginScreen(),
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Some error has Occurred');
            } else if (snapshot.hasData) {
              final token = snapshot.data!.getString('token');
              if (token != null) {
                return const NavBar();
              } else {
                return const LoginScreen();
              }
            } else {
              return const LoginScreen();
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
