import 'package:dog_food_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:dog_food_app/controllers/cart_controller.dart';
import 'package:dog_food_app/screens/home_screen.dart';
import 'package:dog_food_app/screens/login_screen.dart';
import 'package:dog_food_app/screens/account_screen.dart';
import 'package:dog_food_app/screens/shop_screen.dart';
import 'package:dog_food_app/screens/cart_screen.dart';
import 'package:dog_food_app/screens/details_screen.dart';
import 'package:dog_food_app/screens/checkout_screen.dart';
import 'package:dog_food_app/screens/breed_details_screen.dart';
import 'package:dog_food_app/screens/product_details_screen.dart';
import 'package:dog_food_app/screens/help.dart';
import 'package:dog_food_app/screens/payment_screen.dart';
import 'package:dog_food_app/screens/payment_data.dart'; // Make sure this import is necessary

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DogFoodApp());
}

class DogFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartController(),
      child: MaterialApp(
        title: 'Dog Food App',
        theme: ThemeData(
          primaryColor: Color(0xFFCCCCFF), // Lavender blue primary color
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => IntroScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(),
          '/account': (context) => AccountScreen(),
          '/shop': (context) => ShopScreen(),
          '/cart': (context) => CartScreen(),
          '/details': (context) => DetailsScreen(),
          '/checkout': (context) => CheckoutScreen(),
          '/breedDetails': (context) => BreedDetailsScreen(
            breed: '',
            speed: '',
            image: '',
          ),
          '/productDetails': (context) {
            final args = ModalRoute.of(context)!.settings.arguments
            as Map<String, dynamic>;
            return ProductDetailsScreen(
              image: args['image'],
              name: args['name'],
              price: args['price'],
              description: args['description'],
            );
          },
          '/payment': (context) => PaymentScreen(),
          '/paymentData': (context) => PaymentDetailsScreen(), // Updated route
          '/help': (context) => HelpPage(),
        },
      ),
    );
  }
}
