import 'package:flutter/material.dart';

// Define the Product class
class Product {
  final String name;
  final String brand;
  final String type;
  final String age;
  final String dietaryNeeds;
  final String size;
  final double price;
  final String imageUrl;
  final String description;

  Product({
    required this.name,
    required this.brand,
    required this.type,
    required this.age,
    required this.dietaryNeeds,
    required this.size,
    required this.price,
    required this.imageUrl,
    required this.description,
  });
}

// List of products with detailed descriptions
List<Product> products = [
  Product(
    name: 'Royal Canin',
    brand: 'Royal Canin',
    type: 'Dry Food',
    age: 'Adult',
    dietaryNeeds: 'Grain-Free',
    size: 'Large',
    price: 4500,
    imageUrl: 'assets/images/royal.png',
    description: 'Royal Canin Adult Dry Dog Food provides balanced nutrition for adult dogs. Rich in proteins and essential nutrients to support overall health and vitality.',
  ),
  Product(
    name: 'Hill\'s Science',
    brand: 'Hill\'s',
    type: 'Dry Food',
    age: 'Puppy',
    dietaryNeeds: 'Organic',
    size: 'Medium',
    price: 3500,
    imageUrl: 'assets/images/hills.png',
    description: 'Hill\'s Science Diet Puppy Food is specially formulated for the developmental needs of puppies. Made with natural ingredients and fortified with vitamins, minerals, and amino acids.',
  ),
  Product(
    name: 'Purina Pro',
    brand: 'Purina',
    type: 'Dry Food',
    age: 'Adult',
    dietaryNeeds: 'Grain-Free',
    size: 'Large',
    price: 5000,
    imageUrl: 'assets/images/product1.png',
    description: 'Purina Pro Plan Adult Dog Food is tailored nutrition for adult dogs. With high-quality protein sources, it helps maintain lean muscle mass and supports digestive health.',
  ),
  Product(
    name: 'Acana Puppy',
    brand: 'Acana',
    type: 'Dry Food',
    age: 'Puppy',
    dietaryNeeds: 'Grain-Free',
    size: 'Small',
    price: 5500,
    imageUrl: 'assets/images/product2.png',
    description: 'Acana Puppy Recipe is a grain-free food packed with fresh ingredients, perfect for supporting the growth and development of puppies with a natural diet.',
  ),
  Product(
    name: 'Orijen',
    brand: 'Orijen',
    type: 'Dry Food',
    age: 'Adult',
    dietaryNeeds: 'Organic',
    size: 'Large',
    price: 7000,
    imageUrl: 'assets/images/ori.png',
    description: 'Orijen Adult Dog Food offers a biologically appropriate diet with a variety of fresh meats and fish, tailored for the natural needs of adult dogs.',
  ),
  Product(
    name: 'Eukanuba Puppy',
    brand: 'Eukanuba',
    type: 'Dry Food',
    age: 'Puppy',
    dietaryNeeds: 'Grain-Free',
    size: 'Large',
    price: 4000,
    imageUrl: 'assets/images/ee.png',
    description: 'Eukanuba Puppy Food is designed to provide complete and balanced nutrition for puppies. Supports brain development, strong bones, and healthy growth.',
  ),
  Product(
    name: 'Pedigree Adult',
    brand: 'Pedigree',
    type: 'Dry Food',
    age: 'Adult',
    dietaryNeeds: 'Organic',
    size: 'Medium',
    price: 3000,
    imageUrl: 'assets/images/pedi.png',
    description: 'Pedigree Adult Dog Food is made with whole grains, proteins, and essential nutrients to support overall health. A complete and balanced meal for adult dogs.',
  ),
  Product(
    name: 'Wellness CORE',
    brand: 'Wellness',
    type: 'Dry Food',
    age: 'Adult',
    dietaryNeeds: 'Grain-Free',
    size: 'Medium',
    price: 4800,
    imageUrl: 'assets/images/well.png',
    description: 'Wellness CORE Grain-Free Dog Food is rich in protein and free of grains. Designed to support lean body mass, muscle tone, and a healthy coat.',
  ),
  Product(
    name: 'Canidae PURE',
    brand: 'Canidae',
    type: 'Dry Food',
    age: 'Adult',
    dietaryNeeds: 'Organic',
    size: 'Small',
    price: 5200,
    imageUrl: 'assets/images/canidae.png',
    description: 'Canidae PURE Dog Food features a simple recipe with real meat and whole foods. Perfect for dogs with sensitive stomachs and dietary restrictions.',
  ),
  Product(
    name: 'Blue Buffalo',
    brand: 'Blue Buffalo',
    type: 'Dry Food',
    age: 'Puppy',
    dietaryNeeds: 'Grain-Free',
    size: 'Medium',
    price: 3700,
    imageUrl: 'assets/images/blue.png',
    description: 'Blue Buffalo Puppy Food is formulated to support the growth and development of puppies. Made with real meat and wholesome grains for a balanced diet.',
  ),
  Product(
    name: 'NaturalL.I.D.',
    brand: 'Natural Balance',
    type: 'Dry Food',
    age: 'Adult',
    dietaryNeeds: 'Organic',
    size: 'Large',
    price: 4900,
    imageUrl: 'assets/images/natu.png',
    description: 'Natural Balance L.I.D. Dog Food features a limited ingredient diet, perfect for dogs with food sensitivities. Contains high-quality proteins and essential nutrients.',
  ),
];
