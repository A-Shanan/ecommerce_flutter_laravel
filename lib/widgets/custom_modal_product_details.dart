// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/review_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/wishlist.dart';

class CustomModal extends StatefulWidget {
  final String imageUrl;
  final String imageUrlB;
  final String title;
  final String titleB;
  final String description;
  final String price;
  final double priceB;
  final int stock;
  int? productId;
  final int productIdButton;
  final int userIdd;

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
    required this.productIdButton,
    required this.userIdd,
    preferences,
  });

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  @override
  Widget build(BuildContext context) {
    final reviewProviderr =
        Provider.of<ReviewProvider>(context).getAllReviews(widget.productId!);

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
                  widget.imageUrl,
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
                      widget.title,
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                          height: 1.2, fontFamily: 'Poppins', fontSize: 17),
                    ),
                    Text(
                      "In Stock: ${widget.stock}",
                      style: const TextStyle(
                          height: 1.2, fontFamily: 'Poppins', fontSize: 17),
                    ),
                    IconButton(
                      onPressed: () async {},
                      icon: Consumer<Wishlist>(
                        builder: (context, favoriteModel, child) {
                          return IconButton(
                            icon: Icon(
                              favoriteModel.isFavorite(widget.productId!)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: const Color(0xffFFB100),
                            ),
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              String? token = preferences.getString('token');
                              favoriteModel.toggleFavorite(widget.productId!,
                                  preferences.getInt('user_id')!, token!);
                            },
                          );
                        },
                      ),
                    ),
                    // Text('data'),
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 200.0,
                      ),
                      child: Consumer<ReviewProvider>(
                        builder: (context, provider, child) {
                          if (provider.reviewProductItems.isEmpty) {
                            return Center(
                                child: Text(
                              AppLocale.of(context).translate('noReview')!,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ));
                          } else if (provider
                                  .reviewProductItemGetter.isNotEmpty &&
                              widget.productId != null) {
                            return ListView.builder(
                              itemCount: provider.reviewProductItems.length,
                              itemBuilder: (context, index) {
                                final reviewItem =
                                    provider.reviewProductItems[index];
                                return ListTile(
                                  title: Text(reviewItem.userName
                                      .toLowerCase()
                                      .toString()),
                                  subtitle:
                                      Text("${reviewItem.review.toString()},"),
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: Text(
                              AppLocale.of(context).translate('noReview')!,
                            ));
                          }
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient:
                        Provider.of<ThemeProvider>(context).linearGradient,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(
                        widget.productIdButton,
                        widget.titleB,
                        widget.priceB,
                        widget.imageUrlB,
                      );
                    },
                    child: Text(
                      AppLocale.of(context).translate('addToCart')!,
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                Text(
                  "\$ ${widget.price}",
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
