// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Wishlist extends ChangeNotifier {
  void addToFav(Map<String, dynamic> data, String token) async {
    final result = await API().postRequestToken('/wishlist', data, token);
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

  void deleteWishlist(String? token, int id) async {
    final result = await API().deleteRequest('/wishlist', token!, id);
    print('all wishlist ${jsonDecode(result.body)}');
    final response = jsonDecode(result.body);
    try {
      if (response['status'] == 200) {
        print(response["message"]);
      } else {
        print(" error ${response["message"]}");
      }
    } catch (error) {
      print('errors: $error');
    }
  }

  final List<int> _favoriteItems = [];

  List<int> get favoriteItems => _favoriteItems;

  bool isFavorite(int productId) {
    return _favoriteItems.contains(productId);
  }

// final result = await API().getRequest('/wishlist', token!);
//     print('all wishlist ${jsonDecode(result.body)}');
//     final response = jsonDecode(result.body);
  // void toggleFavorite(int productId, int userId) async {
  //   if (_favoriteItems.contains(productId)) {
  //     _favoriteItems.remove(productId);
  //   } else {
  //     _favoriteItems.add(productId);
  //   }
  //   notifyListeners();
  //   print(_favoriteItems);
  //   var url = Uri.parse('http://192.168.137.1:8000/api/v1/wishlisttoggle');
  //   var response = await http.post(url, body: {
  //     'user_id': userId.toString(),
  //     'product_id': productId.toString(),
  //   });

  //   if (response.statusCode == 200) {
  //     print('Successfully updated favorite status');
  //   } else {
  //     throw Exception('Failed to update favorite status');
  //   }
  // }
  void toggleFavorite(int productId, int userId, String token) async {
    if (_favoriteItems.contains(productId)) {
      _favoriteItems.remove(productId);
    } else {
      _favoriteItems.add(productId);
    }
    notifyListeners();
    print(_favoriteItems);

    var data = {
      'user_id': userId.toString(),
      'product_id': productId.toString(),
    };

    try {
      var response = await postRequestToken('/wishlisttoggle', data, token);

      if (response.statusCode == 200) {
        print('Successfully updated favorite status');
      } else {
        throw Exception('Failed to update favorite status');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<http.Response> postRequestToken(
      String route, Map<String, dynamic> data, String token) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }
}
