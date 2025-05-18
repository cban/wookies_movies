import 'package:flutter/material.dart';

import '../../data/model/movies/movie.dart';
import '../../data/model/movies/movie_data.dart';
import '../detail/movie_detail_page.dart';
import '../widgets/movie_item_widget.dart';

class MovieListContent extends StatelessWidget {
  final List<Movie> movies;

  const MovieListContent({required this.movies, super.key});

  @override
  Widget build(BuildContext context) {
    final groupedMovies = _groupMoviesByGenre(movies);
    final sortedGenres = groupedMovies.keys.toList()..sort();

    return ListView.builder(
      itemCount: sortedGenres.length,
      itemBuilder: (context, index) {
        final genre = sortedGenres[index];
        final moviesForGenre = groupedMovies[genre] ?? [];

        if (moviesForGenre.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                genre,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: moviesForGenre.length,
                itemBuilder: (context, movieIndex) {
                  final movie = moviesForGenre[movieIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: MovieItemWidget(
                      data: MovieItemData(
                        title: movie.title,
                        imagePath: movie.poster,
                        onTap: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      MovieDetailPage(movieId: movie.id),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

Map<String, List<Movie>> _groupMoviesByGenre(List<Movie> movies) {
  final Map<String, List<Movie>> mappedGenre = {};

  for (final movie in movies) {
    for (final genre in movie.genres) {
      mappedGenre.putIfAbsent(genre, () => []);
      mappedGenre[genre]?.add(movie);
    }
  }

  return mappedGenre;
}
