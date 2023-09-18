// ignore_for_file: avoid_print

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_flutter_laravel/providers/address_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_textfield.dart';

class AddressFormScreen extends StatelessWidget {
  AddressFormScreen({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 1.0,
          title: Text(
            AppLocale.of(context).translate('addAddress')!,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: Provider.of<ThemeProvider>(context).linearGradient),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: Provider.of<ThemeProvider>(context).linearGradient),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Provider.of<ThemeProvider>(context).backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.14),
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: CustomTextFormField(
                              controllerField: firstNameController,
                              prefixIcon: const Icon(Icons.person_2_outlined),
                              hintText:
                                  AppLocale.of(context).translate('firstName')!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocale.of(context)
                                      .translate('firstNameValidator')!;
                                }
                                return null;
                              },
                              contentPadding:
                                  const EdgeInsets.only(left: 10, top: 15),
                              errorStyle: const TextStyle(
                                height: 0.5,
                              ),
                              keyboardType: TextInputType.name,
                              onChange: (String name) {
                                print(name);
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: MediaQuery.of(context).size.height / 13,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.14),
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: CustomTextFormField(
                              controllerField: lastNameController,
                              prefixIcon: const Icon(Icons.person_2_outlined),
                              hintText:
                                  AppLocale.of(context).translate('lastName')!,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocale.of(context)
                                      .translate('lastNameValidator')!;
                                }
                                return null;
                              },
                              contentPadding:
                                  const EdgeInsets.only(left: 10, top: 15),
                              errorStyle: const TextStyle(
                                height: 0.5,
                              ),
                              keyboardType: TextInputType.name,
                              onChange: (String name) {
                                print(name);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: addressLine1Controller,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          hintText:
                              AppLocale.of(context).translate('addressLine1')!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocale.of(context)
                                  .translate('addressLine1Validator')!;
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.streetAddress,
                          onChange: (String address) {
                            print(address);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: addressLine2Controller,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          hintText:
                              AppLocale.of(context).translate('addressLine2')!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocale.of(context)
                                  .translate('addressLine2Validator')!;
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.streetAddress,
                          onChange: (String address) {
                            print(address);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: cityController,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          hintText: AppLocale.of(context).translate('city')!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocale.of(context)
                                  .translate('cityValidator')!;
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.name,
                          onChange: (String city) {
                            print(city);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: stateController,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          hintText: AppLocale.of(context).translate('state')!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocale.of(context)
                                  .translate('stateValidator')!;
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.name,
                          onChange: (String state) {
                            print(state);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: zipCodeController,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          hintText: AppLocale.of(context).translate('zipCode')!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocale.of(context)
                                  .translate('zipCodeValidator')!;
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.name,
                          onChange: (String zipCode) {
                            print(zipCode);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: MediaQuery.of(context).size.height / 13,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.14),
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CustomTextFormField(
                          controllerField: countryController,
                          prefixIcon: const Icon(Icons.home_work_outlined),
                          hintText: AppLocale.of(context).translate('country')!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocale.of(context)
                                  .translate('countryValidator')!;
                            }
                            return null;
                          },
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          errorStyle: const TextStyle(
                            height: 0.5,
                          ),
                          keyboardType: TextInputType.name,
                          onChange: (String country) {
                            print(country);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              gradient: Provider.of<ThemeProvider>(context)
                                  .linearGradient),
                          child: TextButton(
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              int? userId = preferences.getInt('user_id');
                              String? token = preferences.getString('token');

                              if (formKey.currentState!.validate()) {
                                addressProvider
                                    .createShippingAddress(
                                        userId!,
                                        firstNameController.text,
                                        lastNameController.text,
                                        addressLine1Controller.text,
                                        addressLine2Controller.text,
                                        cityController.text,
                                        stateController.text,
                                        zipCodeController.text,
                                        countryController.text,
                                        token!)
                                    .then((_) => Navigator.of(context).pop());
                              }
                            },
                            child: Text(
                              AppLocale.of(context).translate('addButton')!,
                              style: const TextStyle(
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

                  // ListView.builder(
                  //   itemCount: 2,
                  //   itemBuilder: itemBuilder
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
