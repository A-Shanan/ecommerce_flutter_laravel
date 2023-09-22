// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/services/API.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_textfield.dart';

import '../providers/theme_provider.dart';
import 'login_screen.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  CustomPaint(
                    size: Size(100000.0, (330 * 0.7888040712468194).toDouble()),
                    painter: RPSCustomPainter(),
                  ),
                  Positioned(
                    top: 70.0,
                    left: 30.0,
                    child: Text(
                      AppLocale.of(context).translate('signUp')!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                AppLocale.of(context).translate('createAccount')!,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: 26.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocale.of(context).translate('alreadyMem')!,
                    style: const TextStyle(
                        color: Color(0xff9E9E9E),
                        fontFamily: 'Poppins',
                        fontSize: 16.0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    },
                    child: Text(
                      AppLocale.of(context).translate('signIn')!,
                      style: const TextStyle(
                          color: Color(0xffF19C23),
                          fontFamily: 'Poppins',
                          fontSize: 16.0),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: nameController,
                          hintText:
                              AppLocale.of(context).translate('fullName')!,
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Invalid Name';
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChange: (String name) {
                            print(name);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: emailController,
                          hintText: AppLocale.of(context).translate('email')!,
                          prefixIcon: const Icon(Icons.email_outlined),
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
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                            controllerField: passwordController,
                            hintText:
                                AppLocale.of(context).translate('passowrd')!,
                            prefixIcon: const Icon(Icons.lock_outlined),
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
                              if (value!.isEmpty || value.length < 8) {
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: confirmPasswordController,
                          hintText:
                              AppLocale.of(context).translate('confPassowrd')!,
                          prefixIcon: const Icon(Icons.lock_outline),
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
                              return 'Confirm password must NOT be empty';
                            }
                            if (value != passwordController.text) {
                              return 'password did not match';
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          obscureText: isPassword,
                          keyboardType: TextInputType.text,
                          onChange: (confirmPassword) => print(confirmPassword),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            gradient: Provider.of<ThemeProvider>(context)
                                .linearGradient,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                signUp().then(
                                  (_) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                        (route) => false);
                                  },
                                );
                              }
                            },
                            child: Text(
                              AppLocale.of(context).translate('create')!,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final data = {
      'email': emailController.text.toString().toLowerCase(),
      'name': nameController.text.toString(),
      'password': passwordController.text.toString(),
    };
    final result = await API().postRequest('/registerr', data);
    print(jsonDecode(result.body));
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
