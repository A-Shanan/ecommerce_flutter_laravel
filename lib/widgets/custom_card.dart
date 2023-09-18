// ignore_for_file: avoid_print, unused_import

import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/services/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 0.5,
      child: Container(
        width: MediaQuery.of(context).size.width / 2.2,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Provider.of<ThemeProvider>(context).backgroundColorCard,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(4, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 6.5,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 9, right: 9, top: 5, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.5),
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "\$${price.toString()}",
                        style: const TextStyle(
                            fontFamily: 'Poppins', fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
