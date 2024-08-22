import 'package:dog_food_app/controllers/cart_controller.dart';
import 'package:dog_food_app/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String description;

  ProductDetailsScreen({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, int> ratings = {
      5: 20,
      4: 15,
      3: 10,
      2: 5,
      1: 2,
    };

    final double averageRating = 4.5; // Example average rating

    // Dummy reviews
    final List<Map<String, dynamic>> reviews = [
      {'name': 'Alice', 'stars': 5, 'comment': 'Excellent product! Highly recommend.'},
      {'name': 'Bob', 'stars': 4, 'comment': 'Very good quality. Worth the price.'},
      {'name': 'Charlie', 'stars': 3, 'comment': 'It’s okay, but there are better options.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600]!),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFD3C6F5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'RS ${widget.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        onPressed: _decreaseQuantity,
                        icon: Icon(Icons.remove),
                        color: Colors.black,
                        iconSize: 24,
                        splashColor: Colors.black.withOpacity(0.2),
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(
                          maxWidth: 40,
                          maxHeight: 40,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$_quantity',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        onPressed: _increaseQuantity,
                        icon: Icon(Icons.add),
                        color: Colors.black,
                        iconSize: 24,
                        splashColor: Colors.black.withOpacity(0.2),
                        padding: EdgeInsets.all(0),
                        constraints: BoxConstraints(
                          maxWidth: 40,
                          maxHeight: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final product = Product(
                    name: widget.name,
                    brand: "Brand", // Dummy brand
                    type: "Type", // Dummy type
                    age: "Age", // Dummy age
                    dietaryNeeds: "Dietary Needs", // Dummy dietary needs
                    size: "Size", // Dummy size
                    price: widget.price,
                    imageUrl: widget.image,
                    description: widget.description,
                  );

                  context.read<CartController>().addToCart(product, _quantity);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added ${widget.name} to cart')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFFFFFFF),
                  backgroundColor: Color(0xFF000000),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Add to Cart'),
              ),
            ),
            SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!), // Lighter border color
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer Reviews Header
                  Text(
                    'Customer Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Review Chart
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rating Distribution',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        ...ratings.entries.map((entry) {
                          final int stars = entry.key;
                          final int count = entry.value;
                          return Row(
                            children: [
                              Text(
                                '$stars',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 8),
                              Container(
                                width: 100,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: (100 * (count / 50)), // Adjust the divisor based on your data
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '$count',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // Reviews List
                  Column(
                    children: reviews.map((review) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Review Name and Stars
                            Row(
                              children: [
                                Text(
                                  review['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 8),
                                // Stars
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < review['stars'] ? Icons.star : Icons.star_border,
                                      color: Colors.black.withOpacity(0.6), // Light black color for stars
                                      size: 20,
                                    );
                                  }),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            // Review Comment
                            Text(
                              review['comment'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
