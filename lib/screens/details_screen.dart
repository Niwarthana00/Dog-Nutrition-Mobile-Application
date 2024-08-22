import 'package:flutter/material.dart';
import 'package:dog_food_app/widgets/common_scaffold.dart';
import 'package:dog_food_app/screens/breed_details_screen.dart'; // Import the BreedDetailsScreen

class DetailsScreen extends StatelessWidget {
  final List<Map<String, String>> dogData = [
    {
      'image': 'assets/images/beagle1.png',
      'breed': 'Beagle',
      'speed': '60 km/h'
    },
    {
      'image': 'assets/images/Golden.png',
      'breed': 'Golden Retriever',
      'speed': '55 km/h'
    },
    {
      'image': 'assets/images/labrador.png',
      'breed': 'Labrador',
      'speed': '57 km/h'
    },
    {
      'image': 'assets/images/poodle.png',
      'breed': 'Poodle',
      'speed': '45 km/h'
    },
    {
      'image': 'assets/images/german.png',
      'breed': 'German Shephed',
      'speed': '50 km/h'
    },
    {
      'image': 'assets/images/bulldog.png',
      'breed': 'Bulldog',
      'speed': '40 km/h'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 2 / 2.7, // Adjusted aspect ratio for shorter cards
          ),
          itemCount: dogData.length,
          itemBuilder: (context, index) {
            final dog = dogData[index];
            return GestureDetector(
              onTap: () {
                // Navigate to BreedDetailsScreen with selected breed data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BreedDetailsScreen(
                      breed: dog['breed']!,
                      speed: dog['speed']!,
                      image: dog['image']!,
                    ),
                  ),
                );
              },
              child: Card(
                color: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                      child: Image.asset(
                        dog['image']!,
                        width: double.infinity,
                        height: 140.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        dog['breed']!,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8A8A8A),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.directions_run, color: Color(0xFF8A8A8A), size: 18),
                          SizedBox(width: 4.0),
                          Text(
                            dog['speed']!,
                            style: TextStyle(fontSize: 14.0, color: Color(0xFF454445)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0), // Slight padding adjustment at the bottom
                  ],
                ),
              ),
            );
          },
        ),
      ),
      currentIndex: 3, // Set the index for Details
    );
  }
}
