// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:flutter/material.dart';

class ShippingAddressItem {
  final int id;
  final int userId;
  final String firstName;
  final String lastName;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  ShippingAddressItem({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });
  factory ShippingAddressItem.fromJson(Map<String, dynamic> json) {
    return ShippingAddressItem(
      id: json['id'],
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      country: json['country'],
    );
  }
}

class AddressProvider with ChangeNotifier {
  final List<ShippingAddressItem> shippingAddressItems = [];
  List<ShippingAddressItem> get shippingAddressItemGetter =>
      shippingAddressItems;
  set shippingAddressItemSetter(List<ShippingAddressItem> newValue) {
    shippingAddressItems.clear();
    shippingAddressItems.addAll(newValue);
  }

  createShippingAddress(
      int userId,
      String firstName,
      String lastName,
      String addressLine1,
      String addressLine2,
      String city,
      String state,
      String zipCode,
      String country,
      String token) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "first_name": firstName,
      "last_name": lastName,
      "address_line_1": addressLine1,
      "address_line_2": addressLine2,
      "city": city,
      "state": state,
      "zip_code": zipCode,
      "country": country,
    };
    final result =
        await API().postRequestToken('/shippingAddress', data, token);
    print('shipping address added: ${jsonDecode(result.body)}');
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      print("shipping address: $response");
      notifyListeners();
    }
  }

  getAllAddresses(String token) async {
    final result = await API().getRequest("/shippingAddress", token);
    print("All Addresses: ${jsonDecode((result.body))}");
    final response = jsonDecode(result.body);
    try {
      if (response["status"] == 200) {
        shippingAddressItemSetter = List<ShippingAddressItem>.from(
          response['shippingAddresses'].map(
            (item) => ShippingAddressItem.fromJson(item),
          ),
        );
        notifyListeners();
        print('all addressessssss ${jsonDecode(result.body)}');
      } else {
        print(response["message"]);
      }
    } catch (error) {
      print('errors from function getAllAddresses in AddressProvider: $error');
    }
  }

  updateShippingAddress(
      int id,
      int userId,
      String firstName,
      String lastName,
      String addressLine1,
      String addressLine2,
      String city,
      String state,
      String zipCode,
      String country,
      String token) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "first_name": firstName,
      "last_name": lastName,
      "address_line_1": addressLine1,
      "address_line_2": addressLine2,
      "city": city,
      "state": state,
      "zip_code": zipCode,
      "country": country,
    };

    final result = await API().putRequest('/shippingAddress', token, id, data);
    print('shipping address updated: ${jsonDecode(result.body)}');
    final response = jsonDecode(result.body);

    if (response['status'] == 200) {
      print("shipping address: $response");
      notifyListeners();
    }
  }
}
