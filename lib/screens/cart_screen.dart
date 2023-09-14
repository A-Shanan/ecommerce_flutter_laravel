// ignore_for_file: unused_import, unused_local_variable, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartProvider.cartItemsGetter.length,
        itemBuilder: (context, index) {
          final cartItem = cartProvider.cartItemsGetter[index];
          return ListTile(
            isThreeLine: true,
            leading: Image.network(cartItem.imageUrl),
            title: Text(cartItem.productName),
            subtitle: Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
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
              'Total: \$${cartProvider.calculateTotalPrice().toStringAsFixed(2)}',
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
                                              .cartItemsGetter.length,
                                          itemBuilder: (context, index) {
                                            final cartItem = cartProvider
                                                .cartItemsGetter[index];
                                            return ListTile(
                                              isThreeLine: true,
                                              leading: Image.network(
                                                  cartItem.imageUrl),
                                              title: Text(cartItem.productName),
                                              subtitle: Text(
                                                  'Price: \$${cartItem.price.toStringAsFixed(2)}'),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.remove),
                                                    onPressed: () {
                                                      cartProvider
                                                          .decreaseQuantity(
                                                              index);
                                                    },
                                                  ),
                                                  Text('${cartItem.quantity}'),
                                                  IconButton(
                                                    icon: Icon(Icons.add),
                                                    onPressed: () {
                                                      cartProvider
                                                          .increaseQuantity(
                                                              index);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('My Addresses'),
                                          TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Add an address'),
                                                      );
                                                    });
                                              },
                                              child: Text('add address'))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
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
                                                  orderResponse['order']['id'],
                                                  cartItem.productId,
                                                  cartItem.quantity,
                                                  cartItem.price,
                                                  token);
                                        }

                                        // Clear the cart
                                        // cartProvider.clearCart();
                                      }
                                    },
                                    child: const Text(
                                      "done",
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
                child: const Text(
                  "Check out",
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
