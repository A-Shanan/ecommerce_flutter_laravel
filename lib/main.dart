// ignore_for_file: unused_import

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/nav_bar.dart';
import 'package:ecommerce_flutter_laravel/providers/address_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/language_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/order_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/review_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/home_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/login_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/registeration_screen.dart';
import 'package:ecommerce_flutter_laravel/services/auth.dart';
import 'package:ecommerce_flutter_laravel/services/getProducts.dart';
import 'package:ecommerce_flutter_laravel/services/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Auth()),
      ChangeNotifierProvider(create: (context) => GetProducts()),
      ChangeNotifierProvider(create: (context) => Wishlist()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => OrderProvider()),
      ChangeNotifierProvider(create: (context) => AddressProvider()),
      ChangeNotifierProvider(create: (context) => ReviewProvider()),
      ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      // ChangeNotifierProvider<LanguageProvider>(create: (_) => LanguageProvider()),//try it later
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<LanguageProvider>(context, listen: false).initialazie();
    Provider.of<ThemeProvider>(context, listen: false).initialazie();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).theme == 'light'
          ? ThemeData.light()
          : ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocale.delegate
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      locale: Locale(Provider.of<LanguageProvider>(context).lang, ''),
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
    );
  }
}
