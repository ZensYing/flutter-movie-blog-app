// lib/ui/screens/news_feature_screen.dart
import 'package:flutter/material.dart';

class NewsFeatureScreen extends StatelessWidget {
  final List<Map<String, String>> upcomingFeatures = [
    {
      "title": "New Movie Recommendation System",
      "description": "Get personalized movie recommendations based on your viewing history and preferences.",
      "date": "Coming Soon - December 2024",
    },
    {
      "title": "Enhance the user experience by offering flexibility to watch movie without internet access.",
      "description": "So user can watch movie without the internet access.",
      "date": "Expected Release - January 2025",
    },
    {
      "title": "Community Forum",
      "description": "Engage with other movie and blog lovers in a new interactive forum.",
      "date": "Expected Launch - Q1 2025",
    },
  ];

   NewsFeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Features"),
        backgroundColor: const Color.fromARGB(255, 6, 196, 187),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: upcomingFeatures.length,
        itemBuilder: (context, index) {
          final feature = upcomingFeatures[index];

          return Card(
            color: Colors.grey[900],
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature["title"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.tealAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feature["description"]!,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feature["date"]!,
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
