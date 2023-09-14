// ignore_for_file: avoid_print

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
          title: const Text(
            'Add Addresses',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Color(0xffFFB100),
                  Color(0xffEEAE1C),
                  Color(0xffF5A64F),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Color(0xffFFB100),
                Color(0xffEEAE1C),
                Color(0xffF5A64F),
              ],
            ),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Color(0xffF5F5F5),
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
                              hintText: 'First Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'First Name must NOT be empty';
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
                              hintText: 'Last Name',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Last Name must NOT be empty';
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
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'Address Line 1',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Address line 1 must NOT be empty';
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
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'Address Line 2',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Address line 2 must NOT be empty';
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
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'City',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'City must NOT be empty';
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
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'state',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'state must NOT be empty';
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
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'Zip Code',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Zip Code must NOT be empty';
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
                          prefixIcon: const Icon(Icons.person_2_outlined),
                          hintText: 'country',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'country must NOT be empty';
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
