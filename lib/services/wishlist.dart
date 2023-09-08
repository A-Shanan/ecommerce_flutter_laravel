// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlist extends ChangeNotifier {
  void addToFav(Map<String, dynamic> data, String token) async {
    final result = await API().postRequest1('/wishlist', data, token);
    print("info from addToFav function ${jsonDecode(result.body)}");
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('wishlist_id', response['wishlist']['id']);
      await preferences.setInt('user_id', response['wishlist']['user_id']);
      await preferences.setInt(
          'product_id', response['wishlist']['product_id']);
      notifyListeners();
    } else {
      print(response["message"]);
    }
  }

  List<Map<String, dynamic>> wishlists = [];

  void getWishlist(String? token) async {
    final result = await API().getRequest('/wishlist', token!);
    print('all wishlist ${jsonDecode(result.body)}');
    final response = jsonDecode(result.body);
    try {
      if (response['status'] == 200) {
        wishlists = List<Map<String, dynamic>>.from(response['wishlists']);
        print(jsonDecode(result.body));

        // print('all productssssss ${jsonDecode(result.body)}');
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt('id', response['wishlists']['id']);
        await preferences.setInt('user_id', response['wishlists']['user_id']);
        await preferences.setInt(
            'product_id', response['wishlists']['product_id']);
        // await preferences.setInt(
        //     'category_id', response['products']['category_id']);
        // await preferences.setString('name', response['products']['name']);
        // await preferences.setString(
        //     'description', response['products']['description']);
        // await preferences.setDouble('price', response['products']['price']);
        // await preferences.setString('image', response['products']['image']);
        // await preferences.setInt('stock', response['products']['stock']);
        notifyListeners();
      } else {
        print(response["message"]);
      }
    } catch (error) {
      print('errors: $error');
    }
  }
}
