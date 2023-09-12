// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order {
  final int userId;
  final double total;

  Order({
    required this.userId,
    required this.total,
  });
}

class OrderProvider with ChangeNotifier {
  List<Order> orders = [];
  List<Order> get ordersGetter => orders;

  void addToOrders(int userId, double total, String token) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "total": total,
    };
    final result = await API().postRequestToken('/order', data, token);
    print("orders added ${jsonDecode(result.body)}");
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('orderId', response['order']['id']);
      await preferences.setInt('user_id', response['order']['user_id']);
      await preferences.setDouble('total', response['order']['total']);
      notifyListeners();
    } else {
      print(response["message"]);
    }
  }
}
