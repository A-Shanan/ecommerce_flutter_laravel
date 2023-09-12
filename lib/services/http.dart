// ignore_for_file: avoid_print, prefer_const_declarations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String baseUrl = 'http://192.168.1.36:8000/api/v1';

Future login(Map<dynamic, dynamic> creds, BuildContext context) async {
  try {
    var url = Uri.parse('http://192.168.1.36:8000/api/v1');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(creds));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print("Response for Managers: $data");
      return data;
    } else {
      print('error: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print("error: $e");
  }
}

Future<List<dynamic>> fetchDataForManagers(Map<dynamic, dynamic> creds) async {
  var url = Uri.parse('http://192.168.1.33:8000/api/sanctum/token');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(creds));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print("Response for Managers: $data");
    return data;
  } else {
    print('error: ${response.statusCode}');
    return [];
  }
}

Future<List<dynamic>> fetchDataForEmployees() async {
  var url = Uri.parse('http://10.0.2.2:8000/api/v1/employees');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print("Response for Employeess: $data");
    return data;
  } else {
    print('error: ${response.statusCode}');
    return [];
  }
}
