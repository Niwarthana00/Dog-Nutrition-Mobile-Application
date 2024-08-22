import 'package:flutter/material.dart';
import 'package:dog_food_app/widgets/common_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:dog_food_app/controllers/cart_controller.dart'; // Import your CartController

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the CartController
    final cartController = Provider.of<CartController>(context);

    // Calculate subtotal
    double subtotal = cartController.cartItems.fold(0.0, (total, item) {
      return total + (item.product.price * item.quantity);
    });

    return CommonScaffold(
      body: cartController.cartItems.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartController.cartItems[index];
                      final product = cartItem.product;
                      final quantity = cartItem.quantity;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              // Product Image
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(product.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              // Product Info
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Quantity: $quantity',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'RS ${(product.price * quantity).toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Remove Button
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    cartController.removeFromCart(product);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Subtotal
                      Text(
                        'Subtotal: RS ${subtotal.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      // Checkout Button
                      SizedBox(
                        width: double.infinity, // Full width
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to Checkout Screen
                            Navigator.pushNamed(context, '/checkout');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFF9F9FF8), // Lavender Blue Color
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0), // Adjust vertical padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Less rounded corners
                            ),
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: TextStyle(
                                color: Colors.white), // White text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      currentIndex: 1, // Set the index for Cart
    );
  }
}
