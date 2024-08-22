import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
        title: Text('Save Payment Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Card',
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
                label: 'Card Number',
                keyboardType: TextInputType.number,
                obscureText: false,
                suffixIcon: Icon(Icons.credit_card),
              ),
              _buildTextField(
                controller: _cardHolderNameController,
                label: 'Cardholder Name',
                keyboardType: TextInputType.name,
                obscureText: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _expiryDateController,
                      label: 'Expiration Date (MM/YY)',
                      keyboardType: TextInputType.datetime,
                      obscureText: false,
                      suffixIcon: Icon(Icons.calendar_today),
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
                  Text('Save Card Details'),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(
                    'Save & Confirm',
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
          if (label == 'Expiration Date (MM/YY)') {
            // Regular expression to match MM/YY format
            if (!RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
              return 'Please enter a valid expiration date (MM/YY)';
            }
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
      // Save payment details to the 'payment_data' collection
      await FirebaseFirestore.instance.collection('payment_data').add({
        'card_number': _cardNumberController.text,
        'cardholder_name': _cardHolderNameController.text,
        'expiry_date': _expiryDateController.text,
        'cvv': _cvvController.text,
        'save_card_details': _saveCardDetails,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment details saved successfully!')),
      );

      Navigator.pop(context);
    }
  }
}
