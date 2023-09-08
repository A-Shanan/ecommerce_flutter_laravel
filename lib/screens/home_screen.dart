// // ignore_for_file: avoid_print

// import 'dart:convert';

// import 'package:ecommerce_flutter_laravel/services/auth1.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../services/auth.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late SharedPreferences preferences;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }

//   void getUserData() async {
//     setState(() {
//       isLoading = true;
//     });
//     preferences = await SharedPreferences.getInstance();
//     setState(() {
//       isLoading = false;
//     });
//   }

//   final storage = const FlutterSecureStorage();

//   void readToken() async {
//     String? token = await storage.read(key: 'token');
//     Provider.of<Auth>(context, listen: false).tryToken(token!);
//     print('TOKEN READ FROM SECURE STORAGE : $token');
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var token = Provider.of<Auth>(context).token;
//     // var headers = {
//     //   'Authorization': 'Bearer $token',
//     // };
//     //

//     //////////////////////////////////////////////////

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen '),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Provider.of<Auth>(context, listen: false)
//                     .logout(preferences, context);
//               },
//               icon: Icon(Icons.logout))
//         ],
//       ),
//       body: SafeArea(
//         child: isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Column(
//                 children: [
//                   // Text(preferences!.getInt('user_id').toString()),
//                   // Text(preferences!.getString('name').toString()),
//                   // Text(preferences!.getString('email').toString()),
//                   // Text(preferences?.getInt('user_id').toString() ??
//                   //     'User ID is null'),
//                   Text(preferences.getString('name') ?? 'Name is null'),
//                   Text(preferences.getString('email') ?? 'Email is null'),
//                   Text(preferences.getString('token') ?? 'Emailsss is null'),
//                   Text(preferences.getString('ship') ??
//                       'Emaiasdasdasdsalsss is null'),
//                   Text((preferences.getStringList('ship1') ?? ['ssss'])
//                       .join('s, ')),
//                 ],
//               ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:ecommerce_flutter_laravel/services/getProducts.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_card.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth.dart';
// import 'package:marketapp/screen/category_screen.dart';

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
    String? token = preferences.getString('token');
    Provider.of<GetProducts>(context, listen: false).getAllProduct(token);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? token = preferences.getString('token');
    // final getProductsProvider = Provider.of<GetProducts>(context);
    // // Trigger the method to fetch products (you might do this in an init state or button press)
    // getProductsProvider.getAllProduct(token);
    return Scaffold(
      appBar: AppBar(
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
                    offset: Offset(4, 8),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  print(preferences.getInt('user_id'));
                  print(preferences.getString('email'));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(width: 9),
                      Text(
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
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            'Home',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 20.0,
              ),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.19),
                    contentPadding: const EdgeInsets.only(top: 12.0),
                    hintText: 'Markets,Category,....',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.00001),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
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
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Color(0xffF5F5F5),
          ),
          child: Consumer<GetProducts>(
            builder: (context, provider, child) {
              // Check if the data is loaded
              if (provider.products.isEmpty) {
                return CircularProgressIndicator(); // Loading indicator
              } else if (provider.products.isEmpty) {
                return Text('No products available.');
              } else {
                // Use ListView.builder to display the products
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisExtent: 210,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          builder: (context) {
                            return CustomModal(
                              imageUrl: product['image'],
                              title: product['name'],
                              description: product['description'],
                              price: product['price'],
                              stock: product['stock'],
                              id: product['id'],
                            );
                          },
                        );
                      },
                      child: CustomCard(
                        imageUrl: product['image'],
                        title: product['name'],
                        description: product['description'],
                        price: product['price'],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // void showModal(BuildContext context1){
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context1,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(20),
  //       ),
  //     ),
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     builder: (context) {
  //       return CustomModal(
  //           imageUrl: product['image'],
  //           title: product['name'],
  //           description: product['description'],
  //           price: product['price']);
  //     },
  //   );
  // }
}

Widget iconSlider() => Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border:
                Border.all(width: 1, color: Color(0xff0A1D37).withOpacity(0.9)),
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Image.asset(
            'assets/icon/fruits.png',
            height: 20.0,
            width: 20.0,
          ),
        ),
      ],
    );

Widget recommenededCard() => Container(
      width: double.infinity,
      height: 205.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  width: double.infinity,
                  height: 116.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image.asset(
                      'assets/images/grocery.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        print('favIcon is pressed');
                      },
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'FDG Market',
            style: TextStyle(
                fontSize: 11.5, color: Colors.black, fontFamily: 'Poppins'),
          ),
          Container(
            height: 50,
            child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => iconSlider(),
                separatorBuilder: (context, index) => SizedBox(
                    //width: 20.0,
                    ),
                itemCount: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            child: SizedBox(
              width: 170.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 10,
                        color: Color(0xff0A1D37),
                      ),
                      Text(
                        '18 mins',
                        style: TextStyle(fontSize: 8.0),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.navigation_rounded,
                        size: 10,
                        color: Color(0xff0A1D37),
                      ),
                      Text(
                        '2: KM.',
                        style: TextStyle(fontSize: 8.0),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 10,
                        color: Color(0xff0A1D37),
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(fontSize: 8.0),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 10,
                        color: Color(0xff0A1D37),
                      ),
                      Text(
                        '317',
                        style: TextStyle(fontSize: 8.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
