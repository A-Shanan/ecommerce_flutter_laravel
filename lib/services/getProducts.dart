// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetProducts extends ChangeNotifier {
  List<Map<String, dynamic>> products = [];
  getAllProduct(String? token) async {
    final result = await API().getRequest('/productsAll', token!);
    print('all products ${jsonDecode(result.body)}');
    final response = jsonDecode(result.body);
    try {
      if (response['status'] == 200) {
        products = List<Map<String, dynamic>>.from(response['products']);
        print('all productssssss ${jsonDecode(result.body)}');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt('id', response['products']['id']);
        await preferences.setInt(
            'category_id', response['products']['category_id']);
        await preferences.setString('name', response['products']['name']);
        await preferences.setString(
            'description', response['products']['description']);
        await preferences.setDouble('price', response['products']['price']);
        await preferences.setString('image', response['products']['image']);
        await preferences.setInt('stock', response['products']['stock']);
        notifyListeners();
      } else {
        print(response["message"]);
      }
    } catch (error) {
      print('errors: $error');
    }
  }
}
