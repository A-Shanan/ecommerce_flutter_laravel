// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/address_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'address_form_Screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool isLoading = false;
  void getaddressData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    Provider.of<AddressProvider>(context, listen: false)
        .getAllAddresses(token!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getaddressData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 1.0,
          title: Text(
            AppLocale.of(context).translate('myAddresses')!,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: Provider.of<ThemeProvider>(context).linearGradient),
          ),
        ),
      ),
      body: Container(
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
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocale.of(context).translate('myAddresses')!,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddressFormScreen()));
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_sharp,
                              size: 30,
                              color: Color(0xffFFB100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color:
                            Provider.of<ThemeProvider>(context).backgroundColor,
                      ),
                      child: Consumer<AddressProvider>(
                          builder: (context, provider, child) {
                        if (provider.shippingAddressItems.isEmpty) {
                          return Center(
                              child: Text(
                            AppLocale.of(context).translate('noAddress')!,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ));
                        } else if (provider.shippingAddressItems.isNotEmpty) {
                          return ListView.builder(
                            itemCount: provider.shippingAddressItems.length,
                            itemBuilder: (context, index) {
                              final shippingaddress =
                                  provider.shippingAddressItems[index];
                              return ExpansionTile(
                                title: Text(
                                    "${shippingaddress.firstName.toString()} ${shippingaddress.lastName.toString()}"),
                                trailing: IconButton(
                                  onPressed: () {
                                    editDialog(context, shippingaddress);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                children: [
                                  Text(
                                      "${shippingaddress.addressLine1.toString()}, ${shippingaddress.addressLine2.toString()}, ${shippingaddress.city.toString()}, ${shippingaddress.state.toString()}, ${shippingaddress.city.toString()}, ${shippingaddress.zipCode.toString()}, ${shippingaddress.country.toString()}")
                                ],
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: Text('No Address Availabe.'));
                        }
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editDialog(
      BuildContext context, ShippingAddressItem address) async {
    final TextEditingController firstNameController =
        TextEditingController(text: address.firstName);
    final TextEditingController lastNameController =
        TextEditingController(text: address.lastName);
    final TextEditingController addressLine1Controller =
        TextEditingController(text: address.addressLine1);
    final TextEditingController addressLine2Controller =
        TextEditingController(text: address.addressLine2);
    final TextEditingController cityController =
        TextEditingController(text: address.city);
    final TextEditingController stateController =
        TextEditingController(text: address.state);
    final TextEditingController zipCodeController =
        TextEditingController(text: address.zipCode);
    final TextEditingController countryController =
        TextEditingController(text: address.country);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            AlertDialog(
              title: Text(
                AppLocale.of(context).translate('editAddress')!,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocale.of(context).translate('firstName')!,
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: AppLocale.of(context).translate('lastName')!,
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      controller: addressLine1Controller,
                      decoration: InputDecoration(
                        labelText:
                            AppLocale.of(context).translate('addressLine1')!,
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      controller: addressLine2Controller,
                      decoration: InputDecoration(
                        labelText:
                            AppLocale.of(context).translate('addressLine2')!,
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        labelText: AppLocale.of(context).translate('city')!,
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(
                        labelText: AppLocale.of(context).translate('state')!,
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      controller: zipCodeController,
                      decoration: InputDecoration(
                        labelText: AppLocale.of(context).translate('zipCode')!,
                      ),
                      onChanged: (value) {},
                    ),
                    TextFormField(
                      controller: countryController,
                      decoration: InputDecoration(
                        labelText: AppLocale.of(context).translate('country')!,
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    AppLocale.of(context).translate('cancelButton')!,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    AppLocale.of(context).translate('saveButton')!,
                  ),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();

                    String? token = preferences.getString('token');
                    Provider.of<AddressProvider>(context, listen: false)
                        .updateShippingAddress(
                      address.id,
                      address.userId,
                      firstNameController.text,
                      lastNameController.text,
                      addressLine1Controller.text,
                      addressLine2Controller.text,
                      cityController.text,
                      stateController.text,
                      zipCodeController.text,
                      countryController.text,
                      token!,
                      // Pass the updated fields here...
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
