// lib/providers/movie_provider.dart
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/app_config.dart';

class MovieProvider extends ChangeNotifier {
  List<dynamic> trendingMovies = [];
  List<dynamic> popularMovies = [];
  List<dynamic> upcomingMovies = [];
  List<dynamic> nowPlayingMovies = [];
  bool isLoading = false; // New isLoading property

  // Fetch trending movies
  Future<void> fetchTrendingMovies() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${AppConfig.baseUrl}${AppConfig.trendingMoviesEndpoint}?api_key=${AppConfig.apiKey}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        trendingMovies = data['results'];
      } else {
        throw Exception("Failed to load trending movies");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching trending movies: $error");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch popular movies
  Future<void> fetchPopularMovies() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${AppConfig.baseUrl}/movie/popular?api_key=${AppConfig.apiKey}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        popularMovies = data['results'];
      } else {
        throw Exception("Failed to load popular movies");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching popular movies: $error");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch upcoming movies
  Future<void> fetchUpcomingMovies() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${AppConfig.baseUrl}/movie/upcoming?api_key=${AppConfig.apiKey}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        upcomingMovies = data['results'];
      } else {
        throw Exception("Failed to load upcoming movies");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching upcoming movies: $error");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch now playing movies
  Future<void> fetchNowPlayingMovies() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('${AppConfig.baseUrl}/movie/now_playing?api_key=${AppConfig.apiKey}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        nowPlayingMovies = data['results'];
      } else {
        throw Exception("Failed to load now playing movies");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching now playing movies: $error");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
