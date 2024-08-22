import 'package:flutter/material.dart';

// comment added
// second commit added for merge

class CartItem {
  final String id;
  final String image;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}
