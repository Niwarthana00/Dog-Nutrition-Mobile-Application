import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: Color(0xFFCCCCFF), // Lavender blue background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'How to Use the App:\n\n',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '1. Home Page: \n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '   - The home page displays promotions and has a "Shop Now" button to start shopping.\n'
                          '   - You can also find delivery details, payment details, and customer support details on the home page.\n\n',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextSpan(
                      text: '2. Shop Screen: \n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '   - On the shop screen, you can filter foods by age, type, dietary needs, and size.\n'
                          '   - Clicking on a food item will show quantity adjustment options and an "Add to Cart" button, along with customer reviews.\n\n',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextSpan(
                      text: '3. Cart Screen: \n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '   - The cart screen displays the price of added items and the subtotal.\n'
                          '   - You can proceed to checkout from the cart screen.\n\n',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextSpan(
                      text: '4. Checkout Process: \n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '   - During checkout, you will need to enter shipping details and card details to make payment.\n\n',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextSpan(
                      text: '5. Details Section: \n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '   - In the details section, you can view detailed information about different dogs.\n\n',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextSpan(
                      text: '6. Account Section: \n',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '   - In the account section, you can add or update your payment and shipping details.\n',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
