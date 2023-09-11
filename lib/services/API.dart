import 'dart:io';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

class API {
  postRequest(String route, Map<String, dynamic> data) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
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

  // postRequest2(
  //     String route, List<Map<String, dynamic>> data, String token) async {
  //   String url = "http://192.168.137.1:8000/api/v1$route";
  //   return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
  //     "Authorization": "Bearer $token",
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json'
  //   });
  // }

  getRequest(String route, String token) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }

  deleteRequest(String route, String token, int id) async {
    String url = "http://192.168.137.1:8000/api/v1$route/$id";
    return await http.delete(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }
}
