// lib/providers/blog_provider.dart
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogProvider with ChangeNotifier {
  List<dynamic> articles = [];
  List<dynamic> filteredArticles = [];
  bool isLoading = true;

  // Fetch articles from the API
  Future<void> fetchArticles() async {
    final url = Uri.parse('https://tech-cambodia.com/cms/items/articles?filter[status]=published&limit=25&sort=-date_created&fields=title,date_created,slug,thumbnail,body,category.name,user_created.first_name,user_created.last_name,user_created.avatar,views');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        articles = data['data'];
        filteredArticles = articles;
        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching articles: $error');
      }
      isLoading = false;
      notifyListeners();
    }
  }

  // Search articles by title
  void searchArticles(String query) {
    if (query.isEmpty) {
      filteredArticles = articles;
    } else {
      filteredArticles = articles
          .where((article) =>
              article['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
