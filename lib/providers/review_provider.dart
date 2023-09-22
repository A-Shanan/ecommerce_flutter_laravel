// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:flutter/material.dart';

class ReviewProduct {
  final int id;
  final int userId;
  final int productId;
  final String review;
  final String userName;
  final int rating;

  ReviewProduct({
    required this.id,
    required this.userId,
    required this.productId,
    required this.review,
    required this.userName,
    required this.rating,
  });
  factory ReviewProduct.fromJson(Map<String, dynamic> json) {
    return ReviewProduct(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      review: json['review'],
      userName: json['user']['name'],
      rating: json['rating'],
    );
  }
}

class ReviewProvider with ChangeNotifier {
  createReviewAndRate(int userId, int productId, String review, int rating,
      String token) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "product_id": productId,
      "review": review,
      "rating": rating,
    };
    final result = await API().postRequestToken('/productreview', data, token);
    print('Review add : ${jsonDecode(result.body)}');
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      notifyListeners();
      print('Review added : ${jsonDecode(result.body)}');
    }
  }

  final List<ReviewProduct> reviewProductItems = [];
  List<ReviewProduct> get reviewProductItemGetter => reviewProductItems;
  set reviewProductItemSetter(List<ReviewProduct> newValue) {
    reviewProductItems.clear();
    reviewProductItems.addAll(newValue);
  }

  getAllReviews(int productId) async {
    final result =
        await API().getRequestWithoutToken("/productreview/$productId");
    print("All Reviews: ${jsonDecode((result.body))}");
    final response = jsonDecode(result.body);
    try {
      if (response["status"] == 200) {
        reviewProductItemSetter = List<ReviewProduct>.from(
          response['reviews'].map(
            (item) => ReviewProduct.fromJson(item),
          ),
        );
        print('all Reviewssss ${jsonDecode(result.body)}');
        notifyListeners();
      } else {
        print(response["message"]);
      }
    } catch (error) {
      notifyListeners();

      print('errors from function getAllReviews in AddressProvider: $error');
    }
  }
}
