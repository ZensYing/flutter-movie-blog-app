// movie_card.dart
import 'package:flutter/material.dart';
import '../../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
        title: Text(movie.title),
        subtitle: Text(movie.overview),
      ),
    );
  }
}
