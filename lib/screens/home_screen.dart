// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_flutter_laravel/AppLocale.dart';
import 'package:ecommerce_flutter_laravel/providers/cart_provider.dart';
import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';
import 'package:ecommerce_flutter_laravel/screens/cart_screen.dart';
import 'package:ecommerce_flutter_laravel/services/getProducts.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_card.dart';
import 'package:ecommerce_flutter_laravel/widgets/custom_modal_product_details.dart';

import '../providers/review_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences preferences;
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  ValueNotifier<String> searchQuery = ValueNotifier<String>('');
  FocusScopeNode focusScopeNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    isLoading = true;
    preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    await Provider.of<GetProducts>(context, listen: false).getAllProduct(token);

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 35.0, top: 20.0, left: 10),
                  child: Container(
                    width: 65.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(4, 8),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        print(preferences.getInt('user_id'));
                        print(preferences.getString('email'));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${cartProvider.cartItemsGetter.length}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              elevation: 0.0,
              scrolledUnderElevation: 1.0,
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  AppLocale.of(context).translate('home')!,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 30.0),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: Provider.of<ThemeProvider>(context).linearGradient,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSwatch()
                          .copyWith(secondary: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      bottom: 20.0,
                    ),
                    child: Container(
                      height: 48.0,
                      alignment: Alignment.center,
                      child: FocusScope(
                        node: focusScopeNode,
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            searchQuery.value = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.19),
                            contentPadding: const EdgeInsets.only(top: 12.0),
                            hintText:
                                AppLocale.of(context).translate('searchBar')!,
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              onPressed: () {
                                searchController.clear();
                                focusScopeNode.unfocus();
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.00001),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.00001),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SizedBox(
              height: double.infinity,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 1,
                width: double.infinity,
                child: ValueListenableBuilder<String>(
                    valueListenable: searchQuery,
                    builder: (context, provider, child) {
                      return Consumer2<GetProducts, ReviewProvider>(
                        builder: (context, getProductsProvider, reviewProvider,
                            child) {
                          final searchResults = getProductsProvider
                              .searchProducts(searchController.text);
                          if (searchResults.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (searchResults.isEmpty) {
                            return const Center(child: Text('no product'));
                          } else {
                            return GridView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1.0,
                                mainAxisExtent: 220,
                                mainAxisSpacing: 10.0,
                              ),
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final product = searchResults[index];
                                return GestureDetector(
                                  onTap: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    int? userIIDD = pref.getInt('user_id');
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      builder: (context) {
                                        child;
                                        return CustomModal(
                                          imageUrl: product['image'],
                                          title: product['name'],
                                          description: product['description'],
                                          price: product['price'],
                                          stock: product['stock'],
                                          productId: product['id'],
                                          imageUrlB: product['image'],
                                          priceB:
                                              double.parse(product["price"]),
                                          productIdButton: product['id'],
                                          titleB: product['name'],
                                          userIdd: userIIDD!,
                                        );
                                      },
                                    );
                                  },
                                  child: CustomCard(
                                    imageUrl: product['image'],
                                    title: product['name'],
                                    description: product['description'],
                                    price: product['price'],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    }),
              ),
            ),
          );
        }
      },
    );
  }
}
