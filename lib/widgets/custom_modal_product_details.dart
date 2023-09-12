// ignore_for_file: prefer_const_constructors_in_immutables, unused_import

import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/wishlist.dart';

class CustomModal extends StatelessWidget {
  final String imageUrl;
  final String imageUrlB;
  final String title;
  final String titleB;
  final String description;
  final String price;
  final double priceB;
  final int stock;
  final int productId;
  final int productIdB;

  CustomModal({
    super.key,
    required this.imageUrl,
    required this.imageUrlB,
    required this.title,
    required this.titleB,
    required this.description,
    required this.price,
    required this.priceB,
    required this.stock,
    required this.productId,
    required this.productIdB,
    preferences,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.95,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                          height: 1.2, fontFamily: 'Poppins', fontSize: 17),
                    ),
                    Text(
                      "In Stock: $stock",
                      style: const TextStyle(
                          height: 1.2, fontFamily: 'Poppins', fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () async {
                        // SharedPreferences preferences =
                        //     await SharedPreferences.getInstance();
                        // String? token = preferences.getString('token');
                        // Map<String, dynamic> data = {
                        //   "product_id": id,
                        //   "user_id": preferences.getInt('user_id'),
                        // };
                        // print('favIcon is pressed');
                        // Provider.of<Wishlist>(context, listen: false)
                        //     .addToFav(data, token!);
                      },
                      icon: Consumer<Wishlist>(
                        builder: (context, favoriteModel, child) {
                          return IconButton(
                            icon: Icon(
                              favoriteModel.isFavorite(productId)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: const Color(0xffFFB100),
                            ),
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              String? token = preferences.getString('token');
                              favoriteModel.toggleFavorite(productId,
                                  preferences.getInt('user_id')!, token!);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 20,
                  // height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Color(0xffFFB100),
                        Color(0xffEEAE1C),
                        Color(0xffF5A64F),
                      ],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(
                        productIdB,
                        titleB,
                        priceB,
                        imageUrlB,
                      );

                      // Navigate to the CartScreen when the user adds a product to the cart.
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => CartScreen(),
                      // ));
                    },
                    child: const Text(
                      "Add to cart",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                Text(
                  "\$ $price",
                  style: const TextStyle(fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
