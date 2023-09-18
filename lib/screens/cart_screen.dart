// ignore_for_file: unused_import, unused_local_variable, prefer_const_constructors, avoid_print

import 'package:ecommerce_flutter_laravel/providers/address_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/done_screen.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppLocale.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    double totalPrice = cartProvider.calculateTotalPrice();
    int totalQuantity = cartProvider.calculateTotalQuantity();
    // Get the address provider
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    // Get the list of addresses
    final addresses = addressProvider.shippingAddressItems;
    ShippingAddressItem? selectedAddress;
    final TextEditingController cardNameController = TextEditingController();
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController cardDateController = TextEditingController();
    final TextEditingController CVVController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 1.0,
          title: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              AppLocale.of(context).translate('cart')!,
              style: TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
            ),
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
          height: 605.491,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Provider.of<ThemeProvider>(context).backgroundColor,
          ),
          child: ListView.builder(
            itemCount: cartProvider.cartItemsGetter.length,
            itemBuilder: (context, index) {
              final cartItem = cartProvider.cartItemsGetter[index];
              return ListTile(
                isThreeLine: true,
                leading: Image.network(cartItem.imageUrl),
                title: Text(cartItem.productName),
                subtitle: Text('\$${cartItem.price.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        cartProvider.decreaseQuantity(index);
                      },
                    ),
                    Text('${cartItem.quantity}'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cartProvider.increaseQuantity(index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(
            //     onPressed: () async {
            //       SharedPreferences preferences =
            //           await SharedPreferences.getInstance();
            //       int? id = preferences.getInt('orderId');
            //       double? total = preferences.getDouble('total');
            //       print(id);
            //     },
            //     icon: Icon(Icons.abc)),
            Text(
              '${AppLocale.of(context).translate('total')!}: \$${cartProvider.calculateTotalPrice().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                print(totalQuantity);
              },
              child: Text(
                'Quantity: ${cartProvider.calculateTotalQuantity().toStringAsFixed(0)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 20,
              // height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: Provider.of<ThemeProvider>(context).linearGradient,
              ),
              child: TextButton(
                onPressed: () async {
                  // SharedPreferences preferences =
                  //     await SharedPreferences.getInstance();
                  // int? userId = preferences.getInt('user_id');
                  // String? token = preferences.getString('token');

                  // orderProvider.addToOrders(userId!, totalPrice, token!);
                  showModalBottomSheet(
                      enableDrag: false,
                      useSafeArea: true,
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 2.0, left: 4.0, right: 4.0, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, top: 8.0, right: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.highlight_remove_sharp,
                                                size: 30,
                                                color: Color(0xffFFB100),
                                              ))
                                        ],
                                      ),
                                      Container(
                                          constraints: const BoxConstraints(
                                            maxHeight: 200.0,
                                          ),
                                          child: ListView.builder(
                                            itemCount: cartProvider
                                                    .cartItemsGetter.isEmpty
                                                ? 1 // Display one item for the empty state message
                                                : cartProvider
                                                    .cartItemsGetter.length,
                                            // Add 1 for the empty state
                                            itemBuilder: (context, index) {
                                              if (cartProvider
                                                  .cartItemsGetter.isEmpty) {
                                                // Display a message when the list is empty
                                                return Center(
                                                  child: Text(AppLocale.of(
                                                          context)
                                                      .translate('cartEmpty')!),
                                                );
                                              } else {
                                                // Display the list items when there are items in the list
                                                final cartItem = cartProvider
                                                    .cartItemsGetter[index];
                                                return ListTile(
                                                  isThreeLine: true,
                                                  leading: Image.network(
                                                      cartItem.imageUrl),
                                                  title: Text(
                                                      cartItem.productName),
                                                  subtitle: Text(
                                                      'Price: \$${cartItem.price.toStringAsFixed(2)}'),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        icon:
                                                            Icon(Icons.remove),
                                                        onPressed: () {
                                                          cartProvider
                                                              .decreaseQuantity(
                                                                  index - 1);
                                                        },
                                                      ),
                                                      Text(
                                                          '${cartItem.quantity}'),
                                                      IconButton(
                                                        icon: Icon(Icons.add),
                                                        onPressed: () {
                                                          cartProvider
                                                              .increaseQuantity(
                                                                  index - 1);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(AppLocale.of(context)
                                              .translate('myAddresses')!),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text(AppLocale
                                                                .of(context)
                                                            .translate(
                                                                'myAddresses')!),
                                                      );
                                                    });
                                              },
                                              icon: Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  color: Color(0xffFFB100)))
                                        ],
                                      ),
                                      Form(
                                        key: formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: DropdownButton<
                                                  ShippingAddressItem>(
                                                hint: Text(AppLocale.of(context)
                                                    .translate(
                                                        'chooseShippingAddress')!),
                                                value: selectedAddress,
                                                onChanged: (ShippingAddressItem?
                                                    newValue) {
                                                  setState(() {
                                                    selectedAddress = newValue;
                                                  });
                                                },
                                                items: addresses.map<
                                                        DropdownMenuItem<
                                                            ShippingAddressItem>>(
                                                    (ShippingAddressItem
                                                        address) {
                                                  return DropdownMenuItem<
                                                      ShippingAddressItem>(
                                                    value: address,
                                                    child: Text(
                                                        '${address.firstName} ${address.lastName}'),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              AppLocale.of(context)
                                                  .translate('paymentMethod')!,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'Poppins'),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  13,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.14),
                                                ),
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: CustomTextFormField(
                                                controllerField:
                                                    cardNameController,
                                                prefixIcon: const Icon(
                                                    Icons.person_2_outlined),
                                                hintText: AppLocale.of(context)
                                                    .translate('name')!,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocale.of(context)
                                                        .translate(
                                                            'nameValidator')!;
                                                  }
                                                  return null;
                                                },
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10, top: 15),
                                                errorStyle: const TextStyle(
                                                  height: 0.5,
                                                ),
                                                keyboardType:
                                                    TextInputType.name,
                                                onChange: (String city) {
                                                  print(city);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  13,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.14),
                                                ),
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              child: CustomTextFormField(
                                                controllerField:
                                                    cardNumberController,
                                                prefixIcon: const Icon(
                                                    Icons.credit_card),
                                                hintText: AppLocale.of(context)
                                                    .translate('cardNumber')!,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocale.of(context)
                                                        .translate(
                                                            'cardNumberValidator')!;
                                                  }
                                                  return null;
                                                },
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10, top: 15),
                                                errorStyle: const TextStyle(
                                                  height: 0.5,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChange: (String city) {
                                                  print(city);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      13,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.14),
                                                    ),
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: CustomTextFormField(
                                                    controllerField:
                                                        cardDateController,
                                                    prefixIcon: const Icon(Icons
                                                        .date_range_outlined),
                                                    hintText: AppLocale.of(
                                                            context)
                                                        .translate('cardDate')!,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return AppLocale.of(
                                                                context)
                                                            .translate(
                                                                'cardDateValidator')!;
                                                      }
                                                      return null;
                                                    },
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 15),
                                                    errorStyle: const TextStyle(
                                                      height: 0.5,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChange: (String card) {
                                                      print(card);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      13,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.14),
                                                    ),
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: CustomTextFormField(
                                                    controllerField:
                                                        CVVController,
                                                    prefixIcon: const Icon(
                                                        Icons.credit_card),
                                                    hintText: 'CVV',
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return AppLocale.of(
                                                                context)
                                                            .translate(
                                                                'CVVValidator')!;
                                                      }
                                                      return null;
                                                    },
                                                    obscureText: true,
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 15),
                                                    errorStyle: const TextStyle(
                                                      height: 0.5,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChange: (String city) {
                                                      print(city);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    gradient:
                                        Provider.of<ThemeProvider>(context)
                                            .linearGradient,
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        int? userId =
                                            preferences.getInt('user_id');
                                        String? token =
                                            preferences.getString('token');
                                        // Create the order
                                        final orderResponse =
                                            await orderProvider.createOrder(
                                                totalPrice, userId!, token!);

                                        if (orderResponse != null) {
                                          // Create order details for each item in the cart
                                          for (CartItem cartItem
                                              in cartProvider.cartItemsGetter) {
                                            await orderProvider
                                                .createOrderDetails(
                                                    orderResponse['order']
                                                        ['id'],
                                                    cartItem.productId,
                                                    cartItem.quantity,
                                                    cartItem.price,
                                                    token)
                                                .then((_) =>
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DoneScreen(),
                                                      ),
                                                    ));
                                          }

                                          // Clear the cart
                                          // cartProvider.clearCart();
                                        }
                                      }
                                    },
                                    child: Text(
                                      AppLocale.of(context)
                                          .translate('doneButton')!,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ),
                                ),
                                // IconButton(
                                //     onPressed: () async {
                                //       SharedPreferences preferences =
                                //           await SharedPreferences.getInstance();
                                //       int? id = preferences.getInt('orderId');
                                //       double? total =
                                //           preferences.getDouble('total');
                                //       print(id);
                                //     },
                                //     icon: Icon(Icons.abc)),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text(
                  AppLocale.of(context).translate('checkOut')!,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // double calculateTotalPrice(List<CartItem> cartItems) {
  //   double total = 0;
  //   for (var item in cartItems) {
  //     total += item.price * item.quantity;
  //   }
  //   return total;
  // }

  // int calculateTotalQuantity(List<CartItem> cartItems) {
  //   int totalQuantity = 0;
  //   for (var item in cartItems) {
  //     totalQuantity += item.quantity;
  //   }
  //   return totalQuantity.toInt();
  // }
}
