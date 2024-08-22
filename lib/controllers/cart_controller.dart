import 'package:dog_food_app/product_data.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  // Getter to retrieve cart items along with their quantities
  List<CartItem> get cartItems {
    return _cartItems.map((item) {
      return CartItem(
        product: item['product'],
        quantity: item['quantity'],
      );
    }).toList();
  }

  void addToCart(Product product, int quantity) {
    final int index =
        _cartItems.indexWhere((item) => item['product'].name == product.name);
    if (index >= 0) {
      // If product already exists in the cart, increase its quantity
      _cartItems[index]['quantity'] += quantity;
    } else {
      // Otherwise, add new product to the cart
      _cartItems.add({
        'product': product,
        'quantity': quantity,
      });
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item['product'].name == product.name);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});
}
