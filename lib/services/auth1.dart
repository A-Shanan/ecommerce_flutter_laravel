// // ignore_for_file: avoid_print, library_prefixes, use_build_context_synchronously

// import 'dart:convert';

// import 'package:dio/dio.dart' as Dio;
// import 'package:ecommerce_flutter_laravel/screens/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// import 'package:ecommerce_flutter_laravel/models/user_model.dart';
// import 'package:ecommerce_flutter_laravel/services/dio.dart';
// import 'package:ecommerce_flutter_laravel/services/http.dart';

// import '../screens/home_screen.dart';

// class Auth extends ChangeNotifier {
//   bool isLoggedIn = false;
//   // User? user;
//   // String? token;

//   bool get authenticated => isLoggedIn;
//   // User? get users => user;

//   String? token;
//   Map<String, dynamic>? user;

//   String? get token_ => token;
//   Map<String, dynamic>? get user_ => user;

//   void setToken(String? token) {
//     token = token;
//     notifyListeners();
//   }

//   void setUser(Map<String, dynamic>? user) {
//     user = user;
//     notifyListeners();
//   }

//   Future<void> login1(
//       String email, String password, BuildContext context) async {
//     final response = await http.post(
//       Uri.parse('http://192.168.137.1:8000/api/v1/login'),
//       body: {
//         'email': email,
//         'password': password,
//       },
//     );

//     if (response.statusCode == 200) {
//       try {
//         final data = jsonDecode(response.body);
//         final token = data['token'];
//         final user = data['user'];

//         if (token.isNotEmpty && user.isNotEmpty) {
//           // Save token and user data in your state management provider
//           setToken(token);
//           setUser(user as Map<String, dynamic>?);

//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomeScreen()),
//           );
//         } else {
//           print("Token or user data is missing in the response.");
//         }
//       } catch (e) {
//         print("Error decoding JSON response: $e");
//       }
//     } else {
//       final errorMessage = json.decode(response.body)['message'];
//       print(errorMessage);
//     }
//   }

//   final storage = FlutterSecureStorage();

//   // void login(Map creds, BuildContext context) async {
//   //   try {
//   //     Dio.Response response = await dio().post('/login', data: creds);
//   //     print("token: ${response.data.toString()}");

//   //     String token = response.data.toString();
//   //     tryToken(token);
//   //     Navigator.pushReplacement(
//   //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//   //   } catch (e) {
//   //     print("error: $e");
//   //   }
//   // }

//   void login(Map<String, dynamic> creds, BuildContext context) async {
//     try {
//       http.Response response = await http.post(
//         Uri.parse('http://192.168.137.1:8000/api/v1/login'),
//         body: creds,
//       );

//       if (response.statusCode == 200) {
//         print("token info: ${response.body}");

//         String token = response.body;
//         tryToken(token);
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => HomeScreen()));
//       } else {
//         print("Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("error: $e");
//     }
//   }

//   void tryToken(String token) async {
//     if (token.isEmpty) {
//       print('an error occured');
//     } else {
//       try {
//         http.Response response = await http.get(
//           Uri.parse('/user'),
//           headers: {"Authorization": "Bearer $token"},
//         );

//         if (response.statusCode == 200) {
//           isLoggedIn = true;
//           user = User.fromJson(json.decode(response.body))
//               as Map<String, dynamic>?;
//           storeToken(token: token);
//           notifyListeners();
//           print("User info: $user");
//         } else {
//           print("Error: ${response.statusCode}");
//         }
//       } catch (e) {
//         print("error in tryToken function ${e.toString()}");
//       }
//     }
//   }

//   // void register(
//   //     String name, String email, String password, BuildContext context) async {
//   //   try {
//   //     http.Response response = await http.post(
//   //       Uri.parse('http://192.168.137.1:8000/api/v1/register'),
//   //       body: jsonEncode(<String, dynamic>{
//   //         'name': name,
//   //         'email': email,
//   //         'password': password,
//   //       }),
//   //     );
//   //     if (response.statusCode == 200) {
//   //       print("user created: ${response.body}");
//   //       notifyListeners();
//   //       Navigator.pushReplacement(
//   //           context, MaterialPageRoute(builder: (context) => LoginScreen()));
//   //     } else {
//   //       print("Error: ${response.statusCode}");
//   //     }
//   //   } catch (e) {
//   //     print("error: $e");
//   //   }
//   // }

//   void register(
//       String name, String email, String password, BuildContext context) async {
//     try {
//       http.Client client = http.Client();

//       final response = await client.send(http.Request(
//           'POST', Uri.parse('http://192.168.137.1:8000/api/v1/register'))
//         ..headers['content-type'] = 'application/json'
//         ..headers['accept'] = 'application/json'
//         ..body = jsonEncode(<String, dynamic>{
//           'name': name,
//           'email': email,
//           'password': password,
//         }));

//       if (response.statusCode == 302) {
//         final newUrl = response.headers['location'];
//         final newResponse =
//             await client.send(http.Request('GET', Uri.parse(newUrl!)));
//         if (newResponse.statusCode == 200) {
//           final responseBody = await newResponse.stream.bytesToString();
//           print("User created: $responseBody");
//           notifyListeners();
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => LoginScreen()));
//         } else {
//           print("Error: ${newResponse.statusCode}");
//         }
//       } else if (response.statusCode == 200) {
//         final responseBody = await response.stream.bytesToString();
//         print("User created: $responseBody");
//         notifyListeners();
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => LoginScreen()));
//       } else {
//         print("Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   void storeToken({required String token}) {
//     storage.write(key: 'token', value: token);
//   }

//   void logout(BuildContext context) async {
//     isLoggedIn = false;
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginScreen()));
//     notifyListeners();
//   }
// }
