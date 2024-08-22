import 'package:flutter/material.dart';
import '../widgets/common_scaffold.dart'; // Ensure this path is correct

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
    );

    // Auto-change page every 5 seconds
    Future.delayed(Duration(seconds: 5), _autoChangePage);
  }

  void _autoChangePage() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        (_currentPage + 1) % 3, // Assuming 3 cards
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = (_currentPage + 1) % 3;
      });

      Future.delayed(Duration(seconds: 5), _autoChangePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Promotion Cards
            Container(
              height: 220, // Set a fixed height to avoid overflow
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: 3, // Number of promotion cards
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 380, //  width of the card
                      height: 180, //  card height
                      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Card(
                            color: Color(0xFF9F9FF8),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Content Section
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '20% Discount on All Products!', // Promotional content
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Navigate to the shop screen or other relevant action
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Color(0xFF9F9FF8),
                                            backgroundColor: Colors.white, // Button text color
                                          ),
                                          child: Text('Shop Now'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 120), // Reduced space for image
                              ],
                            ),
                          ),
                          // Image Section with 3D effect
                          Positioned(
                            right: 0, // Adjust position to move image more to the left
                            top: -5,
                            child: Transform.scale(
                              scale: 1.3, // Scale the image to create a 3D effect
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/images/promo${index + 1}.png',
                                  width: 140,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // "From Us" Topic and Icon Cards
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0), // Adjust padding to move up
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center-align the text
                children: [
                  Center(  // Center the "From Us" text
                    child: Text(
                      'From Us',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF404042),
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Decreased space between text and icons
                  Container(
                    height: 80, // Adjust height for icon row
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildIconCard(Icons.pets, 'Dog Food', [Colors.orange, Colors.red]),
                        _buildIconCard(Icons.info, 'Food Details', [Color(
                            0xFFFFE642), Colors.green]),
                        _buildIconCard(Icons.shopping_cart, 'Buy Food', [Color(0xFFCDC1FF), Colors.blue]),
                        _buildIconCard(Icons.description, 'Dog Details', [Color(
                            0xFFDF7CDF), Color(0xFF7323BA)]),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Delivery Information Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF404042),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(
                          icon: Icons.local_shipping,
                          title: 'Fast Delivery',
                          description: 'Get your food delivered quickly with our express delivery service.',
                          color: Color(0xFF9F9FF8), // Lavender blue background color
                        ),
                        SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.payment,
                          title: 'Secure Payment',
                          description: 'Your payment details are safe and secure with us.',
                          color: Color(0xFF9F9FF8), // Lavender blue background color
                        ),
                        SizedBox(height: 16),
                        _buildInfoCard(
                          icon: Icons.support,
                          title: '24/7 Support',
                          description: 'Our customer support team is available 24/7 to assist you.',
                          color: Color(0xFF9F9FF8), // Lavender blue background color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      currentIndex: 2, // Index for Home
    );
  }

  // Helper method to build icon card with multi-color gradient
  Widget _buildIconCard(IconData icon, String label, List<Color> colors) {
    return Container(
      width: 80, // Decreased width of the circle
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 55, // Decreased size of the circle
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 25, // Decreased icon size
              ),
            ),
          ),
          SizedBox(height: 6), // Decreased space between icon and text
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF404042),
              fontSize: 12, // Decreased font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build delivery info card with image and text
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      color: color, // Lavender blue background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white, // White icon color
          size: 40,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF404042), // Black title text color
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF404042), // Black description text color
          ),
        ),
        contentPadding: EdgeInsets.all(16.0),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
