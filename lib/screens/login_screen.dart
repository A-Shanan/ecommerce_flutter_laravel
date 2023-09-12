// ignore_for_file: avoid_print, non_constant_identifier_names, use_build_context_synchronously, unused_import

import 'dart:convert';

import 'package:ecommerce_flutter_laravel/screens/home_screen.dart';
import 'package:ecommerce_flutter_laravel/screens/registeration_screen.dart';
import 'package:ecommerce_flutter_laravel/services/auth.dart';
import 'package:ecommerce_flutter_laravel/services/auth1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import '../services/API.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPassword = true;

  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    CustomPaint(
                      size:
                          Size(100000.0, (330 * 0.7888040712468194).toDouble()),
                      painter: RPSCustomPainter(),
                    ),
                    const Positioned(
                      top: 70.0,
                      left: 30.0,
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 26.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account",
                      style: TextStyle(
                          color: Color(0xff9E9E9E),
                          fontFamily: 'Poppins',
                          fontSize: 16.0),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegisterationScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Color(0xffF19C23),
                            fontFamily: 'Poppins',
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        width: 350,
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: emailController,
                          prefixIcon: const Icon(Icons.email_outlined),
                          hintText: 'Enter Email Address',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Invalid email';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChange: (String email) {
                            print(email);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                            controllerField: passwordController,
                            prefixIcon: const Icon(Icons.lock_outlined),
                            hintText: 'Enter Password',
                            suffixIcon: IconButton(
                              icon: Icon(isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password must NOT be empty';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                            contentPadding:
                                const EdgeInsets.only(left: 10, top: 15),
                            errorStyle: const TextStyle(
                              height: 0.5,
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: isPassword,
                            onChange: (String password) => print(password)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => RegisterationScreen()),
                              //     (route) => false);
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                  color: Color(0xffF19C23),
                                  fontFamily: 'Poppins',
                                  fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: <Color>[
                                Color(0xffFFB100),
                                Color(0xffEEAE1C),
                                Color(0xffF5A64F),
                              ],
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Map<String, dynamic> creds = {
                                "email": emailController.text,
                                "password": passwordController.text,
                                "device_name": emailController.text,
                              };
                              if (formKey.currentState!.validate()) {
                                // logg();
                                Provider.of<Auth>(context, listen: false)
                                    .login(creds, context);

                                // print(creds);
                                // Provider.of<Auth>(context, listen: false)
                                //     .login1(emailController.text,
                                //         passwordController.text, context);
                              }
                              // else if (formKey.currentState!.validate() ==
                              //     false) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //           content: Text("Invalid Credentials")));
                              // }
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 26.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logg() async {
    // try {
    //   var url = Uri.parse('http://192.168.137.1:8000/api/v1/');
    //   var response = await http.post(
    //     url,
    //     headers: {
    //       'Content-type': "application/json",
    //       'Accept': 'application/json'
    //     },
    //     body: jsonEncode(
    //       {
    //         'name': nameController.text.toString(),
    //         'email': emailController.text.toLowerCase().toString(),
    //         'password': passwordController.text.toString(),
    //       },
    //     ),
    //   );
    //   if (response.statusCode == 200) {
    //     print(jsonDecode(response.body));
    //   } else {
    //     print('error: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   print("errorrrrrrrr: $e");
    // }

    // postRequest(String route, Map<String, dynamic> data) async {
    //     String url = "http://192.168.137.1:8000/api/v1$route";
    //     return await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json'
    //     });
    //   }

    // header() =>
    //     {'Content-type': 'application/json', 'Accept': 'application/json'};

    final data = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
    };
    final result = await API().postRequest('/loginn', data);
    print("heyyyy ${jsonDecode(result.body)}");
    final response = jsonDecode(result.body);
    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['user']['id']);
      await preferences.setString('name', response['user']['name']);
      await preferences.setString('email', response['user']['email']);
      await preferences.setString('token', response['token']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      print(response.statusCode);
      print(response["message"]);
    }
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.6356097);
    path_0.lineTo(size.width, size.height * 0.6356097);
    path_0.cubicTo(
        size.width * 0.9746718,
        size.height * 0.9052645,
        size.width * 0.7278219,
        size.height * 1.037974,
        size.width * 0.5573130,
        size.height * 0.8736032);
    path_0.lineTo(size.width * 0.4249313, size.height * 0.7459871);
    path_0.cubicTo(
        size.width * 0.3506514,
        size.height * 0.6743806,
        size.width * 0.2599059,
        size.height * 0.6356097,
        size.width * 0.1665901,
        size.height * 0.6356097);
    path_0.lineTo(0, size.height * 0.6356097);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 1.996542e-7, size.height * 0.3202884),
        Offset(size.width * 1.001977, size.height * 0.3685806), [
      const Color(0xffFFB100).withOpacity(1),
      const Color(0xffEEAE1C).withOpacity(1),
    ], [
      0,
      1
    ]);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9520356, size.height * 1.135655);
    path_1.cubicTo(
        size.width * 0.8726132,
        size.height * 1.132961,
        size.width * 0.8027837,
        size.height * 1.089003,
        size.width * 0.7587328,
        size.height * 1.022810);
    path_1.cubicTo(
        size.width * 0.7238804,
        size.height * 1.053035,
        size.width * 0.6796692,
        size.height * 1.070397,
        size.width * 0.6319033,
        size.height * 1.068777);
    path_1.cubicTo(
        size.width * 0.5757888,
        size.height * 1.066874,
        size.width * 0.5256794,
        size.height * 1.039139,
        size.width * 0.4905522,
        size.height * 0.9961226);
    path_1.cubicTo(
        size.width * 0.4620305,
        size.height * 1.018006,
        size.width * 0.4271756,
        size.height * 1.030316,
        size.width * 0.3897761,
        size.height * 1.029048);
    path_1.cubicTo(
        size.width * 0.2961120,
        size.height * 1.025868,
        size.width * 0.2219646,
        size.height * 0.9387258,
        size.width * 0.2241669,
        size.height * 0.8344097);
    path_1.cubicTo(
        size.width * 0.2263695,
        size.height * 0.7300935,
        size.width * 0.3040865,
        size.height * 0.6481032,
        size.width * 0.3977532,
        size.height * 0.6512806);
    path_1.cubicTo(
        size.width * 0.4351527,
        size.height * 0.6525516,
        size.width * 0.4694402,
        size.height * 0.6672065,
        size.width * 0.4970000,
        size.height * 0.6909968);
    path_1.cubicTo(
        size.width * 0.5338906,
        size.height * 0.6504290,
        size.width * 0.5850967,
        size.height * 0.6261323,
        size.width * 0.6412087,
        size.height * 0.6280387);
    path_1.cubicTo(
        size.width * 0.6889746,
        size.height * 0.6296581,
        size.width * 0.7323893,
        size.height * 0.6499935,
        size.width * 0.7659135,
        size.height * 0.6825387);
    path_1.cubicTo(
        size.width * 0.8126972,
        size.height * 0.6194258,
        size.width * 0.8842824,
        size.height * 0.5802645,
        size.width * 0.9637048,
        size.height * 0.5829613);
    path_1.cubicTo(
        size.width * 1.100746,
        size.height * 0.5876129,
        size.width * 1.209226,
        size.height * 0.7151065,
        size.width * 1.206003,
        size.height * 0.8677290);
    path_1.cubicTo(
        size.width * 1.202781,
        size.height * 1.020352,
        size.width * 1.089076,
        size.height * 1.140306,
        size.width * 0.9520356,
        size.height * 1.135655);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Colors.white.withOpacity(0.1);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
