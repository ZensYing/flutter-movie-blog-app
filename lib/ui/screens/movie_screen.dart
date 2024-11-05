// lib/ui/screens/movie_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch movies from all categories when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieProvider = Provider.of<MovieProvider>(context, listen: false);
      movieProvider.fetchTrendingMovies();
      movieProvider.fetchPopularMovies();
      movieProvider.fetchUpcomingMovies();
      movieProvider.fetchNowPlayingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    // Combine all movie lists into one
    final allMovies = [
      ...movieProvider.trendingMovies,
      ...movieProvider.popularMovies,
      ...movieProvider.upcomingMovies,
      ...movieProvider.nowPlayingMovies,
    ];

    // Filter movies based on the search query
    final filteredMovies = allMovies.where((movie) {
      final title = movie['title'] ?? movie['name'] ?? '';
      return title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title:const  Text("Movies"),
        backgroundColor: const Color.fromARGB(255, 3, 195, 195),
        actions: [
          IconButton(
            icon:const  Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.tealAccent))
          : ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                final title = movie['title'] ?? movie['name'] ?? 'No Title';
                final posterPath = movie['poster_path'];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Movie Poster
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w200$posterPath',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100,
                                height: 150,
                                color: Colors.grey[800],
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Movie Title and Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style:const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                movie['overview'] ?? 'No description available',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text("Search Movies", style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter movie name",
              hintStyle: const TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.tealAccent),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = _searchController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text("Search", style: TextStyle(color: Colors.tealAccent)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
                Navigator.of(context).pop();
              },
              child: const Text("Clear", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
