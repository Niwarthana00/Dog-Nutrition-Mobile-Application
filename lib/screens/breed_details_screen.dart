import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class BreedDetailsScreen extends StatefulWidget {
  final String breed;
  final String speed;
  final String image;

  BreedDetailsScreen({
    required this.breed,
    required this.speed,
    required this.image,
  });

  @override
  _BreedDetailsScreenState createState() => _BreedDetailsScreenState();
}

class _BreedDetailsScreenState extends State<BreedDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic> _articlesData = {};
  Map<String, dynamic> _nutritionData = {};
  Map<String, dynamic> _aboutMeData = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadArticlesData();
    _loadNutritionData();
    _loadAboutMeData();
  }

  Future<void> _loadArticlesData() async {
    final String response = await rootBundle.loadString('assets/articles.json');
    final data = json.decode(response);
    setState(() {
      _articlesData = data;
    });
  }

  Future<void> _loadNutritionData() async {
    final String response = await rootBundle.loadString('assets/nutrition.json');
    final data = json.decode(response);
    setState(() {
      _nutritionData = data;
    });
  }

  Future<void> _loadAboutMeData() async {
    final String response = await rootBundle.loadString('assets/about_me.json');
    final data = json.decode(response);
    setState(() {
      _aboutMeData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breed Details'),
        backgroundColor: Color(0xFFFFFFFF), // Lavender Blue theme color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and title section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
                child: Image.asset(
                  widget.image,
                  width: double.infinity,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                height: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
                  color: Colors.black.withOpacity(0.5), // Black overlay with reduced opacity
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Text(
                  widget.breed,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // TabBar section
          Container(
            height: 50.0,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Tab(text: 'Articles'),
                Tab(text: 'Nutrition Guide'),
                Tab(text: 'Videos'),
                Tab(text: 'About Me'),
              ],
              labelColor: Color(0xFF9F9FF8),
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(),
            ),
          ),
          // TabBarView section
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildArticlesContent(),
                _buildNutritionContent(),
                _buildContent('Videos'),
                _buildAboutMeContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build articles content
  Widget _buildArticlesContent() {
    final articles = _articlesData[widget.breed]?['Articles'] as List<dynamic>? ?? [];

    if (articles.isEmpty) {
      return Center(child: Text('No articles available for ${widget.breed}.'));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        final topic = article['topic'] ?? 'No topic';
        final content = article['content'] ?? 'No content available';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Text(
                content,
                textAlign: TextAlign.justify,
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  // Build nutrition content
  Widget _buildNutritionContent() {
    final nutritionGuide = _nutritionData[widget.breed]?['Nutrition Guide'] as List<dynamic>? ?? [];

    if (nutritionGuide.isEmpty) {
      return Center(child: Text('No nutrition guide available for ${widget.breed}.'));
    }

    return ListView.builder(
      itemCount: nutritionGuide.length,
      itemBuilder: (context, index) {
        final guide = nutritionGuide[index];
        final topic = guide['topic'] ?? 'No topic';
        final content = guide['content'] ?? 'No content available';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Text(
                content,
                textAlign: TextAlign.justify,
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  // Build About Me content
  Widget _buildAboutMeContent() {
    final aboutMe = _aboutMeData[widget.breed] ?? {};
    final lifeStages = aboutMe['Life Stages'] ?? 'No information available';
    final lifeStagesPhoto = aboutMe['Life Stages Photo'] ?? '';
    final dietaryRequirements = aboutMe['Dietary Requirements'] ?? 'No information available';
    final dietaryRequirementsPhoto = aboutMe['Dietary Requirements Photo'] ?? '';
    final healthTips = aboutMe['Health Tips'] ?? 'No information available';
    final healthTipsPhoto = aboutMe['Health Tips Photo'] ?? '';

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      children: [
        _buildAboutMeSection('Life Stages', lifeStages, lifeStagesPhoto),
        _buildAboutMeSection('Dietary Requirements', dietaryRequirements, dietaryRequirementsPhoto),
        _buildAboutMeSection('Health Tips', healthTips, healthTipsPhoto),
      ],
    );
  }

  // Helper method to build each About Me section
  Widget _buildAboutMeSection(String title, String content, String photo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          SizedBox(height: 5.0),
          if (photo.isNotEmpty)
            Image.asset(
              photo,
              height: 150.0, // Adjust height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 10.0),
          Text(
            content,
            textAlign: TextAlign.justify,
          ),
          Divider(),
        ],
      ),
    );
  }

  // Placeholder content for other tabs
  Widget _buildContent(String tab) {
    return Center(
      child: Text(
        '$tab Content for ${widget.breed}',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
