// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce_flutter_laravel/providers/theme_provider.dart';

import '../providers/cart_provider.dart';

class CustomBottomSheet extends StatelessWidget {
  final CartProvider cartProvider;

  CustomBottomSheet(this.cartProvider);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.highlight_remove_sharp),
                  )
                ],
              ),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 200.0,
                ),
                child: ListView.builder(
                  itemCount: cartProvider.cartItemsGetter.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItemsGetter[index];
                    return ListTile(
                      isThreeLine: true,
                      leading: Image.network(cartItem.imageUrl),
                      title: Text(cartItem.productName),
                      subtitle:
                          Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartProvider.decreaseQuantity(index);
                            },
                          ),
                          Text('${cartItem.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
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
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: Provider.of<ThemeProvider>(context).linearGradient,
            ),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "done",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
