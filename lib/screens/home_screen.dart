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

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_import

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/cart_screen.dart';
import 'package:ecommerce_flutter_laravel/services/getProducts.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_card.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_modal_product_details.dart';
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
    getUserData().then((_) {
      setState(() {});
    });
  }

  Future<void> getUserData() async {
    isLoading = true;
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    await Provider.of<GetProducts>(context, listen: false).getAllProduct(token);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    // String? token = preferences.getString('token');
    final cartProvider = Provider.of<CartProvider>(context);
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 35.0, top: 20.0, left: 10),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${cartProvider.cartItemsGetter.length}',
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
                    AppLocale.of(context).translate('home')!,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
                  ),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient:
                        Provider.of<ThemeProvider>(context).linearGradient,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(80.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(secondary: Colors.white)),
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
                            hintText:
                                AppLocale.of(context).translate('searchBar')!,
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.00001),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
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
                  gradient: Provider.of<ThemeProvider>(context).linearGradient,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Provider.of<ThemeProvider>(context).backgroundColor,
                  ),
                  child: Consumer<GetProducts>(
                    builder: (context, provider, child) {
                      // Check if the data is loaded
                      if (provider.products.isEmpty) {
                        return Center(
                            child:
                                CircularProgressIndicator()); // Loading indicator
                      } else if (provider.products.isEmpty) {
                        return Text(AppLocale.of(context)
                            .translate('noProductAvailable')!);
                      } else {
                        // Use ListView.builder to display the products
                        return GridView.builder(
                          padding: EdgeInsets.only(top: 10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1.0,
                            mainAxisExtent: 220,
                            mainAxisSpacing: 10.0,
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
                                      productId: product['id'],
                                      imageUrlB: product['image'],
                                      priceB: double.parse(product["price"]),
                                      productIdB: product['id'],
                                      titleB: product['name'],
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
        });
  }
}
