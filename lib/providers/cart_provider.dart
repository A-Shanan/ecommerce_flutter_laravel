import 'package:flutter/foundation.dart';

class CartItem {
  final int productId;
  final String productName;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> cartItems = [];

  List<CartItem> get cartItemsGetter => cartItems;

  void addToCart(
      int productId, String productName, double price, String imageUrl) {
    final existingItemIndex =
        cartItems.indexWhere((item) => item.productId == productId);

    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity += 1;
    } else {
      cartItems.add(CartItem(
        productId: productId,
        productName: productName,
        price: price,
        imageUrl: imageUrl,
      ));
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    cartItems[index].quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity -= 1;
      notifyListeners();
    }
  }
}
