import 'dart:io';


import 'package:dog_food_app/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dog_food_app/widgets/common_scaffold.dart';
import 'shipping_details_screen.dart';
import 'payment_data.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with AutomaticKeepAliveClientMixin {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Must call super.build when using AutomaticKeepAliveClientMixin
    return CommonScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage, // Opens gallery when the avatar is tapped
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300], // Placeholder color
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : null, // Display picked image or nothing
                    child: _image == null
                        ? Icon(Icons.camera_alt, color: Colors.white, size: 40)
                        : null, // Display camera icon if no image is selected
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Niwarthana',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'who loves shopping',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20),
            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('2334', 'Posts'),
                _buildStatCard('3465', 'Followers'),
                _buildStatCard('235', 'Likes'),
              ],
            ),
            SizedBox(height: 20),
            // My Order Section
            Text(
              'My Order',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildOrderCard(Icons.payment, 'Unpaid', Color(0xFF616065)),
                _buildOrderCard(Icons.local_shipping, 'Pending', Color(0xFF616065)),
                _buildOrderCard(Icons.airport_shuttle, 'Shipped', Color(0xFF616065)),
                _buildOrderCard(Icons.check_circle, 'Completed', Color(0xFF616065)),
              ],
            ),
            SizedBox(height: 40), // Adjusted the space to move the menu down
            // Menu Options with 3D effect
            _buildMenuOption(Icons.wallet_giftcard, 'My Wallet', Colors.blue, context),
            _buildMenuOption(Icons.location_on, 'Shipping Address', Colors.green, context),
            _buildMenuOption(Icons.favorite, 'Collect', Colors.red, context),
            _buildMenuOption(Icons.discount, 'Discount Coupon', Colors.orange, context),
            _buildMenuOption(Icons.support, 'Customer Service', Colors.purple, context),
          ],
        ),
      ),
      currentIndex: 4, // Set the index for Account
    );
  }

  // This is required to make AutomaticKeepAliveClientMixin work
  @override
  bool get wantKeepAlive => true;

  // Widget to build the profile stats card
  Widget _buildStatCard(String count, String label) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 4), // Added margin between icon and text
          child: Text(
            count,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Widget to build the order status card with icon and color
  Widget _buildOrderCard(IconData icon, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(icon, size: 36, color: color),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Widget to build the menu options with 3D effect
  Widget _buildMenuOption(IconData icon, String label, Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle menu option tap
        if (label == 'My Wallet') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentScreen()),
          );
        } else if (label == 'Shipping Address') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShippingDetailsScreen()),
          );
        }
        // Add more navigation logic for other menu items if needed
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 24, color: color),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
