// movie_service.dart
import '../models/movie.dart';
import 'api_service.dart';
import '../config/app_config.dart';

class MovieService {
  final ApiService _apiService = ApiService();

  Future<List<Movie>> fetchTrendingMovies() async {
    final data = await _apiService.getRequest(AppConfig.trendingMoviesEndpoint);
    final List results = data['results'];
    return results.map((movieData) => Movie.fromJson(movieData)).toList();
  }
}
