import 'package:flutter/material.dart';
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
          // Add your custom bottom sheet content here
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.highlight_remove_sharp),
                  )
                ],
              ),
              Container(
                constraints: BoxConstraints(
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
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
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
                // Add your custom button action here
              },
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
