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

  Future<Map<String, dynamic>?> createOrder(
      double total, int userId, String token) async {
    Map<String, dynamic> data = {"user_id": userId, "total": total};

    final response = await API().postRequestToken('/order', data, token);
    if (response.statusCode == 200) {
      // Parse the response body and return it as a map
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // Handle error cases here if needed
      throw Exception('Failed to create order');
    }
    // final response = await yourApiService.postOrder(
    //     total, userId); // Implement your API service
    return response;
  }

  Future<void> createOrderDetails(int orderId, int productId, int quantity,
      double price, String token) async {
    Map<String, dynamic> data = {
      "order_id": orderId,
      "product_id": productId,
      "quantity": quantity,
      "price": price,
    };
    final response = await API().postRequestToken('/orderDetails', data, token);
    return response;
  }
}
