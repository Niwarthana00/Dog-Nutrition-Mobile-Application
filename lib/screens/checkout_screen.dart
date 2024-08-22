import 'package:dog_food_app/screens/payment_screen.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String? _selectedProvince;
  String? _selectedCity;

  // Sri Lankan provinces and cities
  final Map<String, List<String>> _provinceCityMap = {
    'Western': ['Colombo', 'Gampaha', 'Kalutara'],
    'Central': ['Kandy', 'Matale', 'Nuwara Eliya'],
    'Southern': ['Galle', 'Matara', 'Hambantota'],
    'Northern': ['Jaffna', 'Kilinochchi', 'Mannar', 'Vavuniya', 'Mullaitivu'],
    'Eastern': ['Trincomalee', 'Batticaloa', 'Ampara'],
    'North Western': ['Kurunegala', 'Puttalam'],
    'North Central': ['Anuradhapura', 'Polonnaruwa'],
    'Uva': ['Badulla', 'Monaragala'],
    'Sabaragamuwa': ['Ratnapura', 'Kegalle'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildForm(),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Set as default shipping address'),
                    Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _proceedToPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9F9FF8), // Save button color
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text(
                      'Save & Proceed to Payment',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField(controller: _fullNameController, label: 'Contact name*'),
        _buildPhoneNumberField(),
        _buildTextField(controller: _addressController, label: 'Street, house/apartment/unit*'),
        _buildProvinceDropdown(),
        _buildCityDropdown(),
        _buildTextField(controller: _postalCodeController, label: 'ZIP code*'),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
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

  Widget _buildPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 60,
            child: TextFormField(
              initialValue: '+94',
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Mobile number*',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your mobile number';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvinceDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Province*',
          border: OutlineInputBorder(),
        ),
        value: _selectedProvince,
        items: _provinceCityMap.keys.map((province) {
          return DropdownMenuItem(
            value: province,
            child: Text(province),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedProvince = value;
            _selectedCity = null; // Reset city when province changes
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a province';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCityDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'City*',
          border: OutlineInputBorder(),
        ),
        value: _selectedCity,
        items: _selectedProvince == null
            ? []
            : _provinceCityMap[_selectedProvince!]!.map((city) {
          return DropdownMenuItem(
            value: city,
            child: Text(city),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCity = value;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a city';
          }
          return null;
        },
      ),
    );
  }

  void _proceedToPayment() {
    if (_formKey.currentState!.validate()) {
      // Pass the form data to the Payment Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentDetailsScreen()),
      );
    }
  }
}
