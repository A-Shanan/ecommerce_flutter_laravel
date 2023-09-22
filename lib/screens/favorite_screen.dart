// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/cart_screen.dart';
import 'package:ecommerce_flutter_laravel/services/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<SharedPreferences>? preferencesFuture;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    preferencesFuture = SharedPreferences.getInstance();
    getWishlistData();
  }

  void getWishlistData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await preferencesFuture!;
    String? token = preferences.getString('token');
    if (token != null) {
      Provider.of<Wishlist>(context, listen: false).getWishlist(token);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: preferencesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        SharedPreferences preferences = snapshot.data!;
        String? token = preferences.getString('token');
        final cartProvider = Provider.of<CartProvider>(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: AppBar(
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
                            SizedBox(width: 9),
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
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  AppLocale.of(context).translate('favorite')!,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient:
                        Provider.of<ThemeProvider>(context).linearGradient),
              ),
            ),
          ),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: Provider.of<ThemeProvider>(context).linearGradient),
            child: Container(
              width: double.infinity,
              height: 605.491,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Provider.of<ThemeProvider>(context).backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
                child: Consumer<Wishlist>(
                  builder: (context, wishlist, child) {
                    return ListView.builder(
                      itemCount: wishlist.wishlists.length,
                      itemBuilder: (context, index) {
                        final item = wishlist.wishlists[index];
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            wishlist.deleteWishlist(token, item['id'] as int);
                          },
                          child: Card(
                            child: ListTile(
                              isThreeLine: true,
                              leading: Image.network(
                                item['products']['image'],
                                height:
                                    MediaQuery.of(context).size.height / 3.0,
                              ),
                              title: Text(
                                "${item['products']['name']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              subtitle: Text(
                                "${item['products']['description']}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 13),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
