// ignore_for_file: avoid_print, prefer_const_literals_to_create_immutables

import 'package:ecommerce_flutter_laravel/screens/address_screen.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 35.0, top: 20.0),
              child: Container(
                width: 65.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 4,
                      offset: const Offset(4, 8), // Shadow position
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // Handle button tap
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
                        const Text(
                          '1',
                          style: TextStyle(color: Colors.black),
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
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Profile',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Color(0xffFFB100),
                  Color(0xffEEAE1C),
                  Color(0xffF5A64F),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Color(0xffFFB100),
              Color(0xffEEAE1C),
              Color(0xffF5A64F),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 605.491,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Color(0xffF5F5F5),
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
                      children: const [
                        Icon(size: 35.0, Icons.person_2_outlined),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Poppins'),
                            'My Profile'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {},
                    icon: Row(
                      children: const [
                        Icon(size: 35.0, Icons.credit_card_outlined),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Poppins'),
                            'My Cards'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddressScreen()));
                    },
                    icon: Row(
                      children: const [
                        Icon(
                          size: 35.0,
                          Icons.home_work_outlined,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Poppins'),
                            'My Addresses'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {},
                    icon: Row(
                      children: const [
                        Icon(size: 35.0, Icons.settings),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Poppins'),
                            'My Settings'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: IconButton(
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false)
                          .logout(preferences!, context);
                    },
                    icon: Row(
                      children: const [
                        Icon(size: 35.0, Icons.logout_outlined),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                            style: TextStyle(
                                fontSize: 20.0, fontFamily: 'Poppins'),
                            'Logout'),
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
