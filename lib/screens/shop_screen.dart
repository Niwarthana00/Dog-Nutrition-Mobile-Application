import 'package:flutter/material.dart';
import 'package:dog_food_app/widgets/common_scaffold.dart';
import 'package:dog_food_app/product_data.dart'; // Import the product data

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String selectedAge = 'All';
  String selectedType = 'All';
  String selectedDietaryNeeds = 'All';
  String selectedSize = 'All';

  @override
  Widget build(BuildContext context) {
    // Filter products based on selected criteria
    List<Product> filteredProducts = products.where((product) {
      bool matchesAge = selectedAge == 'All' || product.age == selectedAge;
      bool matchesType = selectedType == 'All' || product.type == selectedType;
      bool matchesDietaryNeeds = selectedDietaryNeeds == 'All' || product.dietaryNeeds == selectedDietaryNeeds;
      bool matchesSize = selectedSize == 'All' || product.size == selectedSize;
      return matchesAge && matchesType && matchesDietaryNeeds && matchesSize;
    }).toList();

    // Sort products alphabetically by name (A to Z)
    filteredProducts.sort((a, b) => a.name.compareTo(b.name));

    return CommonScaffold(
      currentIndex: 0,
      body: Column(
        children: [
          // Filters
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // First Row of Filters
                Row(
                  children: [
                    // Age Filter
                    Expanded(
                      child: Container(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          value: selectedAge,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Age',
                          ),
                          items: ['All', 'Puppy', 'Adult'].map((age) {
                            return DropdownMenuItem(value: age, child: Text(age));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedAge = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Type Filter
                    Expanded(
                      child: Container(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          value: selectedType,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Type',
                          ),
                          items: ['All', 'Dry Food', 'Wet Food'].map((type) {
                            return DropdownMenuItem(value: type, child: Text(type));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedType = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Second Row of Filters
                Row(
                  children: [
                    // Dietary Needs Filter
                    Expanded(
                      child: Container(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          value: selectedDietaryNeeds,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Dietary Needs',
                          ),
                          items: ['All', 'Grain-Free', 'Organic'].map((dietaryNeed) {
                            return DropdownMenuItem(value: dietaryNeed, child: Text(dietaryNeed));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDietaryNeeds = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    // Size Filter
                    Expanded(
                      child: Container(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          value: selectedSize,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Size',
                          ),
                          items: ['All', 'Small', 'Medium', 'Large'].map((size) {
                            return DropdownMenuItem(value: size, child: Text(size));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Product List
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/productDetails',
                      arguments: {
                        'image': product.imageUrl,
                        'name': product.name,
                        'price': product.price,
                        'description': product.description,
                      },
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: AssetImage(product.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Product Info
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'RS ${product.price.toStringAsFixed(2)}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
