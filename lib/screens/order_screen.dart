// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_flutter_laravel/providers/review_provider.dart';

import '../AppLocale.dart';
import '../providers/order_provider.dart';
import '../providers/theme_provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = false;
  void getaddressData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    Provider.of<OrderProvider>(context, listen: false)
        .fetchOrdersAndDetails(token!);
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
    final TextEditingController reviewController = TextEditingController();
    final TextEditingController ratingController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 1.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              AppLocale.of(context).translate('myOrders')!,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
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
                    Center(
                      child: Text(
                        AppLocale.of(context).translate('rev')!,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color:
                            Provider.of<ThemeProvider>(context).backgroundColor,
                      ),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Provider.of<ThemeProvider>(context)
                              .backgroundColor,
                        ),
                        child: Consumer<OrderProvider>(
                            builder: (context, provider, child) {
                          if (provider.orders.isEmpty) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (provider.orders.isNotEmpty) {
                            return ListView.builder(
                              itemCount: provider.orders.length,
                              itemBuilder: (context, index) {
                                final order = provider.orders[index];
                                final orderDetail =
                                    provider.orderDetails[index];
                                return ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\$ ${order.total.toString()}"),
                                      Text(
                                          " #${orderDetail.orderId.toString()}"),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ListView(
                                            children: [
                                              AlertDialog(
                                                title: Text(
                                                  AppLocale.of(context)
                                                      .translate(
                                                          'writeYourReview')!,
                                                ),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            reviewController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: AppLocale
                                                                  .of(context)
                                                              .translate(
                                                                  'yourReview')!,
                                                        ),
                                                        onChanged: (value) {},
                                                      ),
                                                      TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            ratingController,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: AppLocale
                                                                  .of(context)
                                                              .translate(
                                                                  'yourRate')!,
                                                        ),
                                                        onChanged: (value) {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(
                                                      AppLocale.of(context)
                                                          .translate(
                                                              'cancelButton')!,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(
                                                      AppLocale.of(context)
                                                          .translate(
                                                              'saveButton')!,
                                                    ),
                                                    onPressed: () async {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      String? token =
                                                          preferences.getString(
                                                              'token');
                                                      int? userId = preferences
                                                          .getInt('user_id');
                                                      Provider.of<ReviewProvider>(
                                                              context,
                                                              listen: false)
                                                          .createReviewAndRate(
                                                              userId!,
                                                              orderDetail
                                                                  .productId,
                                                              reviewController
                                                                  .text,
                                                              int.parse(
                                                                  ratingController
                                                                      .text),
                                                              token!);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.add_circle_outline_outlined),
                                  ),
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        maxRadius: 50,
                                        child: Image.network(
                                          provider.orderDetails[index]
                                              .productImageUrl,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                      title: Text(orderDetail.productName),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${AppLocale.of(context).translate('quantity')!}: ${orderDetail.quantity.toString()}"),
                                          Text(
                                              "${AppLocale.of(context).translate('price')!}: \$ ${orderDetail.price.toString()}"),
                                        ],
                                      ),
                                    ),
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
}
