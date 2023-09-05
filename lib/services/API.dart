import 'package:http/http.dart' as http;

import 'dart:convert';

class API {
  postRequest(String route, Map<String, dynamic> data) async {
    String url = "http://192.168.137.1:8000/api/v1$route";
    return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
  }
}
