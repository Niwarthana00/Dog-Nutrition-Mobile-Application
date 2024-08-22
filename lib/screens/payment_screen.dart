import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:flutter/material.dart';
import 'home_screen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _saveCardDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add new card',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Your payment information is safe with us',
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
              SizedBox(height: 20),
              _buildCardIcons(),
              SizedBox(height: 20),
              _buildTextField(
                controller: _cardNumberController,
                label: 'Card number',
                keyboardType: TextInputType.number,
                obscureText: false,
                suffixIcon: Icon(Icons.credit_card),
              ),
              _buildTextField(
                controller: _cardHolderNameController,
                label: 'Cardholder name',
                keyboardType: TextInputType.name,
                obscureText: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _expiryDateController,
                      label: 'MM/YY',
                      keyboardType: TextInputType.datetime,
                      obscureText: false,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _cvvController,
                      label: 'CVV',
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      suffixIcon: Icon(Icons.help_outline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Switch(
                    value: _saveCardDetails,
                    onChanged: (bool value) {
                      setState(() {
                        _saveCardDetails = value;
                      });
                    },
                  ),
                  Text('Fill card details'),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAndConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  child: Text(
                    'Pay now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Your order will be processed in USD',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCardIcons() {
    return Row(
      children: [
        Image.asset('assets/images/visa.png', width: 40), // Example
        SizedBox(width: 10),
        Image.asset('assets/images/mastercard.png', width: 40), // Example
        SizedBox(width: 10),
        Image.asset('assets/images/jcb.png', width: 40), // Example
        SizedBox(width: 10),
        Image.asset('assets/images/amex.png', width: 40), // Example
      ],
    );
  }

  void _saveAndConfirm() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      // Save payment details to Firestore
      try {
        await FirebaseFirestore.instance.collection('payment_details').add({
          'card_number': _cardNumberController.text,
          'cardholder_name': _cardHolderNameController.text,
          'expiry_date': _expiryDateController.text,
          'cvv': _cvvController.text,
          'save_card_details': _saveCardDetails,
        });

        // Dismiss the loading indicator
        Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment successfull!'),
          ),
        );

        // Navigate back to HomeScreen
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        });
      } catch (e) {
        // Dismiss the loading indicator
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save payment details.'),
          ),
        );
      }
    }
  }
}
