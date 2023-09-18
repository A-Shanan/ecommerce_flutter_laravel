// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/address_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/cart_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  SharedPreferences? preferences;
  bool isLoading = false;

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 35.0, top: 20.0, left: 10),
              child: Container(
                width: 65.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(4, 8),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          '${cartProvider.cartItemsGetter.length}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          elevation: 0.0,
          scrolledUnderElevation: 1.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              AppLocale.of(context).translate('profile')!,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: Provider.of<ThemeProvider>(context).linearGradient),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: Provider.of<ThemeProvider>(context).linearGradient),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 605.491,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Provider.of<ThemeProvider>(context).backgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color.fromARGB(58, 213, 189, 189),
                            minRadius: 45.0,
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                  'https://www.worldbirdsanctuary.org/wp-content/uploads/2021/07/goblin.jpg'),
                            ),
                          ),
                          // const SizedBox(height: 1.0),
                          TextButton(
                            onPressed: () {
                              print('edit button is tapped');
                            },
                            child: const Text(
                              'edit',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 30.0),
                      child: SizedBox(
                          width: 200.0,
                          child: preferences != null
                              ? Text(
                                  preferences!.getString('name') ??
                                      'Name is null',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 21.0,
                                    fontFamily: 'Poppins',
                                  ),
                                )
                              : const CircularProgressIndicator()),
                    ),
                  ],
                ),
                const Divider(color: Color.fromARGB(255, 92, 225, 68)),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {},
                    icon: Row(
                      children: [
                        const Icon(
                          size: 35.0,
                          Icons.person_2_outlined,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          AppLocale.of(context).translate('myProfile')!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {},
                    icon: Row(
                      children: [
                        const Icon(
                          size: 35.0,
                          Icons.storage_rounded,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          AppLocale.of(context).translate('myOrders')!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AddressScreen()));
                    },
                    icon: Row(
                      children: [
                        const Icon(
                          size: 35.0,
                          Icons.home_work_outlined,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          AppLocale.of(context).translate('myAddresses')!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    icon: Row(
                      children: [
                        const Icon(size: 35.0, Icons.settings),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          AppLocale.of(context).translate('mySettings')!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String? token = preferences.getString('token');
                      Provider.of<Auth>(context, listen: false)
                          .logout(preferences, context, token!);
                    },
                    icon: Row(
                      children: [
                        const Icon(size: 35.0, Icons.logout_outlined),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          AppLocale.of(context).translate('logout')!,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
