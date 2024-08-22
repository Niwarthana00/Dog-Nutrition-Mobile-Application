import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    // Remove the automatic navigation after 5 seconds
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Added to move content upwards
                Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0), // Space between text and image
                Image.asset(
                  'assets/images/splash.png', // Resized image asset
                  width: 350,
                  height: 350,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to Dog Food App!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0),
                Text(
                  'Get the best nutrition for your dog',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,

            child: Center(
              child: ElevatedButton(
                onPressed: _navigateToLogin,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF8F8FF4), // Lavender blue color
                  minimumSize: Size(220, 60), // Increased width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Reduced corner radius
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 20, // Increased font size
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
