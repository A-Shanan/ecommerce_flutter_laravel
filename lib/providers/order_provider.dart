// ignore_for_file: avoid_print, dead_code

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Order {
  final int id;
  final int userId;
  final String total;

  Order({
    required this.id,
    required this.userId,
    required this.total,
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(id: json['id'], userId: json['user_id'], total: json['total']);
  }
}

class OrderDetail {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final String price;
  final String productImageUrl;
  final String productName;

  OrderDetail({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.productImageUrl,
    required this.productName,
  });
  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      productImageUrl: json['product']['image'],
      productName: json['product']['name'],
    );
  }
}

class OrderProvider with ChangeNotifier {
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
      throw Exception('Failed to create order');
    }

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

  List<Order> orders = [];
  List<Order> get ordersGetter => orders;
  set ordersSetter(List<Order> newValue) {
    orders.clear();
    orders.addAll(newValue);
  }

  List<OrderDetail> orderDetails = [];
  List<OrderDetail> get orderDetailsGetter => orderDetails;
  set orderDetailsSetter(List<OrderDetail> newValue) {
    orderDetails.clear();
    orderDetails.addAll(newValue);
  }

  Future<void> fetchOrdersAndDetails(String token) async {
    final result = await API().getRequest('/order', token);
    print("All orders: ${jsonDecode((result.body))}");
    final response = jsonDecode(result.body);
    try {
      if (response['status'] == 200) {
        ordersSetter = List<Order>.from(
          response['orders'].map(
            (item) => Order.fromJson(item),
          ),
        );
        notifyListeners();
      } else {
        print("res message ${response["message"]}");
      }
    } catch (error) {
      print(
          "errors from function fetchOrdersAndDetails Order in AddressProvider:$error");
    }

    final resultD = await API().getRequest('/orderDetails', token);
    print("All orders details: ${jsonDecode((result.body))}");
    final responsed = jsonDecode(resultD.body);
    try {
      if (responsed['status'] == 200) {
        orderDetailsSetter = List<OrderDetail>.from(
          responsed['orderDetails'].map(
            (item) => OrderDetail.fromJson(item),
          ),
        );
        notifyListeners();
      } else {
        print(responsed["message"]);
      }
    } catch (error) {
      print(
          "errors from function fetchOrdersAndDetails OrderDetails in AddressProvider:$error");
    }

    notifyListeners();
  }
}
