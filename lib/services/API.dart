// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_flutter_laravel/providers/review_provider.dart';

SharedPreferences? preferences;

class API {
  postRequest(String route, Map<String, dynamic> data) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }

  postRequestL(String route, String token) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.post(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }

  postRequestToken(
      String route, Map<String, dynamic> data, String token) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }

  getRequest(String route, String token) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }

  getRequestWithoutToken(String route) async {
    preferences = await SharedPreferences.getInstance();
    String? token = preferences!.getString('token');
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }

  Future<List<ReviewProduct>> getReviewsForProduct(int productId) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    final url =
        "http://192.168.137.1:8000/api/v1/productreview?productId=$productId";

    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<ReviewProduct> reviews = responseData
          .map((reviewData) => ReviewProduct.fromJson(reviewData))
          .toList();
      return reviews;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  deleteRequest(String route, String token, int id) async {
    String url = "http://192.168.137.1:8000/api/v1$route/$id";
    return await http.delete(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }

  putRequest(
      String route, String token, int id, Map<String, dynamic> data) async {
    String url = "http://192.168.137.1:8000/api/v1$route/$id";
    return await http.put(Uri.parse(url), body: jsonEncode(data), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }
}
