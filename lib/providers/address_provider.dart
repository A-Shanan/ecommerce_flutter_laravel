// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:flutter/material.dart';

class ShippingAddressItem {
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
}

class AddressProvider with ChangeNotifier {
  final List<ShippingAddressItem> shippingAddressItems = [];
  List<ShippingAddressItem> get shippingAddressItemGetter =>
      shippingAddressItems;

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
      // for(var shipaddres in shippingAddressItems){
      //   //            print("ship add id is :${shipaddres.id}");
      //   //              print("new ship add id is:${response["data"]["id"]}");
      //   //                if (shipaddres.id == response["data"]["id"]){

      // }
      notifyListeners();
    }
  }
}
